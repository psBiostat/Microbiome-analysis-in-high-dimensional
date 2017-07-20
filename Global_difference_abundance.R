data("Koren.16S")

koren.Count= Koren.16S$data.raw
Grp  =  Koren.16S$indiv$body_site

#We choose two boysites
koren.Count = koren.Count[-which(Grp == "UBERON:artery wall"), ]
Grp <- factor(Grp[-which(Grp == "UBERON:artery wall")],
              levels = c("UBERON:feces", "UBERON:mouth"))
              
#Bray-Curtis distance
library(vegan)
BC <- vegdist(koren.Count, method = "bray")

##############################################################
#                         ANOSIM Test                        #
##############################################################
library(vegan)
anosim(BC, Grp)

##############################################################
#                         MiRKAT Test                        #
##############################################################
library(MiRKAT)
K = D2K(as.matrix(BC))
MiRKAT(y = as.numeric(Grp)-1, Ks = K, nperm = 999, method = "permutation")

##############################################################
#                       PERMANOVA Test                       #
##############################################################
library(vegan)
adonis(formula = koren.Count ~ Grp,permutations=99)
