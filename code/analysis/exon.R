###############################################################
###                       exon.R                            ###
###############################################################
# This R script investigates whether some RBPs tend to bind circRNAs whose ends do not sit on exon-intron boundaries.

#######  read data  ############

load("data/analysis/circRNA.RData")
protein <- sapply(1:length(data), function(i) data[[i]]$protein)
data <- data[which(protein != "IgG")]
protein <- sapply(1:length(data), function(i) data[[i]]$protein)
species <- sapply(1:length(data), function(i) data[[i]]$species)
cell_line <- sapply(1:length(data), function(i) data[[i]]$cell_line)
species_code <- list(hg19 = "Human", dm3 = "Drosophila", mm9 = "Mouse")

######  both ends are on exon boundaries  ###############

pdf("data/figures/exon.pdf", height = 5, width = 10)
layout(mat = matrix(1:2, ncol = 2), widths = c(5, 4))

for (sp in c("hg19", "mm9", "dm3")) {
    print(sp)
    lib <- c()
    
    for (i in 1:length(data)) {
        if (data[[i]]$species != species_code[[sp]]) { next }
        # data[[i]]$circRNA <- data[[i]]$circRNA[data[[i]]$circRNA$parent != "",] # circRNA must be within known gene
        if (length(unique(data[[i]]$circRNA$circ)) < 1) { next }
        data[[i]]$circRNA$study <- data[[i]]$protein
        lib <- rbind(lib, data[[i]]$circRNA)
    }
    
    lib$circ <- sub(" (-|\\+)", "", lib$circ)         # strand doesn't matter
    lib_mat <- matrix(0, nrow = length(unique(lib$circ)), ncol = length(unique(lib$study)), dimnames = list(unique(lib$circ), unique(lib$study)))
    
    for (i in 1:dim(lib)[1]) {
        lib_mat[lib$circ[i], lib$study[i]] <- 1
    } # circRNA bound in each study
    
    lib_pos <- as.data.frame(matrix(unlist(strsplit(rownames(lib_mat), " ")), ncol = 3, byrow = T), stringsAsFactors = FALSE)
    colnames(lib_pos) <- c("chr", "start", "end")
    lib_pos$on_exon <- TRUE
    lib_pos$len <- as.numeric(lib_pos$end) - as.numeric(lib_pos$start) + 1
    
    gtf <- read.table(paste("~/data/ucsc.", sp, ".gtf", sep = ""), stringsAsFactors = FALSE)
    gtf <- gtf[, c(1, 3, 4, 5, 7)]
    colnames(gtf) <- c("chr", "type", "start", "end", "strand")
    gtf <- gtf[gtf$type == "exon", ]
    
    for (i in 1:dim(lib_pos)[1]) {
        start_on_exon <- lib_pos$start[i] == gtf$start & lib_pos$chr[i] == gtf$chr
        end_on_exon <- lib_pos$end[i] == gtf$end & lib_pos$chr[i] == gtf$chr
        if (all(start_on_exon == FALSE) && all(end_on_exon == F)) {
            lib_pos$on_exon[i] <- F
        }
    }
    
    odd <- total <- sd <- rep(0, dim(lib_mat)[2]) # calculate odds ratio
    for (i in 1:dim(lib_mat)[2]) {
        a <- sum(lib_pos$on_exon == F & lib_mat[, i] == 1) + 1
        b <- sum(lib_pos$on_exon == T & lib_mat[, i] == 1) + 1
        c <- sum(lib_pos$on_exon == F & lib_mat[, i] == 0) + 1
        d <- sum(lib_pos$on_exon == T & lib_mat[, i] == 0) + 1
        odd[i] <- a / b / c * d
        total[i] <- sum(lib_mat[, i])
        sd[i] <- 1.96 * sqrt(1 / a + 1 / b + 1 / c + 1 / d)
    }
    
    plot(total, log(odd), col = "red", 
         xlab = "Total number of unique circRNAs", 
         ylab = "Log odds ratio", pch = 19, 
         main = paste("Odds ratio of RBP binding to noncanonical circRNAs\n(", species_code[[sp]], ")", sep = ""),
         cex = 1.5,
         xlim = c(0, max(total) * 1.3),
         ylim = log(range(odd)) * 2)
    
    for (i in 1:length(total)) {
        segments(x0 = total[i], x1 = total[i],
                 y0 = log(odd[i]) - sd[i], y1 = log(odd[i]) + sd[i],
                 col = "red")
    }
    
    abline(v = 200, lwd = 3, col = "blue")
    abline(h = 0, lwd = 3, col = "black")
    for (i in which(abs(log(odd)) > sd & total > 200)) {
        text(total[i], log(odd[i]), colnames(lib_mat)[i], pos = 4, col = "purple")
    }
    
    boxplot(log(lib_pos$len) ~ ifelse(lib_pos$on_exon, "canonical", "noncanonical"),
            outline = F, boxwex = 0.6, col = "green", las = 1, lwd = 2, ylab = "log(circRNA length)", 
            main = paste("circRNA length vs. boundary position\n(", species_code[[sp]], ")", sep = ""))
}

dev.off()
