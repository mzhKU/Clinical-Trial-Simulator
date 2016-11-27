#!/usr/bin/RScript

shinyUI(fluidPage(

    titlePanel("Clinical Trial Simulator"),

    sidebarLayout(
        sidebarPanel(
            numericInput("n_patients", "Patients", 2500, step=25),
            numericInput("e0", "Baseline", 0  , step=1),
            numericInput("ed50", "ED_50",  0.4, step=1),
            numericInput("emax", "E_max",  5.0, step=1),
            numericInput("d1", "Dose 1", 0.0,  step=1),
            numericInput("d2", "Dose 2", 2.9,  step=1),
            numericInput("respVCov", "Response Variance Covariance",
                                                 0.5,  step=0.5),

            fluidRow(
                column(1, actionButton("run_simulation", "Start"))
            ),
            fluidRow(
                column(1, actionButton("reset", "Clear"))
            ),
            htmlOutput("linklist"),
            width=2),

        mainPanel(plotOutput("densities"))
    )
))
