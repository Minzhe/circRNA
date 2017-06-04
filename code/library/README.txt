############################################################
###                      library                         ###
############################################################

CIRI.sh -> 
	CIRI
		CIRI_v2.0.5.pl
build_library.sh -> 
    circRNA2region.pl
	Clirc
		index.pl
		query.pl
		
Notice: you need to specify the CIRI and Clirc path in corresponding file.

		
--------------------------------------

File: CIRI.sh

Description: This shell scritps aligns PE fastq files to reference genomes and extracts the circRNAs using CIRI

--------------------------------------

File: build_library.sh

Description: This shell script contains the codes to build circRNA libraries and extract sequence for open reading frame identification

--------------------------------------





--------------------------------------

Software: CIRI

Description: Ths CIRI software, downloaded from http://sourceforge.net/projects/ciri/

--------------------------------------

--------------------------------------

Software: Clirc

Description: Ths Clirc software, downloaded from https://github.com/Minzhe/Clirc

--------------------------------------



