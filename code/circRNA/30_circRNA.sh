#PBS -S /bin/bash
#PBS -q qbrc
#PBS -l nodes=1:ppn=8
#PBS -e ./error.qsub
#PBS -o ./log.qsub

### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.fastq 5AGGA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.fastq.removed GTGTCAGTCACTTCCAGCGGGGGTCAGTAAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.fastq 5AGGA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.fastq.removed GTGTCAGTCACTTCCAGCGGGGGTCAGTAAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.circ.txt 5 0.15 12 0

### task3
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.fastq 5AGGA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.fastq.removed GTGTCAGTCACTTCCAGCGGGGGTCAGTAAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.circ.txt 5 0.15 12 0

### task4
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.fastq 5AGGA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.fastq.removed GTGTCAGTCACTTCCAGCGGGGGTCAGTAAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.circ.txt 5 0.15 12 0

### task5
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.fastq 5AGGA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.fastq.removed GTGTCAGTCACTTCCAGCGGGGGTCAGTAAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.circ.txt 5 0.15 12 0

### task6
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.fastq 5AGGA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.fastq.removed GTGTCAGTCACTTCCAGCGGGGGTCAGTAAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.circ.txt 5 0.15 12 0

### task7
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.fastq 5AGGA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.fastq.removed GTGTCAGTCACTTCCAGCGGGGGTCAGTAAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.circ.txt 5 0.15 12 0

### task8
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.fastq 5AGGA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.fastq.removed GTGTCAGTCACTTCCAGCGGGGGTCAGTAAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871033_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871026_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871027_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871028_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871029_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871030_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871031_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/SRR871032_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP32/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/mm9_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP32//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP32/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/mm9_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.fastq.removed GTGGAATTCTCGGGTGCCAAGGAACTCCAG 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.fastq.removed GTGGAATTCTCGGGTGCCAAGGAACTCCAG 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.circ.txt 5 0.15 12 0

### task3
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.fastq.removed GTGGAATTCTCGGGTGCCAAGGAACTCCAG 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.circ.txt 5 0.15 12 0

### task4
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.fastq.removed GTGGAATTCTCGGGTGCCAAGGAACTCCAG 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847346_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847347_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847352_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/SRR847353_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP71/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP71//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP71/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/SRR1732275_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/SRR1732275_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/SRR1732275_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/SRR1732275_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/SRR1732275_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/SRR1732275_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/SRR1732275_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/SRR1732275_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP200/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP200//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP200/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.fastq 5AGGGAGGACGATGCGG 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.fastq.removed AGATAGGAAGAGCTCGTATGCCGTCTTCTGCTTGAAAAAA 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.fastq.removed
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.fastq.removed.removed TGTCAGTCAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.fastq.removed.removed
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.fastq.removed.removed.removed 5TGGAAGTGACTGACAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.fastq.removed.removed.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.fastq.removed.removed.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.fastq.removed.removed.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/SRR956945_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/Control4/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control4//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/Control4/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
