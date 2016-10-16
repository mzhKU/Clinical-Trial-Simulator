#!/usr/bin/RScript

shinyUI(fluidPage(

        titlePanel("Clinical Trial Simulator"),

        h2("Power Calculation"),

        fluidRow(
            column(4,
                plotOutput("densities")
            ),
            column(4,
                plotOutput("boxplot")
            )
        ),

        fluidRow(
            column(2, numericInput("n_patients", "Patients", 5000, step=25)),
            column(2, numericInput("e0", "Baseline", 0, step=2)),
            column(2, numericInput("ed50", "ED_50",  4, step=10)),
            column(2, numericInput("emax", "E_max", 10, step=1))
        ),
        fluidRow(
            column(1, numericInput("d1", "Dose 1", 0,  step=5)),
            column(1, numericInput("d2", "Dose 2", 5,  step=10))
        ),
        fluidRow(
            column(4, 
                actionButton("run_simulation", "Start Simulation"),
                actionButton("reset", "Clear")
            )
        )
    )
)
