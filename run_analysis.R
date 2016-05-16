#Getting and Cleaning Data Project
#run_analysis.R
#May 15, 2016

#create directory, load the data zip file, and unzip it
dirHAR <- "./HAR"
if(!file.exists(dirHAR)) {dir.create(dirHAR)}
zipFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- paste(dirHAR, "data.zip", sep="/")
download.file(zipFileUrl, destfile=destFile)
unzip(destFile, exdir=dirHAR)

#set the required directories
dirData = paste(dirHAR, "UCI HAR Dataset", sep="/")
dirTrain = paste(dirData, "train", sep="/")
dirTest = paste(dirData, "test", sep="/")

#reading and filtering features (only "mean" and "std" features)
file = paste(dirData, "features.txt", sep="/")
features <- read.table(file, sep=" ")
filtered_features_indexes <- (grepl("mean\\(\\)", features[,2]) | grepl("std\\(\\)", features[,2]))
filtered_features_names <- as.character(features[filtered_features_indexes,2])

#reading train files (only features in filtered_features)
widthCols = (2*as.numeric(filtered_features_indexes)-1)*16
file = paste(dirTrain, "X_train.txt", sep="/")
X_train <- read.fwf(file, width=widthCols, sep="", comment.char="", colClasses="numeric")
file = paste(dirTrain, "y_train.txt", sep="/")
y_train <- read.table(file)
file = paste(dirTrain, "subject_train.txt", sep="/")
subject_train <- read.table(file)
train_data <- cbind(X_train, y_train, subject_train)

#reading test files (only features in filtered_features)
file = paste(dirTest, "X_test.txt", sep="/")
X_test <- read.fwf(file, width=widthCols, sep="", comment.char="", colClasses="numeric")
file = paste(dirTest, "y_test.txt", sep="/")
y_test <- read.table(file)
file = paste(dirTest, "subject_test.txt", sep="/")
subject_test <- read.table(file)
test_data <- cbind(X_test, y_test, subject_test)

#merge test and train datasets and label the columns
all_data <- rbind(train_data, test_data)
colnames(all_data) <- c(filtered_features_names, c("label", "subject"))

#create a data set with the average of each variable for each activity and each subject
all_average <- aggregate(all_data[,1:66], by=list(all_data$subject), FUN="mean")
colnames(all_average)[1] = "subject"

#Write to the disk as CSV files
file = paste(dirData, "all_data.txt", sep="/")
write.csv(all_data, file, row.names=FALSE)
file = paste(dirData, "all_average.txt", sep="/")
write.csv(all_average, file, row.names=FALSE)