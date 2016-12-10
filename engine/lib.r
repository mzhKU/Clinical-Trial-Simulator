# This line sets the initial (empty) environment.
.ectdEnv <- new.env()

# This sets the default column names
assign("colNames", list(
	Subject   = list(Name = "SUBJ",      Other = "ID",             Default = "SUBJ"),
	Time      = list(Name = "TIME",      Other = c("DAY", "WEEK"), Default = "TIME"),
	Dose      = list(Name = "DOSE",      Other = "",               Default = "DOSE"),
	Interim   = list(Name = "INTERIM",   Other = "",               Default = "INTERIM"),
	ParOmit   = list(Name = "PAROMIT",   Other = "",               Default = "PAROMIT"),
	RespOmit  = list(Name = "RESPOMIT",  Other = "",               Default = "RESPOMIT"),
	Response  = list(Name = "RESP",      Other = "DV",             Default = "RESP"),
	Trt       = list(Name = "TRT",       Other = "",               Default = "TRT"),
	Missing   = list(Name = "MISSING",   Other = "",               Default = "MISSING"),
	Replicate = list(Name = "Replicate", Other = "TRIAL",          Default = "Replicate"),
	DrugName  = list(Name = "DRUGNAME",  Other = "",               Default = "DRUGNAME"),
	Drug      = list(Name = "DRUG",      Other = "",               Default = "DRUG")
    ),
    envir      = .ectdEnv
)

resetEctdColNames <- function( whichNames = names(getNames)) {
	getNames <- get("colNames", envir = .ectdEnv)
	if (!is.character(whichNames)) ectdStop("Character vector should be provided as the 'whichNames' input")
	whichNames <- whichNames [ whichNames %in% names(getNames)]
	if (length(whichNames)) {
		for (i in whichNames) getNames[[i]]$Name <- getNames[[i]]$Default 
	}
	assign("colNames", getNames, envir = .ectdEnv)
	invisible(getNames)
}
