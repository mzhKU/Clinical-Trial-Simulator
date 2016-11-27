#!/usr/bin/RScript

rm(list=ls())

source("./00_trial_03.r")

probes <- 2000
simulations <- list()

trialseries <- function(nprobes=probes, s=simulations) {
    for(i in 1:nprobes) {
        runtrial()
        if(i %% 50 == 0){print(paste(i, getDelta(), getSDev()))}

        s$delta[[i]] <- getDelta()
        s$sdevs[[i]] <- getSDev()
    }
    return(s)
}

simulations <- trialseries(probes, simulations)

# runtrial()
# print(getDensities())
# print(getBoxplot())
# 
# r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
# print(summary(aov(RESP~as.factor(TRT), data=r)))
# print(TukeyHSD(aov(RESP~as.factor(TRT), data=r)))
