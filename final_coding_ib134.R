library(phytools)
cox1<-read.tree("cox1_with_species_name")
setwd("~/Desktop/134 final project/syngnathidae_files")
cox1$tip.label <- gsub(".*organism_", "", cox1$tip.label)
cox1$tip.label <- gsub("___Gene.*", "", cox1$tip.label)
plot(cox1)
library('unikn')  
library(TreeTools)
outgroup <- c("Doryichthys_boaja", 
              "Microphis_brachyurus", 
              "Doryrhamphus_japonicus", 
              "Oostethus_manadensis", 
              "Microphis_deocata")
rooted_cox <- RootTree(cox1, outgroup = outgroup)
plot(rooted_cox)

fish.data <- read.csv("cox_dataset_numbered_noSpace2.csv", row.names=1)
fish.data.cleaned <- fish.data[-1,]
fish.data.cleaned[fish.data.cleaned == "?"] <- "unknown"
fish.data.cleaned[fish.data.cleaned == "0"] <- "female brooding"
fish.data.cleaned[fish.data.cleaned == "1"] <- "rudimentary"
fish.data.cleaned[fish.data.cleaned == "2"] <- "enclosed pouch(inverted)"
fish.data.cleaned[fish.data.cleaned == "3"] <- "fully enclosed"

fmode<-as.factor(setNames(fish.data.cleaned[,1],rownames(fish.data.cleaned)))

dotTree(rooted_cox,
        fmode,
        data.type = "discrete",
        ftype="bi",fsize=0.5)

