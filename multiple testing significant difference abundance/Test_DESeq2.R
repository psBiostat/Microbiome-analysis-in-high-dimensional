
data("Koren.16S")

koren.Count= Koren.16S$data.raw
Grp  =  Koren.16S$indiv$body_site

#We choose two boysites
koren.Count = koren.Count[-which(Grp == "UBERON:artery wall"), ]
Grp <- factor(Grp[-which(Grp == "UBERON:artery wall")],
levels = c("UBERON:feces", "UBERON:mouth"))

source("https://bioconductor.org/biocLite.R")
biocLite("DESeq2")
library("DESeq2")


colData <- data.frame(condition = Grp)
rownames(colData) <- row.names(koren.Count)

#Data creaion
dds <- DESeqDataSetFromMatrix(countData = t(koren.Count),
                              colData = DataFrame(Grp),
                              design = ~ Grp)

#Pre-filtering
dds <- dds[ rowSums(counts(dds)) > 1, ]

#Test
dds <- DESeq(dds)
res <- results(dds)

#Graphics
plotMA(res, main="DESeq2", ylim=c(-2,2))
