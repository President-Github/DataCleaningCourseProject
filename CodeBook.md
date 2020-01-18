# DataCleaningCourseProject
Coursera Data Cleaning Course Project
Morgan Meeuwissen 2020

## Orginal Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Data Transformations and Cleaning
* Merged the training (X_train.txt) and test (X_test.txt) sets along with their their labels (y_test.txt / y_train.txt) to create one data set
* Applied variable descriptions from features.txt and descriptive labels for each activity id from activity_labels.txt
* Extracted only the variables containing the mean and standard deviations for each measurement
* Cleaned up the remaining variable names into a descriptive format free of special characters
* Produced a second tidy data set with the average of each variable for each activity and each subject
* Saved the resultant datasets as cleaned_data.csv and tidy_data.csv

## Tidy Data Set Variables
For each subject and activity the mean of following variables has been produced, with XYZ indicating an X, Y, and Z version exist:
* BodyAccelerationMeanXYZ
* BodyAccelerationStandardDeviationXYZ
* GravityAccelerationMeanXYZ
* GravityAccelerationStandardDeviationXYZ
* BodyAccelerationJerkMeanXYZ
* BodyAccelerationJerkStandardDeviationXYZ
* BodyGyroMeanXYZ
* BodyGyroStandardDeviationXYZ
* BodyGyroJerkMeanXYZ
* BodyGyroJerkStandardDeviationXYZ
* BodyAccelerationMagnitudeMean
* BodyAccelerationMagnitudeStandardDeviation
* GravityAccelerationMagnitudeMean
* GravityAccelerationMagnitudeStandardDeviation
* BodyAccelerationJerkMagnitudeMean
* BodyAccelerationJerkMagnitudeStandardDeviation
* BodyGyroMagnitudeMean
* BodyGyroMagnitudeStandardDeviation
* BodyGyroJerkMagnitudeMean
