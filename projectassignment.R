## Load data
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome) # This will display the first few rows to understand the data

## Check Number of Rows and Columns
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome) # This will display the first few rows to understand the data


## Create Histogram for 30-Day Mortality Rates from Heart Attack
outcome[, 11] <- as.numeric(outcome[, 11]) # Convert column 11 to numeric
hist(outcome[, 11], main = "30-Day Mortality Rates from Heart Attack", xlab = "Mortality Rate", col = "blue", border = "black")

## Handling NA Values
hist(outcome[, 11], main = "30-Day Mortality Rates from Heart Attack", xlab = "Mortality Rate", col = "blue", border = "black", na.rm = TRUE)

## Create a function to return the best hospital in a state
best <- function(state, outcome) {
  ## Read the data
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check if the state is valid
  if (!(state %in% outcome$State)) {
    stop("invalid state")
  }
  
  ## Extract the data for the state
  data <- outcome[outcome$State == state, ]
  
  ## Remove rows with NA values
  data[, 11] <- as.numeric(data[, 11])
  data <- data[complete.cases(data), ]
  
  ## Find the hospital with the lowest 30-day mortality rate
  best <- data[which.min(data[, 11]), ]
  
  ## Return the hospital name
  best$Hospital.Name
}

