#########################################################################
###                        build_library.pl                           ###
#########################################################################
# This shell script is to build gsnap library

#PBS -S /bin/bash
#PBS -q qbrc
#PBS -l nodes=1:ppn=12
#PBS -e ./build_library.error.qsub
#PBS -o ./build_library.log.qsub

#############  dm3  #################
cd ~/projects/circRNA/data/library/dm3

perl ~/projects/Clirc/bin/circRNA2region.pl 50 dm3_circRNA_coordinates.txt dm3_CIRI.txt dm3_PMID25242144.txt dm3_PMID25544350.txt
perl ~/projects/Clirc/bin/index.pl ~/data/genomes/dm3/dm3_masked.fa dm3_index.txt 
perl ~/projects/Clirc/bin/query.pl dm3_index.txt ~/data/genomes/dm3/dm3_masked.fa dm3_circRNA_coordinates.txt dm3_halves.txt 1
perl ~/projects/Clirc/bin/half2library.pl dm3_halves.txt dm3_circRNA_large.fa
perl ~/projects/Clirc/bin/query.pl dm3_index.txt ~/data/genomes/dm3/dm3_masked.fa dm3_circRNA_coordinates.txt_on_genome dm3_circRNA_on_genome.fa 1 # change this

rm -f -r gsnap
mkdir gsnap
gmap_build -D gsnap -d circRNA ~/data/genomes/dm3/dm3_masked.fa dm3_circRNA.fa # reference genome+circRNA as pseudo chromosomes
gmap_build -D gsnap -d genome ~/data/genomes/dm3/dm3_masked.fa # reference genome only
# the following code will generate repetitive sequences in the index file for some circRNAs, but it's ok in the downstream analysis
gmap_build --build-sarray=0 -D gsnap -d circRNA_on_genome dm3_circRNA_on_genome.fa # circRNA sequence only (directly extracted from genome, not the joined ones)

############  hg19  ###############
cd ~/projects/circRNA/data/library/hg19

perl ~/projects/Clirc/bin/circRNA2region.pl 50 hg19_circRNA_coordinates.txt hg19_circbase.txt hg19_CIRI.txt hg19_PMID25921068.txt hg19_PolII.txt
perl ~/projects/Clirc/bin/index.pl ~/data/genomes/hg19/hg19_masked.fa hg19_index.txt
perl ~/projects/Clirc/bin/query.pl hg19_index.txt ~/data/genomes/hg19/hg19_masked.fa hg19_circRNA_coordinates.txt hg19_halves.txt 1
perl ~/projects/Clirc/bin/half2library.pl hg19_halves.txt hg19_circRNA.fa
perl ~/projects/Clirc/bin/query.pl hg19_index.txt ~/data/genomes/hg19/hg19_masked.fa hg19_circRNA_coordinates.txt_on_genome hg19_circRNA_on_genome.fa 1 # change this

rm -f -r gsnap
mkdir gsnap
gmap_build -D gsnap -d circRNA ~/data/genomes/hg19/hg19_masked.fa hg19_circRNA.fa			# This command require large RAM
gmap_build -D gsnap -d genome ~/data/genomes/hg19/hg19_masked.fa 							# This command require large RAM
gmap_build --build-sarray=0 -D gsnap -d circRNA_on_genome hg19_circRNA_on_genome.fa 

############  mm9  ################
cd ~/projects/circRNA/data/library/mm9

perl ~/projects/Clirc/bin/circRNA2region.pl 50 mm9_circRNA_coordinates.txt mm9_circBase.txt mm9_CIRI.txt mm9_PMID25921068.txt
#perl ~/software/packages/Motif/index.pl ~/data/genomes/mm9/mm9_masked.fa mm9_index.txt
#perl ~/software/packages/Motif/query.pl mm9_index.txt ~/data/genomes/mm9/mm9_masked.fa mm9_circRNA_coordinates.txt mm9_halves.txt 1
#perl ~/iproject/circRNA/code/library/half2library.pl mm9_halves.txt mm9_circRNA_large.fa
perl ~/projects/Clirc/bin/query.pl mm9_index.txt ~/data/genomes/mm9/mm9_masked.fa mm9_circRNA_coordinates.txt_on_genome mm9_circRNA_on_genome.fa 1 # change this

#rm -f -r gsnap
#mkdir gsnap
#gmap_build -D gsnap -d circRNA ~/data/genomes/mm9/mm9_masked.fa mm9_circRNA.fa
#gmap_build -D gsnap -d genome ~/data/genomes/mm9/mm9_masked.fa
gmap_build --build-sarray=0 -D gsnap -d circRNA_on_genome mm9_circRNA_on_genome.fa

