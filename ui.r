#!/usr/bin/RScript

library(shiny)

shinyUI(
    fluidPage(
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
        )
    )
)
