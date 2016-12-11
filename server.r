#!/usr/bin/RScript


# ----------------------------------------------------
#source("./trial.r")
# ----------------------------------------------------


# ----------------------------------------------------
# Load engine.
rm(list=ls())
source("./01_parameters.r")
base_path       <- getwd()
engine_path     <- "/engine/"
setwd(paste(base_path, engine_path, sep=""))
lapply(list.files(pattern = "[.][Rr]$", recursive = TRUE), source)
# ----------------------------------------------------

library(ggplot2)

shinyServer(
    function(input, output) {

        v <- reactiveValues(data=NULL)

        observeEvent(input$run_simulation, {

            # Trial setup.
            n    <- input$n_patients
            e0   <- input$e0
            ed50 <- input$ed50
            emax <- input$emax
            gen_par_mean <- c(e0, ed50, emax)

            # Dosing.
            d1 <- input$d1
            d2 <- input$d2
            d3 <- input$d3
            d4 <- input$d4
            d5 <- input$d5
            treat_doses <- c(d1, d2, d3, d4, d5)

            #v$patients  <- runtrial(n, gen_par_mean, treat_doses)
            v$o <- generateData(replicateN, subjects=n, treatDoses=treat_doses,
                                genParNames=genParNames, genParMean=genParMean,
                                genParVCov=genParVCov, respEqn=respEqn,
                                respVCov=respVCov, interimSubj=interimSubj)

            v$densities <- getDensities(v$o)
            v$boxplot   <- getBoxplots(v$o)
        })
        
        output$densities <- renderPlot({
            v$densities
        })
        output$boxplot <- renderPlot({
            v$boxplot
        })

        observeEvent(input$reset, {
            v$densities <- NULL
            v$boxplot   <- NULL
        })
    }
)
