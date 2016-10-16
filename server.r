#!/usr/bin/RScript

source("./00_trial_03.r")

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
            treat_doses <- c(d1, d2)

            v$patients  <- runtrial(n, gen_par_mean, treat_doses)
            v$densities <- getDensities()
            v$boxplot   <- getBoxplot()
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
