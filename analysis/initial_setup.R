rm(list =)
source("bin/mothur_tools.R")
require(vegan)
require(tidyverse)

# OTUs <- read.otu("data/UL.bac.final.shared")
# OTUs <- OTUs[-c(57:64),]
OTUs.tax <- read.tax("data/UL.bac.final.0.03.taxonomy")

# Make the design matrix
# design <- data.frame(sample.ID = rownames(OTUs))
# design <- cbind.data.frame(design, 
#                 colsplit(design$sample.ID, pattern = "[c D]", c("sample.type", "sample.number")))
# design$sample.type <- substr(design$sample.ID, start = 3, 3)
# for(each in 1:length(design$sample.type)){
#   if(design$sample.type[each] == "D") design$sample.type[each] <- "DNA"
#   if(design$sample.type[each] == "c") design$sample.type[each] <- "RNA"
# }

# Sort by sample type and number
# OTUs.sort <- cbind(design, OTUs)
# OTUs.sort <- arrange(OTUs.sort, sample.type, sample.number)
# design <- arrange(design, sample.type, sample.number)
# OTUs.sort <- column_to_rownames(OTUs.sort, var = "sample.ID")
# OTUs <- OTUs.sort[,-c(1:2)]
# 
# write.csv(design, file = "data/design.csv", row.names = F)
# saveRDS(OTUs, file = "data/Rdata/OTUs_97-124.rda")
OTUs <- readRDS(file = "data/Rdata/OTUs_97-124.rda")
design <- read.csv(file = "data/design.csv")

# Make rel abund matrices and split into active total comms
OTUs.REL <- decostand(OTUs, method = "total")
OTUs.total <- OTUs.REL[which(design$sample.type == "DNA"),]
OTUs.active <- OTUs.REL[which(design$sample.type == "RNA"),]
