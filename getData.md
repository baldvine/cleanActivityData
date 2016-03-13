# Get and Unzip Data
Baldvin Einarsson  
March 12, 2016  




```r
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipName <- "activityData.zip"
```


This markdown file generates an `R` script which obtains the data and unzips it into a file called activityData.zip. The data comes from the following location:


[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

We start by downloading the file (if needed):


```r
if (!file.exists(zipName)){
  download.file(url=fileURL, destfile = zipName, method='curl')
}
```

Then, we unzip it:


```r
# Get the file names of the files in the zip:
zippedFiles <- unzip(zipfile = zipName, list=TRUE)
# Obtain the directory name:
zipDir <- strsplit(zippedFiles$Name[1],split="/")[[1]][1]

if (!file.exists(zipDir)){
  unzip(zipfile = zipName)
}
```

Note that this file will not be included in the GitHub repository.
