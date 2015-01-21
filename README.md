# cleaning_data
repo for course project script

#  run_analysis.R

This script does the following:
1. Merges the training and the test sets to create one data set. The data set must be in the same directory structure as is produced by extracting the zipped course data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement by parsing the variable names (column names) to look for 'mean' and 'std'.
3. Uses descriptive activity names to name the activities in the data set. The activity code numbers are replaced by labels such as 'walking', etc.
4. Appropriately labels the data set with descriptive variable names by replacing the codes in the 'activity_code' column.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

