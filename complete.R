complete <- function(directory, id = 1:332) {
  # 'directory' is a character vector of length 1 indicating
  # the location of the CSV files
  
  # 'id' is an integer vector indicating the monitor ID numbers
  # to be used
  
  # Create a data frame to store the results
  result <- data.frame(id = integer(), nobs = integer())
  
  # Loop through each monitor ID
  for (monitor in id) {
    # Construct the filename
    filename <- paste0(sprintf("%03d", monitor), ".csv")
    
    # Construct the full file path
    filepath <- file.path(directory, filename)
    
    # Check if the file exists
    if (file.exists(filepath)) {
      # Read the CSV file
      data <- read.csv(filepath)
      
      # Count the number of complete cases
      nobs <- sum(complete.cases(data))
      
      # Add the result to the data frame
      result <- rbind(result, data.frame(id = monitor, nobs = nobs))
    }
  }
  
  # Return the result data frame
  return(result)
}
