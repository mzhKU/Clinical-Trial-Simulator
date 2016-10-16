#!/usr/bin/RScript

source("./00_trial_01.r")
runtrial()
print(getDensities())
print(getBoxplot())

r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
print(summary(aov(RESP~as.factor(TRT), data=r)))
print(TukeyHSD(aov(RESP~as.factor(TRT), data=r)))
