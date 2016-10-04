#!/usr/bin/RScript

source("./00_trial.r")

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

            v$patients   <- runtrial(n, gen_par_mean, treat_doses)
            v$plot       <- getPlot()
        })
        
        output$plot <- renderPlot({
            v$plot
        })

        observeEvent(input$reset, {
            v$plot <- NULL
        })
    }
)
