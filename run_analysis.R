# script to create tidy combined data set from training and test datas sets provided in UCI HAR Dataset
#downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# code activities are commented in print statements to allow operator to see what stage the script is at as it runs
#
# requires dplyr library to be installed before running
#
# M. McCrea 2016/11/12

library(dplyr)

#list of names for 561 measurements
print("reading features.txt vector of characters to be used as column headers")
header1 <- readLines("features.txt")

#We have two sets of 561 derived measurements (space separated), divided over 6 activities for 30 participants
print("reading training data set (\"train/X_train.txt\") into data.frame")
measurementsTrain <- read.table("./train/X_train.txt", header = FALSE, col.names = header1)

print("reading test data set (\"test/X_test.txt\") into data.frame")
measurementsTest <- read.table("./test/X_test.txt", header = FALSE, col.names = header1)

# table checks to see if loaded and set correctly
# print(str(measurementsTrain))
# print(head(measurementsTrain,2))
# print(tail(measurementsTrain,2))

#note: 30 participants total
print("reading \"train/subject_train.txt\" into data.frame to add to add as column to measurements")
subjectTrain <- read.table("./train/subject_train.txt", header = FALSE, col.names = c("SubjectID"))

print("reading \"test/subject_test.txt\" into data.frame to add to add as column to measurements")
subjectTest <- read.table("./test/subject_test.txt", header = FALSE, col.names = c("SubjectID"))

print("reading \"train/y_train.txt\" into data.frame")
activityTrain <- read.table("./train/y_train.txt", header = FALSE, col.names = c("ActivityID"))
print("reading \"test/y_test.txt\" into data.frame")
activityTest <- read.table("./test/y_test.txt", header = FALSE, col.names = c("ActivityID"))

#we have 6 activity classes
print("reading activity_labels.txt vector of characters and creating column of descritives activities")
actlabels <- readLines("activity_labels.txt")
#pulls out descriptions from list
actlabels2 <- substr(actlabels,3,nchar(actlabels))
#create descriptive list of activities from list of ActivityID numbers
actlabelsTrain <- actlabels2[activityTrain$ActivityID]
actlabelsTest <- actlabels2[activityTest$ActivityID]
#add it to activities data frame
activityTrain$ActivityLabel <- actlabelsTrain
activityTest$ActivityLabel <- actlabelsTest

print("Combining Columns from data sets.")
training <- data.frame()
training <- cbind(subjectTrain, activityTrain, measurementsTrain);

testing <- data.frame()
testing <- cbind(subjectTest, activityTest, measurementsTest);

print("Combining Tables test and training tables.")
total <- rbind(testing, training)

# table checks to see if loaded and set correctly
# print(head(str(total)))
# print(tail(str(total)))
# print(head(total,1))
# print(tail(total,1))

print("Removing all columns that are not a mean, indicated by Mean or mean() in the title, or standard deviation, indicated by std in the column name.")
#Use grep to identify columns to keep
keep <- grep("mean|std", names(total))
#add in participant ID and activity
totalcut <- total[,c(1,2,3,keep)]

print("Creating summary data set.")
#average of each variable, for each activity, for each subject

#convert to tibble for use with dplyr
fulldata <- tbl_df(totalcut)

#group by the subject id and activity label
fulldata <- group_by(fulldata, SubjectID , ActivityLabel)

#create summary table
summary <- summarise_each(fulldata, funs(mean))

print("Save out Tables to csv files.")
write.table(fulldata, file = "CombinedDataSet.csv", sep = ",", append = FALSE,row.names=FALSE)
write.table(summary, file = "SummaryDataSet.csv", sep = ",", append = FALSE,row.names=FALSE)
#write.csv(fulldata, file = "CombinedDataSet.csv",row.names=FALSE)
#write.csv(summary, file = "SummaryDataSet.csv",row.names=FALSE)

#extracting column names for codebooks
write(names(fulldata),"columnnames.txt",sep="\n  - \n")
