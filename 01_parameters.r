replicateN  <- 1
e0          <- 2
ed50        <- 100
emax        <- 10  
patients    <- 10000
treatDoses  <- c(0, 5, 100, 10000, 20000)
genParNames <- "E0,ED50,EMAX"
genParMean  <- c(1,50,10)
genParVCov  <- c(.5,30,10)
respEqn     <- "E0 + ((DOSE * EMAX)/(DOSE + ED50))"
respVCov    <- 2
interimSubj <- ".3, .7"

