###############################################################
###                     ontology.R                          ###
###############################################################
# This R script investigates whether the bound circRNAs are enriched in a certain ontology category

#####  binding sites on linear transcripts of these RBPs will be studied  #########

linear <- c(15, 97, 120)

#########  read GO terms  ##########

go_file <- "~/data/c2.cp.v6.0.symbols.gmt"
gos <- c()
for (line in readLines(go_file)) {  # go terms and associated genes
    tmp <- strsplit(line, split = "\t")[[1]]
    if (length(tmp) > 2000) {       # GO term with proper sizes
        next
    }
    gos[[tmp[1]]] <- list(url = tmp[2], genes = tmp[-c(1:2)])
}
all_genes <- unique(unlist(sapply(1:length(gos), function(i) gos[[i]]$genes))) # all possible genes

#########  put circRNA-embeded genes in matrix format  ###########

# delete artefacts
common <- read.table("data/analysis/common.txt", sep = "\t")
common <- common[1:50,]

load("data/analysis/data.RData")
species <- sapply(1:length(data), function(i) data[[i]]$species) # must be human
protein <- sapply(1:length(data), function(i) data[[i]]$protein) # must be human
# the first part is human RBP binding sites on circRNA
# the second part is human RBP binding sites on linear transcripts
genes <- matrix(0, ncol = sum(species == "Human") + length(linear), nrow = length(all_genes), 
                dimnames = list(all_genes, c(names(data)[species == "Human"], linear)))

for (i in 1:dim(genes)[2]) {
    if (grepl("Study", colnames(genes)[i])) {
        subset <- data[[colnames(genes)[i]]]$circRNA$circ %in% rownames(common)
        parents <- data[[colnames(genes)[i]]]$circRNA$parent[!subset] # all circRNA studies
    } else {
        parents <- data[[as.numeric(colnames(genes)[i])]]$linear_binding_sites$parent # some RBPs' binding sites on linear transcripts
    }
    if (is.null(parents)) {
        next
    }
    parents <- unique(parents[parents != ""])
    parents <- unlist(strsplit(parents, split = "\\|"))
    parents <- unique(sub(":.*", "", parents, perl = T))
    if (sum(!parents %in% rownames(genes)) > 0) {   # genes must be from either GO terms or binding sites
        tmp <- matrix(0, nrow = sum(!parents %in% rownames(genes)), ncol = dim(genes)[2])
        rownames(tmp) <- parents[!parents %in% rownames(genes)]
        genes <- rbind(genes, tmp)
    }
    genes[parents, i] <- 1
}

#####  compare p values (raw) to p values of randomly sampled genes ###########

genes_weight <- apply(genes[, grepl("Study", colnames(genes))], 1, sum) # commonly appearing genes should also be sampled more
genes_weight[genes_weight == 0] <- 0.0001
rbp_total <- apply(genes, 2, sum) # total number of parental genes for each study
go_enrich <- go_enrich_raw <- go_enrich_rand <- matrix(0, ncol = dim(genes)[2], nrow = length(gos), dimnames = list(names(gos), names(rbp_total)))
total_ave <- 10 # number of random samplings

for (i in 1:total_ave) {    # average results from 10 random samplings
    set.seed(2 * i)
    genes_rand <- genes
    genes_rand[] <- 0
    
    for (rbp in names(rbp_total)) {     # sample pseudo target genes for each RBP
        gene_rand <- sample(1:dim(genes)[1], size = sum(genes[, rbp]), prob = genes_weight / sum(genes_weight))
        genes_rand[gene_rand, rbp] <- 1
    }
    
    for (go in names(gos)) {            # calculate p value for GO term as before
        go_total <- length(gos[[go]]$genes)     # total number of genes in this GO term
        if (go_total < 10) {            # GO term with proper sizes
            go_total <- 0
        }  
        # this will force all p values to be Inf, after deduction, the difference will be NA
        
        for (rbp in names(rbp_total)) {
            if (i == 1) {
                go_target <- sum(rownames(genes)[genes[, rbp] > 0] %in% gos[[go]]$genes) # number of genes targeted by this RBP in this GO term
                go_enrich_raw[go, rbp] <- phyper(go_target, rbp_total[rbp], dim(genes)[1] - rbp_total[rbp], go_total, lower <- F, log <- T)
                go_enrich[go, rbp] <- go_target / sum(genes[, rbp])
            }
            go_target <- sum(rownames(genes)[genes_rand[, rbp] > 0] %in% gos[[go]]$genes) # number of genes targeted by this RBP in this GO term
            go_enrich_rand[go, rbp] <- go_enrich_rand[go, rbp] + phyper(go_target, rbp_total[rbp], dim(genes)[1] - rbp_total[rbp], go_total, lower <- F, log <- T)
        }
    }
}

go_enrich_rand <- go_enrich_rand / total_ave

#######  plot these comparisons (circRNA part only)  ##########

# RBP bound circRNA whose parental genes are too few are discarded
only_show <- apply(genes[, 1:sum(species == "Human")], 2, sum) > 100
pdf(file = "data/figures/ontology.pdf", width = 9, height = 12)
par(mar = c(3, 0.5, 3, 0.5), mfrow = c(1, 1))
plot(1:5, 1:5, type = "n",
     xlim = c(-15, 15), ylim = c(0, 8 * sum(only_show)),
     xlab = "Adjusted log(p val)", ylab = "",
     main = "GO enrichment p values of circRNA parental genes",
     xaxt = "n", yaxt = "n", bty = "n", cex.main = 1.5)
axis(side = 1, at = -13:3)
segments(x0 = 0, x1 = 0, y0 = 0, y1 = 8 * sum(only_show), lwd = 2)
where <- -1
results <- c()

for (i in which(only_show)) {
    where <- where + 1
    id_study <- colnames(go_enrich)[i]
    text(6, 8 * where,
        paste(data[[id_study]]$protein, " (",
              data[[id_study]]$cell_line, ")", sep = ""),
        pos = 4, col = where + 1, cex = 1.3) # study label
    adjusted <- go_enrich_raw[, i] - go_enrich_rand[, i] # adjusted p values
    points(adjusted, rep(8 * where, dim(go_enrich)[1]) + runif(dim(go_enrich)[1], -3, 3), 
           pch = 19, cex = 0.5 + 0.5 * (adjusted < (-5)) + 0.5 * (adjusted < (-10)), col = where + 1) # scatter plot
    results <- rbind(results, c(data[[id_study]]$internal_id,
                                data[[id_study]]$protein,
                                data[[id_study]]$cell_line,
                                names(adjusted)[which.min(adjusted)],
                                round(min(adjusted, na.rm = T), d = 2),
                                round(go_enrich[names(adjusted)[which.min(adjusted)], id_study], d = 5),
                                sum(genes[, id_study]))) # save results
}

# compare GO term p value of binding sites on circRNA and linear transcripts
par(mfrow = c(2, 1), mar = c(6, 6, 6, 6))
for (i in as.character(linear)) {
    adjusted_linear <- go_enrich_raw[, i] - go_enrich_rand[, i] # i = id of dataset
    j <- names(data)[as.numeric(i)]
    adjusted_circRNA <- go_enrich_raw[, j] - go_enrich_rand[, j] # j = name of dataset
    
    plot(adjusted_linear, adjusted_circRNA, pch = 19, col = "red",
         main = paste("GO term p values of binding sites on circRNAs and linear transcripts\n",
                      data[[as.numeric(i)]]$protein, " (",
                      data[[as.numeric(i)]]$cell_line, ")",
                      sep = ""),
         xlab = "linear transcripts",
         ylab = "circRNA parental genes")
    print(data[[as.numeric(i)]]$protein)
    print(names(adjusted_circRNA)[which.min(adjusted_circRNA)])
    print(names(adjusted_linear)[which.min(adjusted_linear)])
}

dev.off()

colnames(results) <- c("Id", "RBP", "Tissue/cell line", "GO term", "log(pval)", "overlap ratio", "total")
write.table(results, file = "data/figures/ontology.txt", quote = FALSE, col.names = TRUE, sep = "\t")
