#!/usr/bin/RScript

# ----------------------------------------------------
# Setup:
# Set working directory in R shell to 'trialsim'.
#
# Command line:
# > source("./00_run.r")
# > t <- runtrial()
# 
# To plot the response distributions:
# > print(t)
#
# Shiny (shiny library loaded in .rProfile):
# > runApp()
# ----------------------------------------------------


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
# ----------------------------------------------------


# ----------------------------------------------------
# Dose-response equation:
# E(dose) = E0 + ((dose * Emax)/(dose + ed50))
# ----------------------------------------------------

source("./01_parameters.r")

# Parameters:
# - Command line: Defaults from '01_parameters.r'
# - Shiny:        Defaults from 'ui.r'

# function(
# - 'n':        Argument from shiny
# - 'patients': Argument from parameters
runtrial <- function(n=patients, gen_par_mean=genParMean) {
    print("gen_par_mean")
    print(gen_par_mean)
    generateData(replicateN, subjects=n, treatDoses=treatDoses,
                 genParNames=genParNames, genParMean=genParMean,
                 genParVCov=genParVCov, respEqn=respEqn,
                 respVCov=respVCov, interimSubj=interimSubj
    )
}

getPlot <- function() { 
    # Trial output.
    r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
    g <- ggplot(r, aes(RESP, fill=as.factor(DOSE))) + geom_density(alpha=0.2)
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
