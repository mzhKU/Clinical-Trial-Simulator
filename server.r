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
            resp_v_cov   <- input$respVCov

            # Dosing.
            d1 <- input$d1
            d2 <- input$d2
            treat_doses <- c(d1, d2)

            v$patients  <- runtrial(n, gen_par_mean, treat_doses, resp_v_cov)
            v$densities <- getDensities()
            v$boxplot   <- getBoxplot()

            v$replicates <- getReplicates()

            output$linklist  <- renderUI({ v$replicates })

            # Analysis.
            # v$delta <- getDelta()
            # v$sdev  <- getSDev()
            # v$power <- getPower()
        })

        
        # output$densities <- renderPlot({ v$densities })
        output$boxplot   <- renderPlot({ v$boxplot   })
        output$delta     <- renderText({ v$delta     })
        output$sdev      <- renderText({ v$sdev      })
        output$power     <- renderText({ v$power     })


        observeEvent(input$reset, {
            v$densities <- NULL
            v$boxplot   <- NULL
            v$delta     <- NULL
            v$sdev      <- NULL
            v$power     <- NULL
        })
    }
)
