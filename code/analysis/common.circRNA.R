###############################################################
###                   common.circRNA.R                      ###
###############################################################
# This R script investigates circRNAs that are commonly bound by a lot of RBPs and uses non-background circRNAs to find RBP modules.


###########  read data  ############

load("data/analysis/circRNA.RData")
protein <- sapply(1:length(data), function(i) data[[i]]$protein)
control <- data[which(protein == "IgG")]
data <- data[which(protein != "IgG")]
protein <- sapply(1:length(data), function(i) data[[i]]$protein)
species <- sapply(1:length(data), function(i) data[[i]]$species)
cell_line <- sapply(1:length(data), function(i) data[[i]]$cell_line)
total <- sapply(1:length(data), function(i) data[[i]]$total)

############  find common circRNAs (human only)  ##############

common_circ <- c()
for (i in 1:length(protein)) {
    if (species[i] != "Human" || dim(data[[i]]$circRNA)[1] == 0) {
        next
    }
    data[[i]]$circRNA$protein <- data[[i]]$protein
    data[[i]]$circRNA$id <- data[[i]]$internal_id
    common_circ <- rbind(common_circ, data[[i]]$circRNA)
}

common_circ.RBP <- aggregate(common_circ$protein, by = list(common_circ$circ), function(x) paste(x, collapse = " "))
common_circ.parent <- aggregate(common_circ$parent, by = list(common_circ$circ), unique)
common_circ.n_study <- aggregate(common_circ$id, by = list(common_circ$circ), function(x) length(unique(x)))
common_circ.RBP <- common_circ.RBP[order(common_circ.RBP[, 1]), ]
common_circ.parent <- common_circ.parent[order(common_circ.parent[, 1]), ]
common_circ.n_study <- common_circ.n_study[order(common_circ.n_study[, 1]), ]
common_circ <- data.frame(common_circ.RBP, common_circ.parent[, 2], common_circ.n_study[, 2])
colnames(common_circ) <- c("circ", "protein", "parent", "ratio_study")
common_circ$parent <- as.vector(common_circ$parent)
common_circ$ratio_study <- common_circ$ratio_study / sum(species == "Human")    # proportion of studies with this circRNA detected
common_circ <- common_circ[order(-common_circ$ratio_study), ]

#############  mark artefacts  ###############

rownames(common_circ) <- common_circ$circ
common_circ$IgG <- FALSE            # some circRNAs that only appear in IgG will trail the matrix
for (i in 1:length(control)) {
    tmp.ratio <- table(control[[i]]$circRNA$circ) / control[[i]]$total
    common_circ[, paste("IgG", i, sep = "_")] = 0
    common_circ[names(tmp.ratio), paste("IgG", i, sep = "_")] <- tmp.ratio
    common_circ[names(tmp.ratio), "IgG"] <- TRUE
}

############  plot common circRNAs  ##############

options.default = options()
options(scipen = 999)
write.table(common_circ[, c("circ", "ratio_study", "IgG", "parent")],
            file = "data/analysis/common.txt",
            sep = "\t", quote = FALSE)

top <- 1:100      # show top circRNAs for the common circRNA graph
protein_human <- c(unique(protein[species == "Human"]), paste("IgG", 1:length(control), sep = "_"))
common_matrix <- matrix(0, nrow = length(top), ncol = length(protein_human), dimnames = list(top, protein_human))
for (i in top) {
    common_matrix[i, unique(strsplit(common_circ$protein[i], " ")[[1]])] <- 4       # circRNA bound to RBP
    tmp <- unlist(common_circ[i, paste("IgG", 1:length(control), sep = "_")])
    common_matrix[i, names(tmp[tmp > 0])] <- 3                                      # circRNA bound to IgG
    common_matrix[i, names(tmp[tmp == 0])] <- 2                                     # circRNA not bound to IgG
}

library("gplots")
pdf(file = "data/figures/common.pdf", width = 18, height = 15)
heatmap.2(common_matrix, Rowv = FALSE, Colv = FALSE, dendrogram = "none", trace = "none", density.info = "none")
dev.off()

##############  build RBP network based on circRNA co-occupance  ############

possible_common = !common_circ$IgG # mark possible background
possible_common[1:50] <- F

protein_human <- unique(protein[species == "Human"])
common_matrix <- matrix(0, nrow = sum(possible_common), ncol = length(protein_human), dimnames = list(common_circ$circ[possible_common], protein_human))
for (i in which(possible_common)) {       # number of reads for each circRNA bound by each RBP
    tmp <- table(strsplit(common_circ$protein[i], " ")[[1]])
    common_matrix[common_circ$circ[i], names(tmp)] <- tmp
}
common_matrix <- common_matrix[, apply(common_matrix, 2, sum) > 20]

# hypergeometric test to calculate similarity between proteins
hyper_mat <- matrix(0, nrow = dim(common_matrix)[2], ncol = dim(common_matrix)[2], dimnames = list(colnames(common_matrix), colnames(common_matrix)))
for (i in 1:dim(common_matrix)[2]) {
    for (j in 1:dim(common_matrix)[2]) {
        q <- sum(common_matrix[, i] > 0 & common_matrix[, j] > 0)
        m <- sum(common_matrix[, i] > 0)
        n <- sum(common_matrix[, i] == 0)
        k <- sum(common_matrix[, j] > 0)
        hyper_mat[i, j] <- phyper(q, m, n, k, lower.tail = FALSE)
    }
}

pdf(file = "data/figures/module.pdf", width = 12, height = 5)
plot(hclust(as.dist(hyper_mat), method = "complete"),
     xlab = "",
     ylab = "CircRNA binding profile dissimilarity",
     main = "Hierarchical clustering of RBPs"
)
dev.off()
