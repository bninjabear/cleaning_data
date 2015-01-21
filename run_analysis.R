##########################################
#
#  run_analysis.R
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
##########################################

library(tidyr)
library(dplyr)

## STEP 1 ##

# This should be replaced with the name of the working directory
wdir <- 'E:\\datasciencecoursera\\project\\'

# Gather training data
subject <- read.table(file=paste(wdir,'UCI HAR Dataset\\train\\subject_train.txt',sep=''),col.names='subject')
activity <- read.table(file=paste(wdir,'UCI HAR Dataset\\train\\Y_train.txt',sep=''),col.names='activity_code')
data <- read.table(file=paste(wdir,'UCI HAR Dataset\\train\\X_train.txt',sep=''))
train_data <- cbind(subject,activity,data)

# Gather test data
subject_test <- read.table(file=paste(wdir,'UCI HAR Dataset\\test\\subject_test.txt',sep=''),col.names='subject')
activity_test <- read.table(file=paste(wdir,'UCI HAR Dataset\\test\\Y_test.txt',sep=''),col.names='activity_code')
data_test <- read.table(file=paste(wdir,'UCI HAR Dataset\\test\\X_test.txt',sep=''))
test_data <- cbind(subject_test,activity_test,data_test)

# Get column names, combine training and test data sets
data_labels <- read.table(file=paste(wdir,'UCI HAR Dataset\\features.txt',sep=''))
alldata <- rbind(test_data,train_data)
colnames(alldata)[c(3:563)]<-as.matrix(data_labels[,2])
      
## STEP 2 ## 

# Get column indices for columns containing mean and std data
means <- grep('mean()',names(alldata))
stds <- grep('std()',names(alldata))
newcols <- c(1,2,means,stds)
# Keep only those columns
summary_data <- alldata[,newcols]

## STEPS 3 and 4 ##

# Activity code descriptive names:
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

summary_data[,2] <- gsub('1', 'WALKING', summary_data[,2])
summary_data[,2] <- gsub('2', 'WALKING_UPSTAIRS', summary_data[,2])
summary_data[,2] <- gsub('3', 'WALKING_DOWNSTAIRS', summary_data[,2])
summary_data[,2] <- gsub('4', 'SITTING', summary_data[,2])
summary_data[,2] <- gsub('5', 'STANDING', summary_data[,2])
summary_data[,2] <- gsub('6', 'LAYING', summary_data[,2])

## STEP 5 ##

# Summarize each variable by subject and by activity
mydata <- tbl_df(summary_data)
grouped_data <- group_by(mydata,subject,activity_code)
tidy_data <- summarise_each(grouped_data,funs(mean))

