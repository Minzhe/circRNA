#PBS -S /bin/bash
#PBS -q qbrc
#PBS -l nodes=1:ppn=8
#PBS -e ./error.qsub
#PBS -o ./log.qsub

### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048976_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048976_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048976_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048976_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048976_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048976_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048976_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048977_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048977_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048977_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048977_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048977_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048977_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048977_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048976_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/SRR048977_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP12/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP12//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP12/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.fastq AGATCGGAAGAGCGGTT 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.fastq.removed 5TTAA 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.fastq AGATCGGAAGAGCGGTT 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.fastq.removed 5TGGC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196183_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/ERR196190_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP54/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP54//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP54/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.fastq 5GGCG 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.fastq.removed AGATCGGAAGAGCGGTTCAGCAGGAA 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.fastq 5TGGC 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.fastq.removed AGATCGGAAGAGCGGTTCAGCAGGAA 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269760_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/SRR1269761_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP116/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/mm9_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP116//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP116/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/mm9_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176638_1.fastq TCTCACGTCGTATGCCGTCTTC 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176638_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176638_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176638_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176638_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176638_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176638_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176639_1.fastq TCTCACGTCGTATGCCGTCTTC 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176639_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176639_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176639_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176639_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176639_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176639_1.circ.txt 5 0.15 12 0

### task3
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176641_1.fastq TCTCCATTCGTATGCCGTCT 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176641_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176641_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176641_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176641_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176641_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176641_1.circ.txt 5 0.15 12 0

### task4
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176640_1.fastq TCTCCATTCGTATGCCGTCT 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176640_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176640_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176640_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176640_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176640_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176640_1.circ.txt 5 0.15 12 0

### task5
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176643_1.fastq TCTCCCATCGTATGCCGTC 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176643_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176643_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176643_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176643_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176643_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176643_1.circ.txt 5 0.15 12 0

### task6
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176642_1.fastq TCTCCCATCGTATGCCGTC 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176642_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176642_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176642_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176642_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176642_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176642_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176638_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176639_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176641_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176640_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176643_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/SRR1176642_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP225/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP225//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP225/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
