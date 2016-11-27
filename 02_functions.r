# ----------------------------------------------------
# Statistical analysis.
getDelta <- function() {
    r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
    delta <- mean(r[r$TRT==2, ]$RESP) - mean(r[r$TRT==1, ]$RESP)
    delta
}
getSDev  <- function() {
    r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
    sdev <- sd(r[r$TRT==1, ]$RESP)
    sdev
}
getPower <- function() {
    r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
    delta <- getDelta()
    sdev  <- sd(r[r$TRT==1, ]$RESP)
    n     <- nrow(r[r$TRT==1, ])
    pow   <- power.t.test(n, delta, sdev)$power
}
getMean <- function() {
    r <- read.csv("./ReplicateData/replicate0001.csv", header=T) 
    r
}
# ----------------------------------------------------

