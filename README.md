# Activity Data
Get and tidy accelerometers data. Original data is described here:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

However, we work with a zip file which can be downloaded here:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
## Relevant files

* `getData.R` Download and unzip the data. Created via an R-markdown file of the same name.
* `run_analysis.R` Script to merge the test and training datasets in zip file above. Also creates a tidy data set called `activityMonitors.csv`. See accompanying markdown file, which creates the script.
* `CodeBook.md` Code book for the tidy data in the file `activityMonitors.csv`
