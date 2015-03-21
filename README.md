# DS-CleaningData

To make a tidy data from an experiment to measure human activity using smartphones.
Full descriptions are shown below.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Original Data

* features.txt: measured features. consists 561 features
* activity_labels.txt: give 6 activity categories appropriate labels, e.g. WALKING, WALKING_UPSTAIRS, ...

The following data are divided to two sets, one training and another test.
* subject (subject_train.txt and subject_test.txt): person number.
* X (X_train.txt and X_test.txt): calcurated data from measured values.
* y (y_train.txt and y_test.txt): activity number. the value meaning is described in activity_labels.txt.

## Data processing

* First read all the data using read.table
* Merge train data and test data using rbind. [Task 1]
* Give column names to X using features.txt
* Select only mean data and std data by regexp matching to features. Name the extracted data as "X_meanstd" [Task 2]
* Convert activity numbers to activity labels using activity_labels.txt data. Name this vector as "Y_labels" [Task 3]
* Combine subject data, activity label data and extracted measure data. Name this as "data"
* Give the variables appropriate names. Just give two variables because others have already given a sufficient level descriptive names [Task 4]
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
** split the data for each activity and each subject
** give each variables' avarages.
** create the second tidy data by adding subject variables and activity variables. Names it "tydy.data"

