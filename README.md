# Clinical-Trial-Simulator

This application can be run as a Shiny app or locally.
Data is generated and stored in "./ReplicateData/" and can be visualized
by R shell functions or through the Shiny app.

To run the app:

1) Start a R session and set the working directory to the directory
containing the 'trial.r' file.

2) In the R session enter:
   > source('./trial.r')

3) Enter 
   > runtrial()

4) You should find the data generated in './ReplicateData/'

6) Then enter:
   > > getDistributions()

to get an overview on the distributions of responses depending on doses

7) Enter:
   > getBoxplots()
   to get a boxplot overview of the simulated data

8) Enter:
   > library(shiny)
   > runApp()
   to open the app in the browser.

You may of course skip steps 2)-7) if you just want to use the Shiny app.
