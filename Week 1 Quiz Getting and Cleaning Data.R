# Load the data
data <- read.csv("C:/Users/moogg/Documents/JHU Projects/testing/getdata_data_ss06hid.csv")

# Count the number of properties worth $1,000,000 or more
million_dollar_properties <- sum(data$VAL == 24, na.rm = TRUE)

# Print the result
print(million_dollar_properties)
