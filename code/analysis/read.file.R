###############################################################
###                    read.file.R                          ###
###############################################################
# This R script reads the master file and the detected circRNAs for downstream analysis

setwd("~/projects/circRNA")

hg19_anno <- read.table("~/data/genomes/hg19/hg19_anno_flat.txt", header = TRUE, quote = "", stringsAsFactors = FALSE, sep = "\t", comment = "")
mm9_anno <- read.table("~/data/genomes/mm9/mm9_anno_flat.txt", header = TRUE, quote = "", stringsAsFactors = FALSE, sep = "\t", comment = "")
dm3_anno <- read.table("~/data/genomes/dm3/dm3_anno_flat.txt", header = TRUE, quote = "", stringsAsFactors = FALSE, sep = "\t", comment = "")
anno <- list(Human = hg19_anno, Mouse = mm9_anno, Drosophila = dm3_anno)

#################    　read data     ########################
master <- read.table("docs/CLIP_Seq_data_v11.txt", stringsAsFactor = F, sep = "\t", header = T, quote = "")
data <- list()
for (j in 1:dim(master)[1]) {
    print(j)
    data[[paste("Study", j)]] <- read_circRNA(master$Id[j], master$Protein[j], master$Species[j], 
                                              master$Experiment[j], master$Cell_line[j], master$Study[j], 
                                              master$GSE[j], master$Treatment[j])
}
save(data, file = "data/analysis/circRNA_all.RData")



################       functions       #####################

### ------------- find_gene ---------------- ###
# Retrieve gene name from annotation file based on species, chr, strand, start, end information
find_gene <- function(species, chr, strand, start, end) {
    anno_species <- anno[[species]]
    subset <- (anno_species$chrom == chr) & (anno_species$txStart < start) & (anno_species$txEnd > end)
    sens_genes <- unique(anno_species[subset & (anno_species$strand == strand), "name2"])
    antisens_genes <- unique(anno_species[subset & (anno_species$strand != strand), "name2"])
    tmp <- c(paste(sens_genes, "sens", sep = ":"), paste(antisens_genes, "antisens", sep = ":"))
    paste(tmp[!tmp %in% c(":sens", ":antisens")], collapse = "|")
}

### ------------- read_circRNA ---------------- ###
# 
read_circRNA <- function(id, protein, species, experiment, cell_line, study, GSE, treatment) {
    folder <- paste("data/circRNA/", id, sep = "")
    file <- paste(folder, "/all_circ.txt", sep = "")
    
    # accessory information
    total <- readLines(file, n = 1)
    total <- as.numeric(strsplit(total, " ")[[1]][4])
    circRNA <- read.table(file, skip = 1, stringsAsFactor = FALSE, sep = "\t", header = TRUE)
    circRNA$circ <- paste(circRNA$chr, circRNA$start, circRNA$end, circRNA$strand) # circRNA name
    
    # circRNA
    if (dim(circRNA)[1] > 0) {    # find parental gene
        for (i in 1:dim(circRNA)[1]) {
            circRNA$parent[i] <- find_gene(species, circRNA$chr[i], circRNA$strand[i], circRNA$start[i], circRNA$end[i])
        }
    }
    
    if ("linear_binding_sites.txt" %in% list.files(folder)) {     # binding sites of RBP on linear transcripts
        linear_binding_sites <- read.table(paste(folder, "/linear_binding_sites.txt", sep = ""), stringsAsFactors = FALSE)
        colnames(linear_binding_sites) <- c("chr", "start", "end", "dummy1", "dummy2", "strand")
        for (i in 1:dim(linear_binding_sites)[1]) {               # find gene for each cluster
            linear_binding_sites$parent[i] <- find_gene(species, linear_binding_sites$chr[i], linear_binding_sites$strand[i], linear_binding_sites$start[i], linear_binding_sites$end[i])
        }
    } else { linear_binding_sites <- NULL }
    
    # randomly sample some reads mapped to linear transcript
    sam_files <- list.files(folder, pattern = ".sam", full = TRUE)
    linear_reads <- c()
    for (sam_file in sam_files) {
        tmp <- strsplit(readLines(sam_file, n = round(3000/length(sam_files))), split = "\t")
        if (length(tmp) == 0) { next }
        linear_reads <- rbind(linear_reads, t(sapply(1:length(tmp), function(i) tmp[[i]][1:4])))
    }
    linear_reads <- as.data.frame(linear_reads, stringsAsFactors = FALSE)
    linear_reads[,2] <- as.numeric(linear_reads[,2])
    linear_reads[,4] <- as.numeric(linear_reads[,4])
    linear_reads <- linear_reads[!grepl("^@", linear_reads[,1], perl = T),]
    linear_reads <- linear_reads[!grepl("circ", linear_reads[,3], perl = T),]
    linear_reads <- linear_reads[linear_reads[,2] %in% c(0, 16),]
    linear_reads[,2] <- ifelse(linear_reads[,2] == 0, "+", "-")
    colnames(linear_reads) <- c("name", "strand", "chr", "start")

    for (i in 1:dim(linear_reads)[1]) {
        linear_reads$parent[i] <- find_gene(species, linear_reads$chr[i], linear_reads$strand[i], linear_reads$start[i], linear_reads$start[i] + 1)
    }
    
    list(internal_id = id, total = total, circRNA = circRNA, protein = protein, species = species, 
         experiment = experiment, cell_line = cell_line, linear_reads = linear_reads, 
         linear_binding_sites = linear_binding_sites, study = study, GSE = GSE, treatment = treatment)
}

