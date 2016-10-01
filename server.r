#!/usr/bin/RScript

source("./00_run.r")

library(ggplot2)

shinyServer(
    function(input, output) {

        v <- reactiveValues(data=NULL)

        observeEvent(input$run_simulation, {
            n    <- input$n_patients
            e0   <- input$e0
            ed50 <- input$ed50
            emax <- input$emax
            gen_par_mean <- c(e0, ed50, emax)
            v$patients   <- runtrial(n, gen_par_mean)
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
