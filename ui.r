#!/usr/bin/RScript

shinyUI(fluidPage(

        titlePanel("Clinical Trial Simulator"),

        h4("Power Calculation"),

        fluidRow(
            column(4,
                plotOutput("densities")
            ),
            column(4,
                plotOutput("boxplot")
            )
        ),

        fluidRow(
            column(2, numericInput("n_patients", "Patients", 2500, step=25)),
            column(2, numericInput("e0", "Baseline", 0  , step=1)),
            column(2, numericInput("ed50", "ED_50",  0.4, step=1)),
            column(2, numericInput("emax", "E_max",  5.0, step=1))
        ),
        fluidRow(
            column(1, numericInput("d1", "Dose 1", 0.0,  step=1)),
            column(1, numericInput("d2", "Dose 2", 2.9,  step=1)),
            column(2, numericInput("respVCov", "Response Variance Covariance",
                                                 0.5,  step=0.5))
        ),
        fluidRow(
            column(4, 
                actionButton("run_simulation", "Start Simulation"),
                actionButton("reset", "Clear")
            )
        ),
        fluidRow(
            column(4, 
                p(strong("Delta:")), textOutput("delta"),
                p(strong("SDev:" )),  textOutput("sdev"),
                p(strong("Power:")), textOutput("power")
            )
        )
        # fluidRow(
        #     column(4, 
        #         p(strong("Alpha:")), textOutput("alpha"),
        #         p(strong("Beta:" )),  textOutput("beta"),
        #         p(strong("Power:")), textOutput("power")
        #     )
        # )
    )
)
