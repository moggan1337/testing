# Step 1: Install and load xml2 package
install.packages("xml2")
library(xml2)

# Step 2: Read the XML data from the URL
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xml_data <- read_xml(url)

# Step 3: Find and count how many restaurants have the zipcode "21231"
zipcodes <- xml_find_all(xml_data, "//zipcode")
zipcodes_text <- xml_text(zipcodes)
count_21231 <- sum(zipcodes_text == "21231")

# Step 4: Print the result
print(count_21231)
