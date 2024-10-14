# Define the URL and destination path for the download
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
destfile <- "C:/Users/moogg/Documents/JHU Projects/testing/DATA_gov_NGAP.xlsx"

# Download the Excel file
download.file(url, destfile, mode = "wb")

# Read the Excel file
ngap_data <- read_excel(destfile)

# View the first few rows to verify the data
head(ngap_data)

# Define the path to the downloaded file
destfile <- "C:/Users/moogg/Documents/JHU Projects/testing/DATA_gov_NGAP.xlsx"

# Read rows 18-23 and columns 7-15 into a variable called `dat`
dat <- read_excel(destfile, range = "G18:O23")

# Display the loaded data
print(dat)

