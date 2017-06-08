###############################################################
###                        job.pl                           ###
###############################################################
# This perl script writes shell scripts and submits them. The shell scripts handle adaptor removal, alignment and circRNA detection
#!/usr/bin/perl
use strict;
use warnings;
use IO::Pipe;

my (%fh, $process, @items_clip, @items_adaptor, $clip_dir, $sample, $i);
my ($sample1, @fastq, %adaptor, @adaptors, $bg_circRNA);
my $master_file = "/qbrc/home/mzhang/projects/circRNA/docs/CLIP_Seq_data_v11.txt";
my $circ_dir = "/qbrc/home/mzhang/projects/circRNA/data/circRNA/";
my $genome_dir = "/qbrc/home/mzhang/projects/circRNA/data/library/";
my $homer_dir = "/qbrc/home/mzhang/projects/circRNA/shiny/www/";
my %ref_genome = (Human => "hg19", Mouse => "mm9", Drosophila => "dm3");
my $process_n = 40; # number of qsub jobs to split all samples into

############  prepare for shell jobs  ##############

foreach $process (1 .. $process_n) {
	$fh{$process} = IO::Pipe->new();
	open($fh{$process}, ">" . $process . "_circRNA.sh");
    print {$fh{$process}} '#PBS -S /bin/bash' . "\n";
	print {$fh{$process}} '#PBS -q qbrc' . "\n";
	print {$fh{$process}} '#PBS -l nodes=1:ppn=8' . "\n";
	print {$fh{$process}} '#PBS -e ./error.qsub' . "\n";
	print {$fh{$process}} '#PBS -o ./log.qsub' . "\n\n";
}

open(FILE, $master_file) or die "Open file failed!";
<FILE>;
$process = 0;

############  assign task to each job  #############

#my %jobs = (CLIP32 => 1);

while (<FILE>) {
	# write into shell script
	if ($process == $process_n) {$process = 0;}
	$process++;

	# read master file
	@items_clip = split("\t", $_);
	# if (! exists $jobs{$items_clip[0]}) {next;}
	$clip_dir = $circ_dir . $items_clip[0] . "/";
	
	# extract fastq files
	$items_clip[1] =~ s/\s*\n//;
	@fastq = split('\|', $items_clip[1]);
	foreach (@fastq) {
		$_ =~ /.*\/(.*?)\..*/;
		$_ = $1 . "_1.fastq";
		if (! -e $clip_dir . $_) {die $clip_dir . $_ . " doesn't exists!";}
	}

	# find adaptor for each fastq file
	%adaptor = ();
	open(ADAPTOR, $clip_dir . "adaptor.txt") or die "No adaptor file exists for " . $clip_dir . "!";
	foreach (<ADAPTOR>) {
		$_ =~ s/\s*\n//;
		if ($_ eq "") {next;} 
		@items_adaptor = split(" ", $_);

		if (! defined $items_adaptor[1]) {$items_adaptor[1] = "not found";}
		$adaptor{$items_adaptor[0]} = $items_adaptor[1];
	}
	close(ADAPTOR);

	# assign task
	foreach $i (0 .. $#fastq) {
		print {$fh{$process}} "### task" . ($i + 1) . "\n";
		$sample = $fastq[$i];

		# remove adaptor
		if ($adaptor{$sample} !~ /not found/) {
		print {$fh{$process}} "# remove adaptor\n";
			@adaptors = split(",", $adaptor{$sample});
			foreach (@adaptors) {		# trim each adaptor iteratively
				print {$fh{$process}} "perl ~/projects/Clirc/bin/remove_adaptor.pl fastq " . $clip_dir . $sample . " " . $_ . " 18 0.2 10 unique\n";
				if ($sample =~ /removed/) {print {$fh{$process}} "rm -f " . $clip_dir . $sample . "\n";}
				$sample .= ".removed";
			}
		}

		# alignment to circRNA on genome
		print {$fh{$process}} "# align to circRNA on genome\n";
		print {$fh{$process}} "gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D ";
		print {$fh{$process}} $genome_dir . $ref_genome{$items_clip[5]} . "/gsnap -d circRNA_on_genome " . $clip_dir . $sample . " | awk '{print \$1\"\\t\"\$2\"\\t\"\$3}' > ";
		$sample1 = $sample;
		$sample1 =~ s/fastq.*$/on_genome.txt/;
		print {$fh{$process}} $clip_dir . $sample1 . "\n";

		# alignment to reference+circRNA
		print {$fh{$process}} "# align to reference+circRNA\n";
		print {$fh{$process}} "gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D ";
		print {$fh{$process}} $genome_dir . $ref_genome{$items_clip[5]} . "/gsnap -d circRNA " . $clip_dir . $sample . " > ";
		$sample =~ s/fastq.*$/sam/;
		print {$fh{$process}} $clip_dir . $sample . "\n";

		# detect circRNA
		print {$fh{$process}} "# detect circRNA\n";
		print {$fh{$process}} "perl ~/projects/Clirc/bin/find_circRNA.pl " . $clip_dir . $sample . " ";
		$sample =~ s/sam*$/circ.txt/;
		print {$fh{$process}} $clip_dir . $sample . " 5 0.15 12 0\n\n";

		$fastq[$i] = $sample;
	}

	# filter circRANs
	print {$fh{$process}} "### filter circRNA\n" ;
	print {$fh{$process}} "perl ~/projects/circRNA/code/circRNA/filter_circRNA.pl 2 0.34 20 " . $clip_dir . "all_circ.txt " . "/qbrc/home/mzhang/projects/circRNA/data/library/ ";
	map {print {$fh{$process}} $clip_dir . $_ . " "} @fastq;
	print {$fh{$process}} "\n";

	# motif analysis for linear reads
	$bg_circRNA = "/qbrc/home/mzhang/projects/circRNA/data/analysis/motif/" . $ref_genome{$items_clip[5]} . "_bg.fa";
	
	print {$fh{$process}} "### motif analysis for linear reads\n";
	print {$fh{$process}} "cat " . $clip_dir . "*.sam | grep chr | grep -v circ | awk '{if (\$2==0) {print \$10}}' | uniq | ";
	print {$fh{$process}} "awk 'BEGIN {i=0} {if (i++ % 100==0) {print \">seq\"i\"\\n\"\$0}}' > " . $clip_dir . "linear_reads_motif\n";
	print {$fh{$process}} "perl /qbrc/software/HOMER/bin/findMotifs.pl " . $clip_dir . "/linear_reads_motif fasta " . $homer_dir . $items_clip[0] . "/motifResults_linear/ ";
	print {$fh{$process}} "-p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg " . $bg_circRNA . "\n";

	# motif analysis for circRNA reads
	print {$fh{$process}} "### motif analysis for circRNA reads\n";
	print {$fh{$process}} "perl /qbrc/software/HOMER/bin/findMotifs.pl " . $clip_dir . "/all_circ.txt_motif fasta " . $homer_dir . $items_clip[0] . "/motifResults/ ";
	print {$fh{$process}} "-p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg " . $bg_circRNA . "\n\n";
	
	print {$fh{$process}} "#########################################################################\n\n";
}

##############  submit each job  ###############

# foreach $process (1 .. $process_n) {
	# close($fh{$process});
	# system("qsub " . $process . "_circRNA.sh");
	# sleep(2);
	# unlink($process . "_circRNA.sh");
# }

close(FILE);

