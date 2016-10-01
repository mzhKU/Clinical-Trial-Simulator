#!/usr/bin/RScript

shinyUI(fluidPage(

        titlePanel("Clinical Trial Simulator"),

        fluidRow(
            wellPanel(
                plotOutput("plot")
            )
        ),

        fluidRow(
            column(4,
                numericInput("n_patients", "Patients", 500, step=25),
                actionButton("run_simulation", "Start Simulation"),
                actionButton("reset", "Clear")
            )
        ),
        fluidRow(
            column(4,
                numericInput("e0", "Baseline", 2, step=2),
                numericInput("ed50", "ED_50", 100, step=10),
                numericInput("emax", "E_max", 10, step=1)
            )
        )
    )
)
