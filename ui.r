#!/usr/bin/RScript

shinyUI(fluidPage(

        titlePanel("Clinical Trial Simulator"),

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
        )
        # fluidRow(
        #     column(4, 
        #         p(strong("Mean 1:")), textOutput("delta"),
        #         p(strong("Mean 2:")), textOutput("sdev"),
        #     )
        # )
    )
)
