data("Koren.16S")

koren.Count= Koren.16S$data.raw
Grp  =  Koren.16S$indiv$body_site

#We choose two boysites
koren.Count = koren.Count[-which(Grp == "UBERON:artery wall"), ]
Grp <- factor(Grp[-which(Grp == "UBERON:artery wall")],
              levels = c("UBERON:feces", "UBERON:mouth"))
              
source("https://bioconductor.org/biocLite.R")
biocLite("ALDEx2")
library("ALDEx2")

#Transformation clr
x <- aldex.clr(as.data.frame(t(koren.Count)),
               mc.samples=128, verbose=TRUE)

#Test
fit <- aldex.ttest(x, conditions= Grp)
