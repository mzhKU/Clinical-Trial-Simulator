#!/usr/bin/RScript

shinyUI(fluidPage(

    tags$head(tags$script(src="./explanation.js")),

    headerPanel("Clinical Trial Simulator"), 

    fluidRow(
        column(3, actionButton("run_simulation", "Start Simulation")),
        column(3, actionButton("reset", "Clear"))
    ),
    br(),

    fluidRow(
        column(12, tags$pre("Description of variables.", id="explanationText"))
    ),
    br(),

    fluidRow(
        column(12, plotOutput("densities"))
    ),

    fluidRow(
        tags$div(
            id="explanationPatients",
            onmouseover="explanationPatients()", onmouseout="offExplanation()",
            column(3, numericInput("n_patients", "Patients", 500, step=25))
        ),
        tags$div(
            id="explanationBaseline",
            onmouseover="explanationBaseline()", onmouseout="offExplanation()",
            column(3, numericInput("e0", "Baseline", 0, step=2))
        ),
        tags$div(
            id="explanationED50",
            onmouseover="explanationED50()", onmouseout="offExplanation()",
            column(3, numericInput("ed50", "ED_50",  4, step=10))
        ),
        tags$div(
            id="explanationEmax",
            onmouseover="explanationEmax()", onmouseout="offExplanation()",
            column(3, numericInput("emax", "E_max", 10, step=1))
        )
    ),
    fluidRow(
        tags$div(
            id="explanationDose",
            onmouseover="explanationDose()", onmouseout="offExplanation()",
            column(3, numericInput("d1", "Dose 1", 0,  step=5)),
            column(3, numericInput("d2", "Dose 2", 5,  step=10)),
            column(3, numericInput("d3", "Dose 3", 10, step=20)),
            column(3, numericInput("d4", "Dose 4", 40, step=10))
        )
    ),
    br(),
    p("Developed by M. Hediger")
))
