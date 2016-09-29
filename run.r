#!/usr/bin/RScript

# ----------------------------------------------------
# Reset environment and initialize path.
rm(list=ls())
home_path       <- "/Users/mzhKU_work/projects/"
engine_path     <- "MSToolkit/R/"
simulation_path <- "trialsim/"
# ----------------------------------------------------


# ----------------------------------------------------
# Load engine.
paste(base, engine_path, sep="")
setwd(paste(home_path, engine_path, sep=""))
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
# Execute simulation.
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

# ....................................
# Dose-response equation:
# "E0 + ((DOSE * EMAX)/(DOSE + ED50))"
# genParMean <- c(e0, ed50, emax)
# ....................................

# Analyze and identify output.
r <- read.csv("./ReplicateData/replicate0001.csv", header=T)

# y1 <- genParMean[1] + ((treatDoses*genParMean[3])/(treatDoses + genParMean[2]))
y2 <- coef(results)[2] +
      ((treatDoses*coef(results)[3])/(treatDoses + coef(results)[1])) 

# genParMean <- c(e0, ed50, emax)
cat("\n")
print("genParMean:")
print(paste("e0:",   genParMean[1], "......",
            "ed50:", genParMean[2], "......",
            "emax:", genParMean[3], sep=" "))
cat("\n")
print("Fitted:")
print(paste("e0:",   round(coef(results)[2], 0), "......",
            "ed50:", round(coef(results)[1], 0), "......",
            "emax:", round(coef(results)[3], 0), sep=" "))
cat("\n")
# ------------------------------------

print(results)
print(coef(results))

# lines(y1-genParMean[1], col="blue")
# lines(y2-coef(fit)[2], col="red")

# lines(y1, col="blue")
# lines(y2, col="red")

# points(y=tapply(r$RESP, r$DOSE, mean), x=c(0,5,10,50,100),
#        pch=4, cex=2, col="red", lwd=4)

# k <- read.csv("./microSummary.csv", header=T)

g <- ggplot(r, aes(RESP, fill=as.factor(DOSE))) + geom_density(alpha=0.2)
print(g)
