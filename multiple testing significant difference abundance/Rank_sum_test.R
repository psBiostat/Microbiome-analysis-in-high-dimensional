data("Koren.16S")

koren.Count= Koren.16S$data.raw
Grp  =  Koren.16S$indiv$body_site

#We choose two boysites
koren.Count = koren.Count[-which(Grp == "UBERON:artery wall"), ]
Grp <- factor(Grp[-which(Grp == "UBERON:artery wall")],
              levels = c("UBERON:feces", "UBERON:mouth"))
              

p <- c()
for (i in 1:dim(koren.Count)[2]){
  test <- kruskal.test(koren.Count[,i] ~ Grp)
  p[i] <- test$p.value
}
padj <- p.adjust(p, method = "BH", n = length(p))
