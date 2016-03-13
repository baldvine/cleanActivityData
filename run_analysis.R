## ----setFolderLoc--------------------------------------------------------
dataLoc <- "UCI HAR Dataset/"

## ----getLabels-----------------------------------------------------------
activityLabels <- read.table(paste0(dataLoc,"activity_labels.txt"),
                             header = FALSE,
                             col.names = c("Value","Activity"),
                             stringsAsFactors = FALSE
                             )

## ----getFeatures---------------------------------------------------------
features <- read.table(paste0(dataLoc,"features.txt"),
                       header=FALSE,
                       row.names = 1,
                       col.names = c("RowNum","Name"),
                       stringsAsFactors = FALSE)

## ----findMeanStdFeatures-------------------------------------------------
meanFeatures <- grepl("mean",features$Name)
stdFeatures <- grepl("std",features$Name)

## ----getTrainingSet------------------------------------------------------
trainingData <- cbind(read.table(file=paste0(dataLoc,"train/subject_train.txt"),
                                 col.names = "SubjectID"),
                      read.table(file=paste0(dataLoc,"train/y_train.txt"), 
                                 col.names = "Activity"),
                      read.table(file=paste0(dataLoc,"train/X_train.txt"), 
                                 col.names = features$Name))

## ----getTestSet----------------------------------------------------------

testData <- cbind(read.table(file=paste0(dataLoc,"test/subject_test.txt"), 
                               col.names = "SubjectID"),
                  read.table(file=paste0(dataLoc,"test/y_test.txt"), 
                               col.names = "Activity"),
                  read.table(file=paste0(dataLoc,"test/X_test.txt"), 
                               col.names = features$Name))

## ----mergeAndSubset------------------------------------------------------
selectedColumns <- c("SubjectID", "Activity",
                     grep("^[^f].+\\.mean\\.",names(testData),value = TRUE),
                     grep("^[^f].+std",names(testData),value = TRUE))

combinedData <- rbind(trainingData[,selectedColumns],
                      testData[,selectedColumns])

# Arrange according to the subject id (use the activity to break ties):
combinedData <- plyr::arrange(combinedData, SubjectID, Activity)

# Clear the raw data and flush memory
rm(list=c("trainingData","testData")); gc()

## ----renameColumns-------------------------------------------------------
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


## ----descriptiveActivity-------------------------------------------------
combinedData$Activity <- activityLabels$Activity[combinedData$Activity]

## ----calculateAverages, warning=FALSE, message=FALSE---------------------

library(dplyr)

# Create symbols for the columns we wish to group by
groupCols <- names(combinedData)[(1:2)]

# Find the columns we actually want to take the mean of:
valCols <- grep("\\.mean",names(combinedData),value = TRUE)

# Use the dplyr package to group the data and find means
combinedData.summary <- (combinedData %>% 
  group_by_(.dots=groupCols) %>% 
  summarize_each_(funs(mean),vars=valCols))


## ----writeNewData--------------------------------------------------------
write.csv(x = combinedData.summary, file = "activityMonitor.csv", row.names=FALSE)

