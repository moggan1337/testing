pollutantmean <- function(directory, pollutant, id = 1:332) {
  # 'directory' is a character vector of length 1 indicating
  # the location of the CSV files
  
  # 'pollutant' is a character vector of length 1 indicating
  # the name of the pollutant for which we will calculate the
  # mean; either "sulfate" or "nitrate".
  
  # 'id' is an integer vector indicating the monitor ID numbers
  # to be used
  
  # Initialize an empty vector to store pollutant data
  all_data <- numeric()
  
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
      
      # Extract the pollutant data and add it to all_data
      all_data <- c(all_data, data[[pollutant]])
    }
  }
  
  # Return the mean of the pollutant across all monitors listed
  # in the 'id' vector (ignoring NA values)
  mean(all_data, na.rm = TRUE)
}
