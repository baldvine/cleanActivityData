# Code book

## Original Dataset
The original dataset, along with detailed descriptions, can be found here:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The embedded accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually.

The raw data features come from the accelerometer and gyroscope 3-axial raw signals (Acceleration and Gyroskope). These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (Body and Gravity) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (Magnitude). 

# Combined and tidied data

Here, we describe the dataset `activityMonitors.csv` which contains combined datasets from activity monitors described above. The column "SubjectID" contains integer values from 1 to 30, denoting the test subject. The "Activity" column has values for each of the six different activities, as described in the original dataset.

The next 20 columns are the averages of each measurement, as grouped by the subject and activity. Note the we have excluded the Fourier transformed measurements, but they could easily be added to the dataset. Further, we have ordered the dataset so that subjects and activities are listed contiguosly. For details on all these procedures, see the markdown file `run_analysis.md`.

Suffix 'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* "SubjectID"
* "Activity"
* "BodyAcceleration.mean(XYZ)"
* "GravityAcceleration.mean(XYZ)"
* "BodyAccelerationJerk.mean(XYZ)"
* "BodyGyroskope.mean(XYZ)"
* "BodyGyroskopeJerk.mean(XYZ)"
* "BodyAccelerationMagnitude.mean"
* "GravityAccelerationMagnitude.mean"
* "BodyAccelerationJerkMagnitude.mean"
* "BodyGyroskopeMagnitude.mean"
* "BodyGyroskopeJerkMagnitude.mean"

Again, note that all measurements were normalized and bounded within [-1,1].