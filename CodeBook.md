# Code book

The dataset `activityMonitors.csv` contains combined datasets from activity monitors from 30 volunteers, as denoted by . 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

Describe the tidy data!



The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

These signals were used to estimate variables of the feature vector for each pattern:  
Suffix 'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

However, we only extract the means and standard deviations of each measurement. Note that I have therefore skipped the columns which are the Fourier transformations of the measurements.

"BodyAcceleration" (.mean and .sd XYZ)
"GravityAcceleration" (.mean and .sd XYZ)
"BodyAccelerationJerk" (.mean and .sd XYZ)
"BodyGyroskope" (.mean and .sd XYZ)
"BodyGyroskopeJerk" (.mean and .sd XYZ)
"BodyAccelerationMagnitude" (.mean and .sd) 
"GravityAccelerationMagnitude"  (.mean and .sd)
"BodyAccelerationJerkMagnitude" (.mean and .sd)
"BodyGyroskopeMagnitude" (.mean and .sd)
"BodyGyroskopeJerkMagnitude" (.mean and .sd)