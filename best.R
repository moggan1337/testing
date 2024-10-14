best <- function(state, outcome) {
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Define the valid outcomes and the corresponding column numbers in the dataset
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  outcome_columns <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
  
  ## Check that state and outcome are valid
  if (!(state %in% data$State)) {
    stop("invalid state")
  }
  
  if (!(outcome %in% valid_outcomes)) {
    stop("invalid outcome")
  }
  
  ## Filter data for the specified state
  state_data <- data[data$State == state, ]
  
  ## Extract the relevant column for the specified outcome and convert to numeric
  outcome_column <- outcome_columns[[outcome]]
  state_data[, outcome_column] <- as.numeric(state_data[, outcome_column])
  
  ## Remove rows with NA values for the specified outcome
  valid_data <- state_data[!is.na(state_data[, outcome_column]), ]
  
  ## Find the hospital with the lowest 30-day death rate for the specified outcome
  best_value <- min(valid_data[, outcome_column], na.rm = TRUE)
  best_hospitals <- valid_data[valid_data[, outcome_column] == best_value, "Hospital.Name"]
  
  ## Handling ties by sorting alphabetically and returning the first hospital
  best_hospital <- sort(best_hospitals)[1]
  
  return(best_hospital)
}

