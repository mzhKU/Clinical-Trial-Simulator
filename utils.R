# ----------------------------------------------------------
# Mango Solutions, Chippenham SN14 0SQ 2006
# utils.R Fri Jun 01 10:57:12 BST 2007 @456 /Internet Time/
#
# Author: Romain
# ----------------------------------------------------------
# DESCRIPTION: set of utility functions, not exported
# KEYWORDS: component:helper 
# ----------------------------------------------------------

.roundIt <- function(data, digits){
    if(!missing(digits)) {
        digits <- parseCharInput(digits, convertToNumeric=TRUE)
        nCov   <- ncol(data)
        if(any(digits < 0 )) {
            ectdStop("`digits` should be a positive vector")
        }
        len.di <- length(digits)
        if(len.di == 1) {
            data <- round( data, digits = digits)
        } else if(len.di == nCov) {
            for(i in 1:nCov) {
                data[,i] <- round(data[,i], digits = digits[i])
            }
        } else {
              ectdStop("`digits should be of length one or $nCov, not ${len.di}`")
        }
    }
    data
}

.nonCumulativeFromCumulative <- function( proportion ){
    # Format it correctly.
    proportion <- parseCharInput( proportion ) 
    
    # Check that the numbers are probabilities \in (0,1].
    if(max(proportion) >  1) ectdStop("Proportion greater than 1")
    if(min(proportion) <= 0) ectdStop("Proportion lower than 0")
    
    # Append 1 if needed.
    if(max(proportion) != 1) proportion <- c(proportion, 1)
    
    # Generate the non-cumulative proportions.
    proportion <- diff( c(0, proportion)  )
    if(any(proportion <= 0)) ectdStop("Proportion not increasing")
    proportion
}

.deriveFromMasterSeed <- function(){
	sample(1:999, 1) 
}
 
# Regular expression toys.
.quotes <- "(\\\"|\')"
      

.strinterp <- function(txt){
    myrx <- "\\$(\\{(.*?)\\}|[\\.]?[a-zA-Z][\\.0-9a-zA-Z]*)"
    
    gx  <- gregexpr(myrx, txt, perl=TRUE)[[1]]
    print("gx")
    print(gx)

    va  <- substring(txt, gx + 1, gx + attr(gx, "match.length")-1) %-~% "[\\{\\}]"
    print("va")
    print(va)

    spl <- strsplit(txt, myrx , perl=TRUE)[[1]]
    print("spl")
    print(spl)
   
    if(length(va) == 1 && va == "") return(txt)
    if(length(va) == length(spl)) spl <- c(spl, "")
    
    out <- spl[1]
    for(i in seq(along=va)) {
      varName <- try(get(va[i], pos=parent.frame(2))[1] ,silent=TRUE)
      if( class(varName) == "try-error") varName <- va[i]
      out <- out %.% varName  %.% spl[i+1]
    }
    out
}

.requiredArgs <- function(arg, msg){
  if( missing(arg) ) {
    sc <- sys.call()
    nameArg <- as.character(sys.call()[2])
    if( missing(msg) ) msg <- "The argument `" %.% nameArg %.% "` is missing" 
    ectdStop(msg)
  }
}

# Changes 10 into 1:10, check that 10 is positive.
# Write the number of subjects in the parent environment as `nSubjects`
.expandSubjects <- function(subjects){
  if(length(subjects) == 1) {
    if(subjects < 1) ectdStop("subjects must be positive")
    subjects <- 1:subjects 
  } else {
    subjects
  }
  assign("nSubjects", length(subjects), parent.frame())
  subjects
}


.eval <- function( txt ){
  eval( parse( text = .strinterp(txt) ), parent.frame() )
}

.log <- function( ... , file = getEctdLogFile(), verbose = getEctdVerbose()){
  if( verbose ){ 
    msg <- paste( ..., "\n", sep = "" )
    msg <- .strinterp( msg )
    msg <- sprintf( "[%s] %s", format( Sys.time(), getEctdDateFormat() ) , msg )
    cat( msg, file = file, append = TRUE)
  }
  invisible( NULL )
}

# Used in 'createResponseVariable.R'. Commented out now because does not
# work on shinyapps.io.
# ".checkFun" <- function(fun, expectedArgs) {
#     fun <- try( eval( match.fun(fun), parent.frame() ), silent = TRUE )
#     if (class(fun) == "try-error") {
#         print(ectdStop("not a valid function"))
#     }
#     if(!missing(expectedArgs)) {
#         expectedArgs <- parseCharInput(expectedArgs, convertToNumeric = FALSE) 
#         if(!all(expectedArgs %in% names(formals(fun)))) { 
#             ectdStop("Problem with the arguments of the function")
#         }
#     }
#     fun
# }

