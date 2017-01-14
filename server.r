library(ggplot2)

source("./utils.R")
source("./generateData.R")
source("./metaManagement.R")
source("./createTreatments.R")
source("./initialChar.R")
source("./operators.R")
source("./parseCharInput.R")
source("./validNames.R")
source("./createCovariates.R")
source("./allocateTreatments.R")
source("./createParameters.R")
source("./ectdStop.R")
source("./createNormalParameters.R")
source("./parseCovMatrix.R")
source("./checkSymmetricPDMatrix.R")

# Added separately.
source("./mvrnorm.R")

source("./createResponse.R")
source("./createResponseVariable.R")
source("./addResidualError.R")

# 'shinyServer' is executed by Shiny the first time when 'runApp' is called.
# Then shinyServer gives the unnamed 'function' to Shiny.
shinyServer(

    # 'function' is the first argument to 'shinyServer', saved until
    # a new user arrives. This function is run everytime a user visits
    # the app -> builds a distinct set of reactive values for each user.
    function(input, output) {


        v <- reactiveValues(data=NULL)

        observeEvent(input$run_simulation, {

            # Reactive sources.
            n    <- input$n_patients
            e0   <- input$e0
            ed50 <- input$ed50
            emax <- input$emax
            gen_par_mean <- c(e0, ed50, emax)
            gen_par_vcov <- c(0.5, 1.0, 1.0)
            respEqn     <- "E0+((DOSE*EMAX)/(DOSE+ED50))"
            resp_vcov    <- 2
            interim_subj <- ".3, .7"

            # Dosing.
            d1 <- input$d1
            d2 <- input$d2
            d3 <- input$d3
            d4 <- input$d4
            d5 <- input$d5
            treat_doses <- c(d1, d2, d3, d4, d5)

            v$o <- generateData(replicateN=1, subjects=n, treatDoses=treat_doses,
                                genParNames="E0,ED50,EMAX", genParMean=gen_par_mean,
                                genParVCov=gen_par_vcov, respEqn=respEqn,
                                respVCov=resp_vcov, interimSubj=interim_subj)

            v$densities <- getDensities(v$o)
            #v$boxplot   <- getBoxplots(v$o)
            v$test <- "Here"
        })

        # Reactive endpoints, re-run every time the user changes a widget.
        output$pwd <- renderText({
            output <- paste(getwd(), dir())
            print(output)
        })

        output$test <- renderText({
            v$test
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

        getDensities <- function(r=o) {
            g <- ggplot(r, aes(RESP, fill=as.factor(DOSE))) +
                 geom_density(alpha=0.2) +
                 labs(title="Hill-Equation Dose-Response Model",
                      x="RESPONSE", y="DENSITY") + 
                 theme(plot.title=element_text(size=rel(2)),
                       axis.text=element_text(size=rel(1.5)),
                       axis.title=element_text(size=rel(1.5)),
                       legend.position="top", legend.text=element_text(size=rel(2)),
                       legend.title=element_text(size=rel(2))) +
                 guides(fill=guide_legend(title="DOSE:"))
            g
        }
        # getBoxplots <- function(r=o) {
        #     g <- ggplot(r, aes(as.factor(DOSE), y=RESP)) +
        #          geom_boxplot() +
        #          theme(legend.position="top", text=element_text(size=20))
        #     g
        # }

        # empty_plot <- ggplot(r, aes(RESP, fill=as.factor(DOSE))) +
        #      geom_density(alpha=0.2) +
        #      labs(title="Hill-Equation Dose-Response Model",
        #           x="RESPONSE", y="DENSITY") + 
        #      theme(plot.title=element_text(size=rel(2)),
        #            axis.text=element_text(size=rel(1.5)),
        #            axis.title=element_text(size=rel(1.5)),
        #            legend.position="top", legend.text=element_text(size=rel(2)),
        #            legend.title=element_text(size=rel(2))) +
        #      guides(fill=guide_legend(title="DOSE:"))
        # empty_plot
    }
)
