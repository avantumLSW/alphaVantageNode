################################################################################
# Dialogparameters
################################################################################
api = "%%API%%"
symbol = "%%symbol%%"
timefunction = "%%timefunction%%"
interval = "%%interval%%"
outputsize = "%%full_compact%%"
################################################################################
# Functions
################################################################################
returnMetaDataFrame <- function(name){
  date <- c(fieldName="Date",fieldLabel="Date",fieldStorage="string",
            fieldMeasure="",fieldFormat="",fieldRole="")
  open <- c(fieldName="Open",fieldLabel="Open",fieldStorage="real",
            fieldMeasure="",fieldFormat="",fieldRole="")
  high <- c(fieldName="High",fieldLabel="High",fieldStorage="real",
            fieldMeasure="",fieldFormat="",fieldRole="")
  low <- c(fieldName="Low",fieldLabel="Low",fieldStorage="real",
           fieldMeasure="",fieldFormat="",fieldRole="")
  close <- c(fieldName="Close",fieldLabel="Close",fieldStorage="real",
             fieldMeasure="",fieldFormat="",fieldRole="")
  volume <- c(fieldName="Volume",fieldLabel="Volume",fieldStorage="string",
              fieldMeasure="",fieldFormat="",fieldRole="")
  adjustedClose <- c(fieldName="AdjustedClose",fieldLabel="AdjustedClose",
                     fieldStorage="real",fieldMeasure="",fieldFormat="",fieldRole="")
  split <- c(fieldName="Split Coefficent",fieldLabel="Split Coefficent",
             fieldStorage="real",fieldMeasure="",fieldFormat="",fieldRole="")
  dividend <- c(fieldName="Dividend",fieldLabel="Dividend",fieldStorage="real",
                fieldMeasure="",fieldFormat="",fieldRole="")
  switch(name, 
         TIME_SERIES_INTRADAY = {
           return(data.frame(
             date, open, high, low, close, volume, 
             stringsAsFactors = FALSE
           ))
         },
         TIME_SERIES_DAILY = {
           return(data.frame(
             date, open, high, low, close, volume, 
             stringsAsFactors = FALSE
           ))
         },
         TIME_SERIES_DAILY_ADJUSTED = {
           return(data.frame(
             date, open, high, low, close, volume, adjustedClose, dividend,
             split, stringsAsFactors = FALSE
           ))
         },
         TIME_SERIES_WEEKLY = {
           return(data.frame(
             date, open, high, low, close, volume, 
             stringsAsFactors = FALSE
           ))
         },
         TIME_SERIES_WEEKLY_ADJUSTED = {
           return(data.frame(
             date, open, high, low, close, adjustedClose, volume, dividend, 
             stringsAsFactors = FALSE
           ))
         },
         TIME_SERIES_MONTHLY = {
           return(data.frame(
             date, open, high, low, close, volume, 
             stringsAsFactors = FALSE
           ))
         },
         TIME_SERIES_MONTHLY_ADJUSTED = {
           return(data.frame(
             date, open, high, low, close, adjustedClose, volume, dividend, 
             stringsAsFactors = FALSE
           ))
         })
}

################################################################################
# Code
################################################################################
modelerDataModel <- returnMetaDataFrame(timefunction)
if(timefunction == "TIME_SERIES_INTRADAY"){
  query = paste("https://www.alphavantage.co/query?",
                "function=",timefunction,
                "&symbol=",symbol,
                "&interval=",interval,
                "&outputsize=",outputsize,
                "&apikey=",api,
                "&datatype=csv", sep="")
}else{
  query = paste("https://www.alphavantage.co/query?",
                "function=",timefunction,
                "&symbol=",symbol,
                "&outputsize=",outputsize,
                "&apikey=",api,
                "&datatype=csv", sep="")
}

modelerData <- read.csv(query, stringsAsFactors = F)
names(modelerData) <- as.character(modelerDataModel[1,])
