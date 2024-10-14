corr <- function(directory, threshold = 0) {
  # 'directory' is a character vector of length 1 indicating
  # the location of the CSV files
  
  # 'threshold' is a numeric vector of length 1 indicating the
  # number of completely observed observations (on all 
  # variables) required to compute the correlation between
  # nitrate and sulfate; the default is 0
  
  # Create a vector to store the correlations
  correlations <- numeric()
  
  # Loop through all possible monitor IDs (1 to 332)
  for (i in 1:332) {
    # Construct the filename
    filename <- paste0(sprintf("%03d", i), ".csv")
    
    # Construct the full file path
    filepath <- file.path(directory, filename)
    
    # Check if the file exists
    if (file.exists(filepath)) {
      # Read the CSV file
      data <- read.csv(filepath)
      
      # Count the number of complete cases
      complete_obs <- sum(complete.cases(data))
      
      # If the number of complete cases is above the threshold
      if (complete_obs > threshold) {
        # Calculate the correlation between sulfate and nitrate
        correlation <- cor(data$sulfate, data$nitrate, use = "complete.obs")
        
        # Add the correlation to the vector
        correlations <- c(correlations, correlation)
      }
    }
  }
  
  # Return the vector of correlations
  return(correlations)
}
