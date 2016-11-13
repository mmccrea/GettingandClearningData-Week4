# README Coursera Getting and Cleaning Data Week 4 Assignment

M. McCrea 2016/11/12
------

This README is for the run_analysis.R is script that is used to prepare a combined data set of the mean and standard deviation measureuments from the UCI HAR Dataset
downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip[1]

run_analysis.R is to be placed in the top level folder of the UCI HAR Dataset folder after it is unzipped for the relative file paths to work.

Two ouput files are produced:
  - CombinedDataSet.csv, the combined train and test data set
  - SummaryDataSet.csv, the summary of the combined data set

The column headers are nearly the same as specified in the file UCI HAR Dataset\features.txt.  The files are modified with R converting the brackets, ( ), and dashes -,  to .'s.  The column position in the X_train.txt or X_test.txt is also prepdended to each column as X#.

So the column name X1.tBodyAcc.mean...X from the output files is tBodyAcc-mean()-X in UCI HAR Dataset\features.txt
, and was the first row in the X_train.txt or X_test.txt is was taken from.

The SummaryDataSet.csv files contains the mean over each participant identified by the Subject ID for each of the 6 activities of each of the subset of the 561 measurements that were a mean or standard deviation.

CombinedDataSet-CodeBook.txt and SummaryDataSet-CodeBook.txt gives more details on the variables in each.


[1]Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012