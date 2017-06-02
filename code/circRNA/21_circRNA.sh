#PBS -S /bin/bash
#PBS -q qbrc
#PBS -l nodes=1:ppn=8
#PBS -e ./error.qsub
#PBS -o ./log.qsub

### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048987_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048987_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048987_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048987_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048987_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048987_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048987_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048986_1.fastq ACGTTGATAGGCCGGGTGTGTAAGCGCAGCG 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048986_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048986_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048986_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048986_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048986_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048986_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048987_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/SRR048986_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP21/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP21//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP21/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.fastq.removed GTGTCAGTCAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.fastq.removed GTGTCAGTCAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.circ.txt 5 0.15 12 0

### task3
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.fastq.removed GTGTCAGTCAC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553155_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553156_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/SRR1553157_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP63/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/mm9_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP63//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP63/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/mm9_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.fastq 5CAAT 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.fastq.removed TGAGATCGGAAGAGCGGTTCAGC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.fastq 5CAAT 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.fastq.removed TGAGATCGGAAGAGCGGTTCAGC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.circ.txt 5 0.15 12 0

### task3
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.fastq 5ACCT 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.fastq.removed TGAGATCGGAAGAGCGGTTCAGC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.circ.txt 5 0.15 12 0

### task4
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.fastq 5ACCT 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.fastq.removed TGAGATCGGAAGAGCGGTTCAGC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/dm3/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659985_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659984_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659987_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/SRR1659986_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP124/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/dm3_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP124//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP124/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/dm3_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390466_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390466_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390466_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390466_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390466_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390466_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390466_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390467_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390467_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390467_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390467_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390467_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390467_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390467_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390466_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/SRR390467_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP237/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP237//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP237/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
