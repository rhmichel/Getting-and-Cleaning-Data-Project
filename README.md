# Getting-and-Cleaning-Data-Project

Coursera MOOC 

Getting and Cleaning Data Course 

Assignment Week 3 - Final Project


The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The data is collected from the accelerometers from the Samsung Galaxy 5 smartphone.

There are two files in this repo: run_analysis.R and CodeBook



run_analysis.R includes all the required scripts to download and process the files and then saves the tidy datasets onto the disk.
It accomplishes the following steps, as assigned:

1) Merges the training and the test sets to create one data set.

2) Extracts only the measurements on the mean and standard deviation for each measurement.

3) Uses descriptive activity names to name the activities in the data set.

4) Appropriately labels the data set with descriptive activity names.

5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.



CodeBook

This file will explain the different steps of the script. It will also give background information on the data itself.

The "run_analysis.R" script follows the following steps:

1) It will load the zipped data files from the (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) link and put it in a directory named "HAR" (if required, it will create the directory). 

2) It unzips the zip file.

3) It reads the features and filters only the features that contain "mean()" and "std()".

4) It will load all train and test data for the filtered features. 

5) It will use negative widths in "read.fwf" to skip the columns that are not required. That makes it much faster to load and process.

6) It will merge the subject files to main data and then merges all train and test data (using rbind). The result is a dataframe named "all_data". 

7) It also labels the columns by the name of the features.

8) It creates another dataframe named "all_average" that contains the mean of all columns by "subject", using "aggregate" function.

9) It writes both dataframes into CSV files.
