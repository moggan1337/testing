rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Define the valid outcomes and their respective columns in the dataset
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
  
  ## Order data by outcome and hospital name (to handle ties)
  ordered_data <- valid_data[order(valid_data[, outcome_column], valid_data$Hospital.Name), ]
  
  ## Determine the rank to return
  if (num == "best") {
    rank_num <- 1
  } else if (num == "worst") {
    rank_num <- nrow(ordered_data)
  } else if (is.numeric(num) && num > 0 && num <= nrow(ordered_data)) {
    rank_num <- num
  } else {
    return(NA)
  }
  
  ## Return hospital name for the given rank
  hospital_name <- ordered_data$Hospital.Name[rank_num]
  return(hospital_name)
}
