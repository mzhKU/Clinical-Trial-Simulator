replicateN  <- 1
e0          <- 2
ed50        <- 100
emax        <- 10  
patients    <- 10000
d1          <- 0
d2          <- 5
d3          <- 100
d4          <- 10000
d5          <- 20000
treatDoses  <- c(d1, d2, d3, d4, d5)
genParNames <- "E0,ED50,EMAX"
genParMean  <- c(1,50,10)
genParVCov  <- c(.5,10,2)
respEqn     <- "E0 + ((DOSE * EMAX)/(DOSE + ED50))"
respVCov    <- 2
interimSubj <- ".3, .7"

