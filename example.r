#!/usr/bin/RScript

# ----------------------------------------------------
runtrial <- function(e0, ed50, emax, subjects,treatDoses, genParMean) {
    generateData(
        replicateN  = 1,
        subjects    = subjects,
        treatDoses  = treatDoses,
        genParMean  = genParMean,
        genParNames = "E0,ED50,EMAX",
        genParVCov  = c(.5,10,5), 
        respEqn     = "E0 + ((DOSE * EMAX)/(DOSE + ED50))",
        respVCov    = 2,
        # interimSubj = "0.1,0.9"
        # interimCol = "INTM"
    )
    # ----------------------------------------------------
    
    # ----------------------------------------------------
    # 'emaxCode' is executed as 'analysisCode' on each replicate.
    emaxCode <- function(data){
        uniDoses <- sort(unique(data$DOSE)) 
        obsMean  <- tapply(data$RESP, list(data$DOSE), mean)
        obsSD    <- tapply(data$RESP, list(data$DOSE), sd) 
        
        # Arguments provided: y=RESP    x=DOSE 
        eFit     <- emax.fit(data$RESP, data$DOSE)
        results <<- eFit$fit
    
        outDf    <- data.frame(   
                               DOSE  = uniDoses,
                               MEAN  = eFit$fitpred,
                               SE    = eFit$sdpred,
                               SDDIF = eFit$sddif
                               )
        outDf$LOWER   <- outDf$MEAN - 1.96*outDf$SE
        outDf$UPPER   <- outDf$MEAN + 1.96*outDf$SE
        outDf$N       <- table(data$DOSE)
        outDf$OBSMEAN <- obsMean
        outDf$OBSSD   <- obsSD
        round(outDf, 3)
    } 
    # ----------------------------------------------------
    
    # ----------------------------------------------------
    macroCode <- function(data) {
        # Is effect at highest dose significant? -> Why '>7'?
        success <- data$LOWER[data$INTERIM==max(data$INTERIM) &
                              data$DOSE   ==max(data$DOSE)      ]>7
        data.frame(SUCCESS=success)
    }
    # ----------------------------------------------------
    
    # ----------------------------------------------------
    interimCode <- function(data){
        # DROP any doses where the lower bound of
        # the difference from placebo is negative.
        dropdose  <- with(data, DOSE[LOWER<0 & DOSE!=0])
        outList <- list()
        if(length(dropdose) > 0) {
            outList$DROP <- dropdose
        }
        outList$STOP <- length(dropdose) == nrow(data)-1
        outList
    }
    # ---------------------------------------------------- 
    
    # ----------------------------------------------------
    analyzeData(analysisCode=emaxCode, macroCode=macroCode, interimCode=interimCode)
    results
    # ----------------------------------------------------
}

