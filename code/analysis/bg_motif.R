###############################################################
###                     bg_motif.R                          ###
###############################################################
# This R script create background sequences for motif analysis  

for (species in c("hg19", "mm9", "dm3")) {
    ### concatenate 3' end of upstream exon with 5' end of downstream exon
    genome <- paste("~/data/genomes/", species, "/", species, "_masked.fa", sep = "")
    anno <- read.table(paste("~/data/genomes/", species, "/", species, ".gtf", sep = ""), stringsAsFactors = FALSE)
    anno <- anno[anno[,3] == "exon", c(1,7,4,5,10)]
    colnames(anno) <- c("chr", "strand", "start", "end", "gene")
    all_genes <- unique(anno$gene)
    anno <- anno[anno$gene %in% all_genes[sample(1:length(all_genes), 2000)],]
    anno <- anno[anno$strand == "+",]
    anno5 <- anno3 <- anno
    anno5$end <- anno5$start + 15
    anno3$start <- anno3$end - 15
    
    # grep the sequences
    coords5 <- paste("~/projects/iproject/circRNA/data/analysis/motif/", species, "_coords5.txt", sep = "")
    coords3 <- paste("~/projects/iproject/circRNA/data/analysis/motif/", species, "_coords3.txt", sep = "")
    write.table(anno5, file = coords5, quote = FALSE, col.names = FALSE, row.names = FALSE, sep = "\t")
    write.table(anno3, file = coords3, quote = FALSE, col.names = FALSE, row.names = FALSE, sep = "\t")
    index <- paste("~/projects/iproject/circRNA/data/analysis/motif/", species, "_index.txt", sep = "")
    system(paste("perl ~/software/packages/Motif/index.pl ", genome, " ", index, sep = ""))
    seq5 <- paste("~/projects/iproject/circRNA/data/analysis/motif/", species, "_exon5.fa", sep = "")
    seq3 <- paste("~/projects/iproject/circRNA/data/analysis/motif/", species, "_exon3.fa", sep = "")
    system(paste("perl ~/software/packages/Motif/query.pl ", index, " ", genome, " ", coords5, " ", seq5, " 1"))
    system(paste("perl ~/software/packages/Motif/query.pl ", index, " ", genome, " ", coords3, " ", seq3, " 1"))
    seq5 <- read.table(seq5, stringsAsFactors = FALSE)
    seq3 <- read.table(seq3, stringsAsFactors = FALSE)
    
    # write to text file
    anno$header <- NA
    anno$seq <- NA
    for (i in 2:dim(anno)[1]) {
        if (anno$gene[i] != anno$gene[i-1]) { next } # the same gene
        if (anno$start[i] <= anno$end[i-1]) { next } # exon followed by another exon
        anno$header[i] <- paste(">", anno$gene[i], anno$chr[i], anno$end[i-1], anno$start[i], sep = "_")
        anno$seq[i] <- paste(seq3[2*(i-1),1], seq5[2*i,1], sep = "") 
    }
    
    anno <- anno[!is.na(anno$header),]
    seq <- paste("~/projects/iproject/circRNA/data/analysis/motif/", species, "_bg.fa", sep = "")
    write.table(paste(anno$header, anno$seq, sep = "\n"), file = seq, col.names = FALSE, row.names = FALSE, quote = FALSE)
}
