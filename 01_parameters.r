replicateN  <- 1
e0          <- 0
ed50        <- 1.5
emax        <- 2.0
patients    <- 2500
d1          <- 0
d2          <- 2.9
treatDoses  <- c(d1, d2)
genParNames <- "E0,ED50,EMAX"
genParMean  <- c(e0, ed50, emax)
genParVCov  <- c(0.5, 1.5, 3.0)
respEqn     <- "E0 + ((DOSE * EMAX)/(DOSE + ED50))"
respVCov    <- 1.5
interimSubj <- ".3, .7"

