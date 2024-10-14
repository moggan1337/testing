# Set working directory
setwd("C:/Users/moogg/Documents/JHU Projects/testing")

# Load required libraries
if (!require(dplyr)) install.packages("dplyr")
if (!require(tidyr)) install.packages("tidyr")
library(dplyr)
library(tidyr)

# Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip", method = "curl")
unzip("dataset.zip")

# Read training and test data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read feature names and activity labels
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_name"))

# Merge training and test sets
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Set column names
colnames(X) <- features$V2
colnames(y) <- "activity"
colnames(subject) <- "subject"

# Combine all data
combined_data <- cbind(subject, y, X)

# Extract mean and standard deviation measurements
mean_std_cols <- grep("mean\\(\\)|std\\(\\)", features$V2)
selected_data <- combined_data[, c(1, 2, mean_std_cols + 2)]

# Use descriptive activity names
selected_data$activity <- factor(selected_data$activity, levels = activity_labels$activity_id, labels = activity_labels$activity_name)

# Label the dataset with descriptive variable names
names(selected_data) <- gsub("^t", "Time", names(selected_data))
names(selected_data) <- gsub("^f", "Frequency", names(selected_data))
names(selected_data) <- gsub("Acc", "Accelerometer", names(selected_data))
names(selected_data) <- gsub("Gyro", "Gyroscope", names(selected_data))
names(selected_data) <- gsub("Mag", "Magnitude", names(selected_data))
names(selected_data) <- gsub("BodyBody", "Body", names(selected_data))

# Create a tidy dataset with the average of each variable for each activity and subject
tidy_data <- selected_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# Write the tidy dataset to a file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

print("Analysis complete. Tidy data has been saved to 'tidy_data.txt'")
