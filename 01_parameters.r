replicateN  <- 1
e0          <- 0
ed50        <- 4
emax        <- 10
patients    <- 5000
d1          <- 0
d2          <- 10
treatDoses  <- c(d1, d2)
genParNames <- "E0,ED50,EMAX"
genParMean  <- c(e0, ed50, emax)
genParVCov  <- c(.5, 1, 1)
respEqn     <- "E0 + ((DOSE * EMAX)/(DOSE + ED50))"
respVCov    <- 5
interimSubj <- ".3, .7"

