###############################################################
###                    on_genome.R                          ###
###############################################################
# This R script analyzes CLIP-Seq reads that are mapped to whole circRNA sequences from genome, rather than linearized circRNA sequences


#########  load data  ##########

load("data/analysis/circRNA_all.RData")

######  find circRNAs that are bound by RBPs from all collected CLIP-Seq datasets  ####3
# this set of circRNAs are more likely to be true since they are the
# intersect of RNA-Seq and CLIP-Seq

all_circ <- c()
for (i in 1:length(data)) {
    if (dim(data[[i]]$circRNA)[1] == 0) {
        next
    }
    data[[i]]$circRNA$species <- data[[i]]$species
    data[[i]]$circRNA$circ <- paste(data[[i]]$circRNA$chr,
                                    data[[i]]$circRNA$start,
                                    data[[i]]$circRNA$end,
                                    sep = "_")
    data[[i]]$circRNA <- data[[i]]$circRNA[!duplicated(data[[i]]$circRNA$circ), ]
    all_circ <- rbind(all_circ, data[[i]]$circRNA)
}
all_circ <- all_circ[, c("chr", "start", "end", "circ", "species")]
all_circ$count <- 1
all_circ <- aggregate(all_circ$count, by = list(all_circ$circ, all_circ$species), sum)
all_circ <- all_circ[all_circ$x > 1, ]

all_circ_sp <- list(Human = all_circ$Group.1[all_circ$Group.2 == "Human"],
                   Mouse = all_circ$Group.1[all_circ$Group.2 == "Mouse"],
                   Drosophila = all_circ$Group.1[all_circ$Group.2 == "Drosophila"])

for (i in 1:length(data)) {
    print(i)
    folder <- paste("data/circRNA/", data[[i]]$internal_id, sep = "")
    
    # read CLIP-Seq reads that are mapped to circRNA sequences from genome rather than
    # linearized circRNA sequences
    on_genome <- 0
    for (file in list.files(folder, pattern = "on_genome", full = T)) {
        sam_file <- read.table(file, sep = "\t", header = F, stringsAsFactors = F)
        sam_file <- sam_file[sam_file[, 2] != 4, ]
        sam_file <- sam_file[sam_file[, 3] %in% all_circ_sp[[data[[i]]$species]], ]
        on_genome <- on_genome + dim(sam_file)[1]
    }
    data[[i]]$on_genome <- on_genome
}

x <- sapply(1:length(data), function(i) data[[i]]$total)
y <- sapply(1:length(data), function(i) data[[i]]$on_genome)
z <- sapply(1:length(data), function(i) data[[i]]$protein)

pdf(file <- "data/figures/test.pdf")
plot(x, y / x, type = "n")
text(x, y / x, lab = z)
dev.off()
