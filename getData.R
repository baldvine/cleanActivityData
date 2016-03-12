## ----setFileURL, echo=TRUE-----------------------------------------------
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipName <- "activityData.zip"

## ----downloadFile, echo=TRUE---------------------------------------------

if (!file.exists(zipName)){
  download.file(url=fileURL, destfile = zipName, method='curl')
}


## ----unzip, results='hide'-----------------------------------------------

# Get the file names of the files in the zip:
zippedFiles <- unzip(zipfile = zipName, list=TRUE)
# Obtain the directory name:
zipDir <- strsplit(zippedFiles$Name[1],split="/")[[1]][1]

if (!file.exists(zipDir)){
  unzip(zipfile = zipName)
}

