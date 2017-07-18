############################################################
###                      analysis                        ###
############################################################

read.file.R -> 
bg_motif.R -> 
    explore.R 
    common.circRNA.R 
    location.R, ontology.R
    exon.R
    on_genome.R


--------------------------------------

File: read.file.R

Description: This R script reads the master file and the detected circRNAs for downstream analysis

--------------------------------------

Files: bg_motif.R

Description: These R scripts are used to conduct motif analysis

--------------------------------------

File: explore.R

Description: This R script conducts exploratory analysis for the detected circRNA

--------------------------------------

File: common.circRNA.R

Description: This R script investigates circRNAs that are commonly bound by a lot of RBPs and uses non-background circRNAs to find RBP modules

--------------------------------------

File: location.R

Description: This R script explores some basic properties of RBP binding sites on circRNAs

--------------------------------------

File: ontology.R

Description: This R script investigates whether the bound circRNAs are enriched in a certain ontology category

--------------------------------------

File: exon.R

Description: This R script investigates whether some RBPs tend to bind circRNAs whose ends do not sit on exon-intron boundaries

--------------------------------------

File: on_genome.R

Description: This R script analyzes CLIP-Seq reads that are mapped to whole circRNA sequences from genome, rather than linearized circRNA sequences

--------------------------------------





