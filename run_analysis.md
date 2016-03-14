# Merge Data Sets - Create Tidy Data
Baldvin Einarsson  
March 12, 2016  



We assume that the data has been downloade and unzipped (via script `getData.R`), the location of which is the folder `UCI HAR Dataset/`:

```r
dataLoc <- "UCI HAR Dataset/"
```

# Get Labels and Feature Names

First, we get the activity labels:

```r
activityLabels <- read.table(paste0(dataLoc,"activity_labels.txt"),
                             header = FALSE,
                             col.names = c("Value","Activity"),
                             stringsAsFactors = FALSE
                             )
```

Then, we obtain the names of the features:

```r
features <- read.table(paste0(dataLoc,"features.txt"),
                       header=FALSE,
                       row.names = 1,
                       col.names = c("RowNum","Name"),
                       stringsAsFactors = FALSE)
```

Since we're only interested in the means and standard deviations, we find out which features have "mean" and "std" in their names:

```r
meanFeatures <- grepl("mean",features$Name)
stdFeatures <- grepl("std",features$Name)
```

# Read Data

First, we read the training set:

```r
trainingData <- cbind(read.table(file=paste0(dataLoc,"train/subject_train.txt"),
                                 col.names = "SubjectID"),
                      read.table(file=paste0(dataLoc,"train/y_train.txt"), 
                                 col.names = "Activity"),
                      read.table(file=paste0(dataLoc,"train/X_train.txt"), 
                                 col.names = features$Name))
```
And then the test set:

```r
testData <- cbind(read.table(file=paste0(dataLoc,"test/subject_test.txt"), 
                               col.names = "SubjectID"),
                  read.table(file=paste0(dataLoc,"test/y_test.txt"), 
                               col.names = "Activity"),
                  read.table(file=paste0(dataLoc,"test/X_test.txt"), 
                               col.names = features$Name))
```


# Merge (subsets of) training and test datasets 

We now create a data frame from the above two types of data. However, we only extract the means and standard deviations of each measurement. Note that I have therefore skipped the columns which are the Fourier transformations of the measurements.


```r
selectedColumns <- c("SubjectID", "Activity",
                     grep("^[^f].+\\.mean\\.",names(testData),value = TRUE),
                     grep("^[^f].+std",names(testData),value = TRUE))

combinedData <- rbind(trainingData[,selectedColumns],
                      testData[,selectedColumns])

# Arrange according to the subject id (use the activity to break ties):
combinedData <- plyr::arrange(combinedData, SubjectID, Activity)

# Clear the raw data and flush memory
rm(list=c("trainingData","testData")); gc()
```

```
##           used (Mb) gc trigger (Mb) max used  (Mb)
## Ncells  375961 20.1    3763080  201  3505138 187.2
## Vcells 3033766 23.2   14415424  110 18018364 137.5
```

Ok, this leaves us with a total of 10299 rows and 42 columns. Let's now rename the columns more clearly:


```r
# First, we remove the "t" at the start of variable names:
names(combinedData) <- gsub("^t","",names(combinedData))
# Change "Acc" to a more descriptive "Acceleration":
names(combinedData) <- gsub("Acc","Acceleration",names(combinedData))
# Change "Mag" to a more descriptive "Magnitude":
names(combinedData) <- gsub("Mag","Magnitude",names(combinedData))
# Change "Gyro" to a more descriptive "Gyroskope":
names(combinedData) <- gsub("Gyro","Gyroskope",names(combinedData))
# Change "std" to "sd" (for R-style 'standard deviation'):
names(combinedData) <- gsub("\\.std","\\.sd",names(combinedData))


# Then, we clean the dots and such:
names(combinedData) <- gsub("\\.{2,3}","",names(combinedData))
```

Next, we add descriptive values to the activity:


```r
combinedData$Activity <- activityLabels$Activity[combinedData$Activity]
```

# Calculate averages

The instructions mention taking averages of each activity per subject. However, since averaging standard deviations is a "statistical crime" (!), we only include the averages of the means:


```r
library(dplyr)

# Create symbols for the columns we wish to group by
groupCols <- names(combinedData)[(1:2)]

# Find the columns we actually want to take the mean of:
valCols <- grep("\\.mean",names(combinedData),value = TRUE)

# Use the dplyr package to group the data and find means
combinedData.summary <- (combinedData %>% 
  group_by_(.dots=groupCols) %>% 
  summarize_each_(funs(mean),vars=valCols))
```

> Note that the above dplyr came from [StackOverflow](http://stackoverflow.com/questions/21208801/group-by-multiple-columns-in-dplyr-using-string-vector-input), but the documentation probably contains the same information.

# Create new tidy dataset

We name the new data "activityMonitor.csv":


```r
write.table(x = combinedData.summary, file = "activityMonitor.csv", 
            sep = ",", row.names=FALSE)
```
