###############################################################
###                      explore.R                          ###
###############################################################
# This R script plot detected circRNA reads, percentage and species frequency distribution across all CLIP-seq studies.


###########  read data  ############

load("data/analysis/circRNA_all.RData")
protein <- sapply(1:length(data), function(i) data[[i]]$protein)
data <- data[which(protein != "IgG")]
read_circRNA <- sapply(1:length(data), function(i) dim(data[[i]]$circRNA)[1])                         # reads supporting circRNAs
species_circRNA <- sapply(1:length(data), function(i) length(unique(data[[i]]$circRNA$circ)))         # unique circRNA species
total <- sapply(1:length(data), function(i) data[[i]]$total)                                          # total mapped reads


#############  plot  ################

pdf("data/figures/explore.pdf", height = 8, width = 8)
par(mfrow = c(2, 2))
hist(read_circRNA, 
     xlab = "# circRNA reads", 
     main = "# total circRNA reads found in each study", 
     breaks = 20, col = "green")
hist(read_circRNA/total*10^2, 
     xlab = "Percentage", 
     main = "% of reads supporting circRNA in each study", 
     breaks = 20, col = "green")
hist(species_circRNA, 
     xlab = "# circRNA species", 
     main = "# circRNA species found in each study", 
     breaks = 20, col = "green")
dev.off()

i <- 36
data[[i]]$protein
data[[i]]$species
data[[i]]$cell_line
View(data[[i]]$circRNA)
draw_circRNA(data[[i]]$circRNA[data[[i]]$circRNA$circ == "chr10 93552322 93552507 +",])


############  functions  ################

draw_circRNA <- function(circRNA) {
    rg <- c(-max(circRNA$overhang_start), max(circRNA$overhang_end))
    plot(1:2, 1:2, type = "n", 
         main = "CircRNA tag intensity plot", 
         xlab = "Coordinate", 
         ylab = "Tag pileup", 
         xlim = rg*1.2, 
         ylim = c(0, dim(circRNA)[1]))
    abline(v = 0, lwd = 5, col = "black")
    for (i in 1:dim(circRNA)[1]) {
        rect(-circRNA$overhang_start[i], i-1, circRNA$overhang_end[i], i-0.2, border = NA, col = i)
    }
}