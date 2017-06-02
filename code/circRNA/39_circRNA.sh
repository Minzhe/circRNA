#PBS -S /bin/bash
#PBS -q qbrc
#PBS -l nodes=1:ppn=8
#PBS -e ./error.qsub
#PBS -o ./log.qsub

### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567525_1.fastq ATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567525_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567525_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567525_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567525_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567525_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567525_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567526_1.fastq ATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567526_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567526_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567526_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567526_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567526_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567526_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567525_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/SRR567526_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP41/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP41//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP41/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373361_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373361_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373361_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373361_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373361_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373361_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373361_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373360_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373360_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373360_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373360_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373360_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373360_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373360_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373361_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/SRR1373360_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP103/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP103//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP103/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640733_1.fastq TAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640733_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640733_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640733_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640733_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640733_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640733_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640734_1.fastq TAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640734_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640734_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640734_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640734_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640734_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640734_1.circ.txt 5 0.15 12 0

### task3
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640735_1.fastq TAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640735_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640735_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640735_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640735_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640735_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640735_1.circ.txt 5 0.15 12 0

### task4
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640736_1.fastq TAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640736_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640736_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640736_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640736_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640736_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640736_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640733_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640734_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640735_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/SRR1640736_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP209/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/dm3_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP209//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP209/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/dm3_bg.fa

#########################################################################
