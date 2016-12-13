#!/usr/bin/RScript

# ----------------------------------------------------
# Setup:
# Set working directory in R shell to 'trialsim'.
#
# Command line:
# > source("./trial.r")
# > runtrial()
# 
# To plot the response distributions:
# > getDensities()
# > getBoxplot()
#
# Shiny (shiny library loaded in .rProfile):
# library(shiny)
# > runApp()
# ----------------------------------------------------


# ----------------------------------------------------
# Reset environment and initialize path.
rm(list=ls())
base_path       <- getwd()
engine_path     <- "/engine/"
# ----------------------------------------------------


# ----------------------------------------------------
# Load engine.
setwd(paste(base_path, engine_path, sep=""))
lapply(list.files(pattern = "[.][Rr]$", recursive = TRUE), source)

# Return to simulation.
setwd(base_path)

# Required for 'mvrnorm' in 'createNmParSamples.R'.
# library(MASS)
library(ggplot2)
# ----------------------------------------------------


# ----------------------------------------------------
# Dose-response equation:
# E(dose) = E0 + ((dose * Emax)/(dose + ed50))
# ----------------------------------------------------

replicateN  <- 1
e0          <- 0
ed50        <- 4
emax        <- 10
patients    <- 50
d1          <- 0
d2          <- 4
d3          <- 10
d4          <- 40
d5          <- 80
treatDoses  <- c(d1, d2, d3, d4, d5)
genParNames <- "E0,ED50,EMAX"
genParMean  <- c(e0, ed50, emax)
genParVCov  <- c(.5, 1, 1)
respEqn     <- "E0 + ((DOSE * EMAX)/(DOSE + ED50))"
respVCov    <- 2
interimSubj <- ".3, .7"

n            <- patients
gen_par_mean <- genParMean
treat_doses  <- treatDoses

o <- generateData(replicateN, subjects=n, treatDoses=treat_doses,
                  genParNames=genParNames, genParMean=genParMean,
                  genParVCov=genParVCov, respEqn=respEqn,
                  respVCov=respVCov, interimSubj=interimSubj)

print("Data returned as variable 'o'")
return(o)
# ----------------------------------------------------



# ----------------------------------------------------
# Visualization.
# Data has to be reloaded for visualization because otherwise
# new data resulting from a new simulation is not updated.
getDensities <- function(r=o) { 
    #r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
    g <- ggplot(r, aes(RESP, fill=as.factor(DOSE))) + geom_density(alpha=0.2)
    g
}
getBoxplots <- function(r=o) {
    #r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
    g <- ggplot(r, aes(as.factor(DOSE), y=RESP)) + geom_boxplot()
    g
}
# ----------------------------------------------------



# ----------------------------------------------------
# 'emaxCode' is executed as 'analysisCode' on each replicate.
# source("./00_analysis.r")
# analyzeData(analysisCode=emaxCode,
#                macroCode=macroCode,
#              interimCode=interimCode)
# ----------------------------------------------------
