#!/usr/bin/RScript

# ----------------------------------------------------
# Setup:
# Set working directory in R shell to 'trialsim'.
#
# Super command, loads parameters, trial, plot, ANOVA:
# > source("00_run.r")
#
# Command line:
# > source("./00_trial.r")
# > runtrial()
# 
# To plot the response distributions:
# > getPlot()
#
# Shiny (shiny library loaded in .rProfile):
# > runApp()
# ----------------------------------------------------


# ----------------------------------------------------
# Reset environment and initialize path.
rm(list=ls())
base_path       <- "/Users/mzhKU_work/projects/"
engine_path     <- "MSToolkit/R/"
simulation_path <- "trialsim/trial_03/"
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

# Note, 'function'- not 'generateData'-argument list:
# function(
# - 'n':        Argument from shiny
# - 'patients': Argument from parameters
# - <arg_shiny_server>=<arg_parameter_file>
# The argument names 'n', 'gen_par_means', ... are defined
# in the 'runtrial'-call in 'server.r'.
runtrial <- function(n           =patients,
                     gen_par_mean=genParMean,
                     treat_doses =treatDoses) {
    generateData(replicateN, subjects=n, treatDoses=treat_doses,
                 genParNames=genParNames, genParMean=genParMean,
                 genParVCov=genParVCov, respEqn=respEqn,
                 respVCov=respVCov, interimSubj=interimSubj
    )
}
# ----------------------------------------------------


# ----------------------------------------------------
# Statistical analysis.
getDelta <- function() {
    r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
    delta <- mean(r[r$TRT==2, ]$RESP) - mean(r[r$TRT==1, ]$RESP)
}
getSDev  <- function() {
    r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
    sdev <- sd(r[r$TRT==1, ]$RESP)
}
# ----------------------------------------------------


# ----------------------------------------------------
# Visualization.
# Data has to be reloaded for visualization because otherwise
# new data resulting from a new simulation is not updated.
getDensities <- function() { 
    r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
    g <- ggplot(r, aes(RESP, fill=as.factor(DOSE))) + geom_density(alpha=0.2)
    g
}
getBoxplot <- function() {
    r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
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
