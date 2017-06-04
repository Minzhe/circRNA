#########################################################################
###                             CIRI.pl                               ###
#########################################################################
# This shell script is to use CIRI software to identify circRNA from RNA-seq data

#PBS -S /bin/bash
#PBS -q qbrc
#PBS -l nodes=1:ppn=12
#PBS -e ./CIRI.error.qsub
#PBS -o ./CIRI.log.qsub

#############  mm9  ########################

cd ~/projects/circRNA/data/library/mm9/CIRI
/qbrc/software/bwa-0.7.15/bwa index -a bwtsw ~/data/genomes/mm9/mm9_masked.fa

/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF001NCP.fastq ~/data/ENCODE/mm/ENCFF001NCT.fastq > mm_encode1.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF001NCR.fastq ~/data/ENCODE/mm/ENCFF001NCV.fastq > mm_encode2.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF001NDA.fastq ~/data/ENCODE/mm/ENCFF001NDF.fastq > mm_encode3.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF001NDD.fastq ~/data/ENCODE/mm/ENCFF001NDH.fastq > mm_encode4.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF001RTD.fastq ~/data/ENCODE/mm/ENCFF001RTA.fastq > mm_encode5.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF001RTN.fastq ~/data/ENCODE/mm/ENCFF001RTM.fastq > mm_encode6.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF002EZW.fastq ~/data/ENCODE/mm/ENCFF002EZX.fastq > mm_encode7.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF002EZY.fastq ~/data/ENCODE/mm/ENCFF002EZZ.fastq > mm_encode8.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF002FAA.fastq ~/data/ENCODE/mm/ENCFF002FAB.fastq > mm_encode9.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF002FAC.fastq ~/data/ENCODE/mm/ENCFF002FAD.fastq > mm_encode10.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF002FAG.fastq ~/data/ENCODE/mm/ENCFF002FAH.fastq > mm_encode11.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF002FAI.fastq ~/data/ENCODE/mm/ENCFF002FAJ.fastq > mm_encode12.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF533AUL.fastq ~/data/ENCODE/mm/ENCFF366KMQ.fastq > mm_encode13.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF426QFT.fastq ~/data/ENCODE/mm/ENCFF631HGH.fastq > mm_encode14.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF902XHK.fastq ~/data/ENCODE/mm/ENCFF344IMT.fastq > mm_encode15.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/mm9/mm9_masked.fa ~/data/ENCODE/mm/ENCFF106GQS.fastq ~/data/ENCODE/mm/ENCFF797ZCH.fastq > mm_encode16.sam 

perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode1.sam -O mm_encode1_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output1.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode1.sam -O mm_encode1_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output2.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode2.sam -O mm_encode2_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output3.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode3.sam -O mm_encode3_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output4.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode4.sam -O mm_encode4_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output5.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode5.sam -O mm_encode5_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output6.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode6.sam -O mm_encode6_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output7.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode7.sam -O mm_encode7_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output8.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode8.sam -O mm_encode8_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output9.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode9.sam -O mm_encode9_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output10.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode10.sam -O mm_encode10_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output11.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode11.sam -O mm_encode11_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output12.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode12.sam -O mm_encode12_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output13.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode13.sam -O mm_encode13_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output14.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode14.sam -O mm_encode14_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output15.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode15.sam -O mm_encode15_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output16.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I mm_encode16.sam -O mm_encode16_circRNA.txt -F ~/data/genomes/mm9/mm9_masked.fa -A ~/data/genomes/mm9/ucsc.mm9.gtf -G CIRI_output17.log
cat *circRNA* | grep -v circRNA_ID | awk '{print $2"\t"$3"\t"$4}' | sort | uniq > ../mm9_CIRI.txt

##############  dm3  #########################

cd ~/projects/circRNA/data/library/dm3/CIRI
/qbrc/software/bwa-0.7.15/bwa index -a bwtsw ~/data/genomes/dm3/dm3_masked.fa

#bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ENCFF140SNH.fastq ENCFF059PSV.fastq > dm_encode1.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF392BTI.fastq ~/data/ENCODE/dm/ENCFF020QAA.fastq > dm_encode2.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF638BSE.fastq ~/data/ENCODE/dm/ENCFF127MLN.fastq > dm_encode3.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF223XSV.fastq ~/data/ENCODE/dm/ENCFF721BUP.fastq > dm_encode4.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF225ZZQ.fastq ~/data/ENCODE/dm/ENCFF565OKT.fastq > dm_encode5.sam 
#bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ENCFF341VYX.fastq ENCFF890AVZ.fastq > dm_encode6.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF377IVY.fastq ~/data/ENCODE/dm/ENCFF874JXZ.fastq > dm_encode7.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF430LLK.fastq ~/data/ENCODE/dm/ENCFF837RJP.fastq > dm_encode8.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF899OIM.fastq ~/data/ENCODE/dm/ENCFF651NJB.fastq > dm_encode9.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF604XAU.fastq ~/data/ENCODE/dm/ENCFF837PPR.fastq > dm_encode10.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF731PKW.fastq ~/data/ENCODE/dm/ENCFF499TEB.fastq > dm_encode11.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF555ZMD.fastq ~/data/ENCODE/dm/ENCFF371NTQ.fastq > dm_encode12.sam 
#bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ENCFF806NGJ.fastq ENCFF287JEK.fastq > dm_encode13.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF948VCS.fastq ~/data/ENCODE/dm/ENCFF581LOO.fastq > dm_encode14.sam 
/qbrc/software/bwa-0.7.15/bwa mem -t 12 -T 19 ~/data/genomes/dm3/dm3_masked.fa ~/data/ENCODE/dm/ENCFF906LTK.fastq ~/data/ENCODE/dm/ENCFF756XIZ.fastq > dm_encode15.sam 

#perl ~/iproject/circRNA/code/library/CIRI/CIRI_v1.2.pl -P -E -U 3 -B 13 -RE 0.01 -I dm_encode1.sam -O dm_encode1_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/dm3.gtf -G CIRI_output.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode2.sam -O dm_encode2_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output2.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode3.sam -O dm_encode3_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output3.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode4.sam -O dm_encode4_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output4.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode5.sam -O dm_encode5_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output5.log
#perl ~/iproject/circRNA/code/library/CIRI/CIRI_v1.2.pl -P -E -U 3 -B 13 -RE 0.01 -I dm_encode6.sam -O dm_encode6_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/dm3.gtf -G CIRI_output.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode7.sam -O dm_encode7_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output7.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode8.sam -O dm_encode8_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output8.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode9.sam -O dm_encode9_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output9.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode10.sam -O dm_encode10_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output10.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode11.sam -O dm_encode11_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output11.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode12.sam -O dm_encode12_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output12.log
#perl ~/iproject/circRNA/code/library/CIRI/CIRI_v1.2.pl -P -E -U 3 -B 13 -RE 0.01 -I dm_encode13.sam -O dm_encode13_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/dm3.gtf -G CIRI_output.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode14.sam -O dm_encode14_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output14.log
perl ~/software/CIRI_v2.0.5/CIRI_v2.0.5.pl -U 3 -E 0.01 -I dm_encode15.sam -O dm_encode15_circRNA.txt -F ~/data/genomes/dm3/dm3_masked.fa -A ~/data/genomes/dm3/ucsc.dm3.gtf -G CIRI_output15.log
cat *circRNA* | grep -v circRNA_ID | awk '{print $2"\t"$3"\t"$4}' | sort | uniq > ../dm3_CIRI.txt

##################  hg19  #####################

cd ~/projects/circRNA/data/library/hg19/CIRI
cat *ciri*.txt | grep -v circRNA_ID | awk '{print $1"\t"$2"\t"$3}' | sort | uniq > ../hg19_CIRI.txt


