replicateN  <- 1
e0          <- 0
ed50        <- 0.4
emax        <- 1.0
patients    <- 250
d1          <- 0
d2          <- 0.9
treatDoses  <- c(d1, d2)
genParNames <- "E0,ED50,EMAX"
genParMean  <- c(e0, ed50, emax)
genParVCov  <- c(.5, 0.5, 0.5)
respEqn     <- "E0 + ((DOSE * EMAX)/(DOSE + ED50))"
respVCov    <- 3.5
interimSubj <- ".3, .7"

