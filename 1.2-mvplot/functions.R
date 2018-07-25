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
library(data.table)

# This function calculates the standard deviation of each row in a data frame
RowSD = function(x) {
  sqrt(rowSums((x - rowMeans(x))^2)/(dim(x)[2] - 1))
}

# Apply filtering to soybean soil data and calculate metrics 
# makeSbIRNoFiltObjects = function(){
#   # Read in data files from bigPint package
#   data("soybean_ir")
#   data("soybean_ir_metrics")
#   data <- soybean_ir
#   metrics <- soybean_ir_metrics[["N_P"]]
#   
#   # Make sure each gene has at least one count in at least half of the six samples
#   filterLow = which(rowSums(data[,-1])<=ncol(data[,-1])/2)
#   filt1 <- data[filterLow,]
#   rownames_filt1 <- filt1$ID
#   filt1 <- filt1[,-1]
#   filt1 = mutate(filt1, mean = (N.1+N.2+N.3+P.1+P.2+P.3)/6, stdev = RowSD(cbind(N.1,N.2,N.3,P.1,P.2,P.3)))
#   rownames(filt1) <- rownames_filt1
#   
#   data <- data[-filterLow,]
#   data_Rownames <- data$ID
#   data = data[,-1]
#   rownames(data) <- data_Rownames
#   #Normalize and log
#   #cpm.data.new <- cpm(data, TRUE, TRUE)
#   # Normalize for sequencing depth and other distributional differences between lanes
#   
#   data <- betweenLaneNormalization(as.matrix(data), which="full", round=FALSE)
#   data = as.data.frame(data)
#   # Add mean and standard deviation for each row/gene
#   data = mutate(data, mean = (N.1+N.2+N.3+P.1+P.2+P.3)/6, stdev = RowSD(cbind(N.1,N.2,N.3,P.1,P.2,P.3)))
#   rownames(data)=data_Rownames
#   data$ID <- data_Rownames
#   # Remove the genes with lowest quartile of mean and standard deviation
#   qT = as.numeric(summary(data$mean)["1st Qu."])
#   dataq = subset(data,mean>qT)
#   qTs = as.numeric(summary(dataq$stdev)["1st Qu."])
#   dataq = subset(dataq,stdev>qTs)
#   filt = subset(data,mean<=qT|stdev<=qTs)
#   filt <- rbind(filt[,-9], filt1)
#   filt$ID <- rownames(filt)
#   
#   # Apply Loess model and further filter low gene counts
#   model = loess(mean ~ stdev, data=dataq)
#   dataqp = dataq[which(sign(model$residuals) == 1),]
#   dataqn = dataq[which(sign(model$residuals) == -1),]
#   dataqp = dataqp[,1:6]
#   
#   #Scale filter data
#   filt = filt[,1:6]
#   filt = rbind(filt,dataqn[,1:6])
#   filtID <- rownames(filt)
#   
#   dataqps <- t(apply(as.matrix(dataqp[,1:6]), 1, scale))
#   filts <- t(apply(as.matrix(filt[,1:6]), 1, scale))
#   dataqps <- as.data.frame(dataqps)
#   colnames(dataqps) <- colnames(dataqp[,1:6])
#   dataqps$ID <- rownames(dataqps)
#   filts <- as.data.frame(filts)
#   colnames(filts) <- colnames(filt[,1:6])
#   filts$ID <- filtID
#   # Indices of the 9760 NAN rows. They had stdev=0 in the filt data
#   nID <- which(is.nan(filts$N.1))
#   # Set these filtered values that have all same values for samples to 0
#   filts[nID,1:6] <- 0
#   # Comine the filtered and remaining data
#   fulls <- rbind(dataqps, filts)
#   
#   # Created soybean_ir_noFilt object
#   soybean_ir_noFilt <- soybean_ir[which(!soybean_ir$ID %in% filtID),]
#   
#   # Calculate FDR values on soybean_ir_noFilt object
#   rownames(soybean_ir_noFilt) = soybean_ir_noFilt[,1]
#   y = DGEList(counts=soybean_ir_noFilt[,-1])
#   group = c(1,1,1,2,2,2)
#   y = DGEList(counts=y, group=group)
#   Group = factor(c(rep("N",3), rep("P",3)))
#   design <- model.matrix(~0+Group, soybean_ir_noFilt=y$samples)
#   colnames(design) <- levels(Group)
#   y <- estimateDisp(y, design)
#   fit <- glmFit(y, design)
#   
#   # Create soybean_ir_noFilt_metrics object
#   soybean_ir_noFilt_metrics <- list()
#   for (i in 1:(ncol(fit)-1)){
#     for (j in (i+1):ncol(fit)){
#       contrast=rep(0,ncol(fit))
#       contrast[i]=1
#       contrast[j]=-1
#       lrt <- glmLRT(fit, contrast=contrast)
#       lrt <- topTags(lrt, n = nrow(y[[1]]))[[1]]
#       setDT(lrt, keep.rownames = TRUE)[]
#       colnames(lrt)[1] = "ID"
#       lrt <- as.data.frame(lrt)
#       soybean_ir_noFilt_metrics[[paste0(colnames(fit)[i], "_", colnames(fit)[j])]] <- lrt
#     }
#   }
#   list(soybean_ir_noFilt = soybean_ir_noFilt, soybean_ir_noFilt_metrics = soybean_ir_noFilt_metrics, fulls = fulls, dataqps = dataqps, filts = filts)
# }

# This function creates a boxplot, MDS plot, and parallel coordinate plot for replications
makePlots = function(A.1, A.2, A.3, B.1, B.2, B.3, i){
  dat <- data.frame(ID = paste0("ID", 1:50), A.1, A.2, A.3, B.1, B.2, B.3)
  datM <- melt(dat, id.vars = "ID")
  datM$group = c(rep("A",150), rep("B", 150))
  colnames(datM) <- c("ID", "Sample", "Count", "group")
  
  boxPlots[[i]] <<- ggplot(datM, aes(Sample, Count, fill=group)) + geom_boxplot() + scale_fill_manual(values=c("royalblue","darkorange2")) + theme(text = element_text(size=12), legend.position="none")
  
  # Convert DF from scatterplot to PCP
  datt <- data.frame(t(dat))
  names(datt) <- as.matrix(datt[1, ])
  datt <- datt[-1, ]
  datt[] <- lapply(datt, function(x) type.convert(as.character(x)))
  setDT(datt, keep.rownames = TRUE)[]
  dat_long <- melt(datt, id.vars ="rn" )
  colnames(dat_long) <- c("Sample", "ID", "Count")
  
  pcpPlots[[i]] <<- ggplot(dat_long) + geom_line(aes(x = Sample, y = Count, group = ID)) + theme(legend.position="none", text = element_text(size=12))
  
  tDat <- t(dat[,2:7]) #orig 2:6
  datD <- as.matrix(dist(tDat))
  fit <- cmdscale(datD, eig = TRUE, k = 2)
  x <- fit$points[, 1]
  y <- fit$points[, 2]
  myDat = data.frame(x=x,y=y)
  myDat$group = c(rep("A",3), rep("B", 3))
  mdsPlots[[i]] <<- ggplot(myDat, aes(x,y)) + geom_text(data = myDat[c(1:3),], label = rownames(myDat[c(1:3),]), nudge_y = 0.35, fontface="bold", color = "royalblue") + geom_text(data = myDat[c(4:6),], label = rownames(myDat[c(4:6),]), nudge_y = 0.35, fontface="bold", color = "darkorange2") + labs(x = "Dim 1", y = "Dim 2") + theme(text = element_text(size=12))
}

# This function is used to restructure a data frame for the yeast datset analysis
formatYeastDF <- function(df){
  setDT(df, keep.rownames = TRUE)[]
  colnames(df) = c("ID","Y1.1","Y1.2","Y2.1","Y2.2","Y7.1","Y7.2","Y4.1","Y4.2","D.1","D.2","D.7","G.1","G.2","G.3")
  df = as.data.frame(df)
  df[,c(2:ncol(df))] = log(df[,c(2:ncol(df))]+1)
  df
}

# Filter, normalize, and standardize data for cluster analysis
filterStandardizeSB <- function(data){
  # Make sure each gene has at least one count in at least half of the six samples
  filterLow = which(rowSums(data[,-1])<=ncol(data[,-1])/2)
  filt1 <- data[filterLow,]
  rownames_filt1 <- filt1$ID
  filt1 <- filt1[,-1]
  filt1 = mutate(filt1, mean = (N.1+N.2+N.3+P.1+P.2+P.3)/6, stdev = RowSD(cbind(N.1,N.2,N.3,P.1,P.2,P.3)))
  rownames(filt1) <- rownames_filt1
  
  data <- data[-filterLow,]
  data_Rownames <- data$ID
  data = data[,-1]
  rownames(data) <- data_Rownames
  #Normalize and log
  data2 = as.matrix(data)
  d = DGEList(counts=data2, lib.size=rep(1,6))
  cpm.data.new <- cpm(d, TRUE, TRUE)
  # Normalize for sequencing depth and other distributional differences between lanes
  data <- betweenLaneNormalization(cpm.data.new, which="full", round=FALSE)
  data = as.data.frame(data)
  # Add mean and standard deviation for each row/gene
  data = mutate(data, mean = (N.1+N.2+N.3+P.1+P.2+P.3)/6, stdev = RowSD(cbind(N.1,N.2,N.3,P.1,P.2,P.3)))
  rownames(data)=data_Rownames
  data$ID <- data_Rownames
  # Remove the genes with lowest quartile of mean and standard deviation
  qT = as.numeric(summary(data$mean)["1st Qu."])
  dataq = subset(data,mean>qT)
  qTs = as.numeric(summary(dataq$stdev)["1st Qu."])
  dataq = subset(dataq,stdev>qTs)
  filt = subset(data,mean<=qT|stdev<=qTs)
  filt <- rbind(filt[,-9], filt1)
  filt$ID <- rownames(filt)
  
  # Apply Loess model and further filter low gene counts
  model = loess(mean ~ stdev, data=dataq)
  dataqp = dataq[which(sign(model$residuals) == 1),]
  dataqn = dataq[which(sign(model$residuals) == -1),]
  dataqp = dataqp[,1:6]
  
  #Scale filter data
  filt = filt[,1:6]
  filt = rbind(filt,dataqn[,1:6])
  
  dataqps <- t(apply(as.matrix(dataqp[,1:6]), 1, scale))
  filts <- t(apply(as.matrix(filt[,1:6]), 1, scale))
  dataqps <- as.data.frame(dataqps)
  colnames(dataqps) <- colnames(dataqp[,1:6])
  dataqps$ID <- rownames(dataqps)
  filts <- as.data.frame(filts)
  colnames(filts) <- colnames(filt[,1:6])
  filts$ID <- rownames(filts)
  # Indices of the 9760 NAN rows. They had stdev=0 in the filt data
  nID <- which(is.nan(filts$N.1))
  # Set these filtered values that have all same values for samples to 0
  filts[nID,1:6] <- 0
  
  dendo = dataqps
  rownames(dendo) = NULL
  d = dist(as.matrix(dendo))
  hc = hclust(d, method="ward.D")
  
  # Return several parameters
  list(hc=hc, datas = dataqps, filts = filts)
}


filterStandardizeKL <- function(data){
  
  data_Rownames <- data$ID
  data = data[,-1]
  rownames(data) <- data_Rownames
  data <- betweenLaneNormalization(as.matrix(data), which="full", round=FALSE)
  data = as.data.frame(data)
  # Add mean and standard deviation for each row/gene
  data = mutate(data, mean = (K.1+K.2+K.3+L.1+L.2+L.3)/6, stdev = RowSD(cbind(K.1,K.2,K.3,L.1,L.2,L.3)))
  rownames(data)=data_Rownames
  data$ID <- data_Rownames
  
  dataqps <- t(apply(as.matrix(data[,1:6]), 1, scale))
  dataqps <- as.data.frame(dataqps)
  colnames(dataqps) <- colnames(data[,1:6])
  dataqps$ID <- rownames(dataqps)
  
  # Combine the filtered and remaining data
  fulls <- dataqps
  boxDat <- melt(fulls, id.vars="ID")
  colnames(boxDat) <- c("ID", "Sample", "Count")
  
  # Indices of the 775 NAN rows. They had stdev=0 in the filt data
  nID <- which(is.nan(dataqps$K.1))
  # Set these filtered values that have all same values for samples to 0
  dataqps[nID,1:6] <- 0
  
  # Return several parameters
  list(datas = dataqps, fulls = fulls)
}




plotClusterSM <- function(i){
  x = as.data.frame(datas[which(k==i),])
  x$cluster = "color"
  x$cluster2 = factor(x$cluster)
  xNames = rownames(x)
  metricFDR = metrics[which(as.character(metrics$ID) %in% xNames),]
  sigID = metricFDR[metricFDR$FDR<0.05,]$ID
  xSig = x[which(rownames(x) %in% sigID),]
  xSigNames = rownames(xSig)
  nGenes = nrow(xSig)
  
  scatMatMetrics = list()
  scatMatMetrics[["N_P"]] = metrics[which(metrics$ID %in% xSigNames),]
  scatMatMetrics[["N_P"]]$FDR = 10e-10
  scatMatMetrics[["N_P"]]$ID = as.factor(as.character(scatMatMetrics[["N_P"]]$ID))
  
  p = plotDEG(data = logSoy, dataMetrics = scatMatMetrics, option="scatterPoints", threshVar = "FDR", threshVal = 0.05, degPointColor = colList[i+1])
  p[["N_P"]] + xlab("Logged Count") + ylab("Logged Count") + ggtitle(paste("Cluster ", i, " Significant Genes (n=", format(nGenes, big.mark=",", scientific=FALSE), ")",sep=""))
}






