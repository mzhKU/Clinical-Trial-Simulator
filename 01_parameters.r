replicateN  <- 1
e0          <- 0
ed50        <- 4
emax        <- 10
patients    <- 1000
d1          <- 0
d2          <- 4
d3          <- 8
d4          <- 12
d5          <- 16
treatDoses  <- c(d1, d2, d3, d4, d5)
genParNames <- "E0,ED50,EMAX"
# genParMean  <- c(1,50,10)
genParMean  <- c(e0, ed50, emax)
genParVCov  <- c(.5,10,10)
respEqn     <- "E0 + ((DOSE * EMAX)/(DOSE + ED50))"
respVCov    <- 15
interimSubj <- ".3, .7"

