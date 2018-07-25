library(rtracklayer)
library(Rsamtools)
library(grid)
library(GenomicAlignments)
library(ggplot2)
library(GGally)
library(edgeR)
library(stringr)
library(EDASeq)
library(dplyr)
library(matrixStats)
library(gridExtra)
library(reshape2)
library(scales)
library(bigPint)

source("functions.R")

data("soybean_ir")
data <- soybean_ir
load("../Bioinformatics/Pictures/FilterNotSig/soybean_ir_noFilt_metrics.rda")
metrics <- soybean_ir_noFilt_metrics[["N_P"]]

# Filter, normalize, and standardize the data so each gene has mean=0 and stdev=1
res <- filterStandardizeSB(data)
# Fitered data standardized
filts <- res[["filts"]]
# Non-filtered data standardized
datas <- res[["datas"]]
# Hierarchical clustering object
hc <- res[["hc"]]
# Full data standardized
fulls <- rbind(datas, filts)

# Number of clusters
nC = 4
# Number of samples
nCol = 6
colList = scales::hue_pal()(nC+1)
colList <- colList[c(4, 3, 2, 5, 1)]
# Hierarchical clustering
k = cutree(hc, k=nC)

yMin = min(datas[,1:nCol])
yMax = max(datas[,1:nCol])

# Create background boxplot data
boxDat <- melt(fulls, id.vars="ID")
colnames(boxDat) <- c("ID", "Sample", "Count")

plot_clustersSig = lapply(1:nC, function(i){
  x = as.data.frame(datas[which(k==i),])
  x$cluster = "color"
  x$cluster2 = factor(x$cluster)
  xNames = rownames(x)
  metricFDR = metrics[which(as.character(metrics$ID) %in% xNames),]
  sigID = metricFDR[metricFDR$FDR<0.05,]$ID
  xSig = x[which(rownames(x) %in% sigID),]
  xSigNames = rownames(xSig)
  nGenes = nrow(xSig)

  xSig$ID = xSigNames
  pcpDat <- melt(xSig[,c(1:7)], id.vars="ID")
  colnames(pcpDat) <- c("ID", "Sample", "Count")
  pcpDat$Sample <- as.character(pcpDat$Sample)
    
  pSig = ggplot(boxDat, aes_string(x = 'Sample', y = 'Count')) + geom_boxplot() + geom_line(data=pcpDat, aes_string(x = 'Sample', y = 'Count', group = 'ID'), colour = colList[i+1], alpha=0.3) + ylab("Standardized Count") + ggtitle(paste("Cluster ", i, " Genes (n=", format(nGenes, big.mark=",", scientific=FALSE), ")",sep="")) + theme(plot.title = element_text(hjust = 0.5, size=11, face="plain"), axis.text=element_text(size=11), axis.title=element_text(size=11))
  pSig
})
# We allow up to 4 plots in each column
do.call("grid.arrange", c(plot_clustersSig, ncol=ceiling(nC/2)))


