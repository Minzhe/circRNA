#PBS -S /bin/bash
#PBS -q qbrc
#PBS -l nodes=1:ppn=8
#PBS -e ./error.qsub
#PBS -o ./log.qsub

### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189775_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189775_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189775_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189775_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189775_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189775_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189775_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189776_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189776_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189776_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189776_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189776_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189776_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189776_1.circ.txt 5 0.15 12 0

### task3
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189777_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189777_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189777_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189777_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189777_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189777_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189777_1.circ.txt 5 0.15 12 0

### task4
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189778_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189778_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189778_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189778_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189778_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189778_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189778_1.circ.txt 5 0.15 12 0

### task5
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189780_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189780_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189780_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189780_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189780_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189780_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189780_1.circ.txt 5 0.15 12 0

### task6
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189779_1.fastq TCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189779_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189779_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189779_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189779_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189779_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189779_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189775_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189776_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189777_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189778_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189780_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/SRR189779_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP30/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP30//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP30/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653238_1.fastq GATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653238_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653238_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653238_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653238_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653238_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653238_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653237_1.fastq GATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653237_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653237_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653237_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653237_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653237_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653237_1.circ.txt 5 0.15 12 0

### task3
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653236_1.fastq GATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653236_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653236_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653236_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653236_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653236_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653236_1.circ.txt 5 0.15 12 0

### task4
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653235_1.fastq GATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAA 18 0.2 10 unique
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653235_1.fastq.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653235_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653235_1.fastq.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653235_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653235_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653235_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653238_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653237_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653236_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/SRR653235_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP69/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP69//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP69/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.fastq 5GGCG 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.fastq.removed TAGATCGGAAGAGCGGTTCAGCAGGAATGCC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.circ.txt 5 0.15 12 0

### task2
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.fastq 5CCGG 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.fastq.removed TAGATCGGAAGAGCGGTTCAGCAGGAATGCC 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/mm9/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713796_1.circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/SRR1713797_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP131/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/mm9_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/CLIP131//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/CLIP131/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/mm9_bg.fa

#########################################################################
### task1
# remove adaptor
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.fastq GAGCACACGTCTGAACTCCAGTCACTAGCTTATC 18 0.2 10 unique
perl ~/projects/Clirc/bin/remove_adaptor.pl fastq /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.fastq.removed TCGTATGCCGTCTTCTGCTTGAAAA 18 0.2 10 unique
rm -f /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.fastq.removed
# align to circRNA on genome
gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 --merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA_on_genome /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.fastq.removed.removed | awk '{print $1"\t"$2"\t"$3}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.on_genome.txt
# align to reference+circRNA
gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 --merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries -D /qbrc/home/mzhang/projects/circRNA/data/library/hg19/gsnap -d circRNA /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.fastq.removed.removed > /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.sam
# detect circRNA
perl ~/projects/Clirc/bin/find_circRNA.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.sam /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.circ.txt 5 0.15 12 0

### find circRNA
perl ~/projects/Clirc/bin/filter_circRNA.pl 2 0.34 20 /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/all_circ.txt /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/SRR1732274_1.circ.txt 
### motif analysis for linear reads
cat /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/*.sam | grep chr | grep -v circ | awk '{if ($2==0) {print $10}}' | uniq | awk 'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\n"$0}}' > /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2/linear_reads_motif
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2//linear_reads_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/Control2/motifResults_linear/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa
### motif analysis for circRNA reads
perl /qbrc/software/HOMER/bin/findMotifs.pl /qbrc/home/mzhang/projects/circRNA/data/circRNA/Control2//all_circ.txt_motif fasta /qbrc/home/mzhang/projects/circRNA/shiny/www/Control2/motifResults/ -p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 -fastaBg /qbrc/home/mzhang/projects/circRNA/data/analysis/motif/hg19_bg.fa

#########################################################################
