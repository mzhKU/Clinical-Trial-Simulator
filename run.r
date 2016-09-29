#!/usr/bin/RScript

# ----------------------------------------------------
# Reset environment and initialize path.
rm(list=ls())
base_path       <- "/Users/mzhKU_work/projects/"
engine_path     <- "MSToolkit/R/"
simulation_path <- "trialsim/"
# ----------------------------------------------------


# ----------------------------------------------------
# Load engine.
paste(base_path, engine_path, sep="")
setwd(paste(base_path, engine_path, sep=""))
lapply(list.files(pattern = "[.][Rr]$", recursive = TRUE), source)

# Return to simulation.
setwd(paste(base_path, simulation_path, sep=""))

# Required for 'mvrnorm' in 'createNmParSamples.R'.
library(MASS)
library(ggplot2)

# Required to export 'fit' object from 'emaxCode' function to global scope.
results <- list()
# ----------------------------------------------------


# ----------------------------------------------------
# Dose-response equation:
# E(dose) = E0 + ((dose * Emax)/(dose + ed50))
# ----------------------------------------------------
e0         <- 2
ed50       <- 100
emax       <- 10  
genParMean <- c(e0, ed50, emax)
treatDoses <- c(0, 10, 100, 10000, 20000)
subjects   <- 5000

source("./example.r")
source("./emaxfit.R")
results <- runtrial(e0, ed50, emax, subjects, treatDoses, genParMean)

# Trial output.
r <- read.csv("./ReplicateData/replicate0001.csv", header=T)

g <- ggplot(r, aes(RESP, fill=as.factor(DOSE))) + geom_density(alpha=0.2)
# print(g)
# ----------------------------------------------------
