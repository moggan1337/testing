rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Define the valid outcomes and their corresponding columns in the dataset
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  outcome_columns <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
  
  ## Check if the outcome is valid
  if (!(outcome %in% valid_outcomes)) {
    stop("invalid outcome")
  }
  
  ## Extract the column number for the given outcome
  outcome_column <- outcome_columns[[outcome]]
  
  ## Convert the relevant outcome column to numeric
  data[, outcome_column] <- as.numeric(data[, outcome_column])
  
  ## List of states
  states <- unique(data$State)
  states <- sort(states)
  
  ## Initialize an empty list to store the results
  hospital_list <- vector("list", length(states))
  
  ## Loop through each state to find the hospital of the given rank
  for (i in seq_along(states)) {
    state <- states[i]
    
    ## Filter the data for the specific state and remove rows with NA values for the outcome
    state_data <- data[data$State == state, ]
    state_data <- state_data[!is.na(state_data[, outcome_column]), ]
    
    ## Order by outcome and hospital name to handle ties
    ordered_state_data <- state_data[order(state_data[, outcome_column], state_data$Hospital.Name), ]
    
    ## Determine the rank to return
    if (num == "best") {
      rank_num <- 1
    } else if (num == "worst") {
      rank_num <- nrow(ordered_state_data)
    } else if (is.numeric(num) && num > 0 && num <= nrow(ordered_state_data)) {
      rank_num <- num
    } else {
      hospital_list[[i]] <- c(NA, state)
      next
    }
    
    ## Get the hospital name for the given rank
    hospital_name <- ordered_state_data$Hospital.Name[rank_num]
    hospital_list[[i]] <- c(hospital_name, state)
  }
  
  ## Convert the list of hospitals to a data frame
  result <- do.call(rbind, hospital_list)
  result <- data.frame(hospital = result[, 1], state = result[, 2], stringsAsFactors = FALSE)
  
  return(result)
}
