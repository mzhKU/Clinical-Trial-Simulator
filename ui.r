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
            column(2, numericInput("n_patients", "Patients", 5000, step=25)),
            column(2, numericInput("e0", "Baseline", 0, step=2)),
            column(2, numericInput("ed50", "ED_50",  4, step=10)),
            column(2, numericInput("emax", "E_max", 10, step=1))
        ),
        fluidRow(
            column(1, numericInput("d1", "Dose 1", 0,  step=5)),
            column(1, numericInput("d2", "Dose 2", 5,  step=10)),
            column(1, numericInput("d3", "Dose 3", 10, step=20)),
            column(1, numericInput("d4", "Dose 4", 40, step=10)),
            column(1, numericInput("d5", "Dose 5", 80, step=10))
        ),
        fluidRow(
            column(4, 
                actionButton("run_simulation", "Start Simulation"),
                actionButton("reset", "Clear")
            )
        )
    )
)
