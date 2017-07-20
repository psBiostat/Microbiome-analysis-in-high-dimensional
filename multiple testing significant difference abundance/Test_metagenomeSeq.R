data("Koren.16S")

koren.Count= Koren.16S$data.raw
Grp  =  Koren.16S$indiv$body_site

#We choose two boysites
koren.Count = koren.Count[-which(Grp == "UBERON:artery wall"), ]
Grp <- factor(Grp[-which(Grp == "UBERON:artery wall")],
              levels = c("UBERON:feces", "UBERON:mouth"))
              
source("https://bioconductor.org/biocLite.R")
biocLite("metagenomeSeq")
library("metagenomeSeq")

#Data creation
df <- AnnotatedDataFrame(colData)
obj <- newMRexperiment(t(koren.Count), phenoData = df)

#Normalization
Data = filterData(obj, present = 10, depth = 1)
Data <- cumNorm(Data, p = 0.5)
s <- normFactors(Data)
pd <- pData(Data)
mod <- model.matrix(~1 + condition, data = pd)

#Test
res = fitFeatureModel(Data, mod)
