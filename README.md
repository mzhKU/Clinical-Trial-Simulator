# Clinical-Trial-Simulator

This application can be run as a Shiny app or locally in the R shell.
Data is generated and stored in `./ReplicateData/` and can be visualized
by functions from the app within the shell or through the Shiny app.

To run the app:

1) Start an R session and set the working directory to the directory
containing the `trial.r` file.

2) In the R session enter:
```r
   > source('./trial.r')
```

3) Enter 
```r
> runtrial()
```

4) You should find the data generated in `./ReplicateData/`

6) Then enter:
```r
> getDistributions()
```

to get an overview on the distributions of responses depending on doses.

7) Enter:
```r
> getBoxplots()
```
   to get a boxplot overview of the simulated data.

8) Enter:
```r
> library(shiny)
> runApp()
```
   to open the app in the browser.

You may of course skip steps 2) - 7) if you just want to use the Shiny app.
