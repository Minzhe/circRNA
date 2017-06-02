###############################################################
###                     location.R                          ###
###############################################################
# This R script explores some basic properties of RBP binding sites on circRNAs.  


#########  read data  ############

load("data/analysis/circRNA.RData")
protein <- sapply(1:length(data), function(i) data[[i]]$protein)
data <- data[which(protein != "IgG")]
protein <- sapply(1:length(data), function(i) data[[i]]$protein)
species <- sapply(1:length(data), function(i) data[[i]]$species)
cell_line <- sapply(1:length(data), function(i) data[[i]]$cell_line)

###########  proportion of sens/antisens locations  ############

x <- y <- z <- w <- c()

for (i in 1:length(protein)) {      # calculate proportion
    parents <- data[[i]]$circRNA$parent
    parents <- parents[parents != ""]
    parents <- parents[!(grepl(":sens", parents) & grepl(":antisens", parents))]
    x <- c(x, 1 - sum(grepl("antisens", parents)) / length(parents))        # proportion of circRNA reads in sense strand
    y <- c(y, length(parents))                                              # number of total circRNA reads
    
    parents <- data[[i]]$linear_reads$parent
    parents <- parents[parents != ""]
    w <- c(w, length(parents))                                              # number of linear reads in known genes
    parents <- parents[!(grepl(":sens", parents) & grepl(":antisens", parents))]    # proportion of linear reads in sense strand
    z <- c(z, 1 - sum(grepl("antisens", parents)) / length(parents))
}

##############  plot  ###################

pdf("data/figures/location.pdf")

size <- sqrt(2 * sqrt(y / sd(y)))
plot(x, z,
     main = "circRNAs reside in sense or anti-sense strand of parental genes",
     xlab = "Prop. of circRNA reads in sense strand",
     ylab = "Prop. of linear reads in sense strand",
     pch = 19, col = densCols(x, z), cex = size,
     xlim = c(0, 1), ylim = c(0, 1))
segments(0, 0, 1, 1, col = "orange", lwd = 3)
pos <- 0
cols <- c("red", "gray20", "green", "purple", "orange")
for (i in which(abs(x - z) > 0.2 & y > 500)) {  # mark circRNAs that tend to reside in anti-sense strands
    pos <- pos + 1
    points(x[i], z[i], cex = size[i], col = cols[pos], pch = 19)
    text(0.6, pos / 20, paste(protein[i], "(", cell_line[i], ")", sep = ""), pos = 4, col = cols[pos])
}

w <- w / sapply(1:length(data), function(i) dim(data[[i]]$linear_reads)[1])
plot(w, z,
     main = "Prop. of linear reads in sense strand is related to experimental quality",
     xlab = "Prop. of linear reads in known genes",
     ylab = "Prop.n of linear reads in sense strand",
     pch = 19, col = densCols(w, z), cex = 1,
     xlim = c(0, 1), ylim = c(0, 1))
segments(0, 0, 1, 1, col = "orange", lwd = 3)

dev.off()
