data("Koren.16S")

koren.Count= Koren.16S$data.raw
Grp  =  Koren.16S$indiv$body_site

#We choose two boysites
koren.Count = koren.Count[-which(Grp == "UBERON:artery wall"), ]
Grp <- factor(Grp[-which(Grp == "UBERON:artery wall")],
              levels = c("UBERON:feces", "UBERON:mouth"))
              
              
source("https://bioconductor.org/biocLite.R")
biocLite("DESeq")
library(DESeq)

# Data creation
cds = newCountDataSet(t(koren.Count), Grp )

#Normalization
cds = estimateSizeFactors( cds )
cds = estimateDispersions(cds, method = "pooled", fitType = "local")

#Test
res = nbinomTest( cds, "UBERON:feces", "UBERON:mouth" )
res

#Grpahic
plotMA(res)
hist(res$pval, breaks=100, col="skyblue", border="slateblue", main="")



              
