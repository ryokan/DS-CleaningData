# First read all the data.

features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

subject_test <- read.table("./test/subject_test.txt")
subject_train <- read.table("./train/subject_train.txt")
X_test <- read.table("./test/X_test.txt")
X_train <- read.table("./train/X_train.txt")
Y_test <- read.table("./test/Y_test.txt")
Y_train <- read.table("./train/Y_train.txt")

# Merge train data and test data using rbind [Task 1]

subject_all <- rbind(subject_test, subject_train)
X_all <- rbind(X_test, X_train)
Y_all <- rbind(Y_test, Y_train)

# Give column names to X using features.txt

colnames(X_all) <- features[,2]

# Select only mean data and std data by regexp matching to features. [Task 2]

varnames <- features[,2]
meanstdvars <- regexpr("-mean\\(", varnames)>0 | regexpr("-std\\(", varnames)>0
X_meanstd <- X_all[,meanstdvars]

# Convert activity numbers to activity labels using activity_labels.txt data

Y_labels <- apply(as.matrix(Y_all), 1, function(x) activity_labels[x,2])

# combine subject data, activity label data and extracted measure data. 

data <- cbind(subject_all, Y_labels, X_meanstd)

# Give the variables. 
# Just give two variables because others have already given a sufficient level descriptive names [Task 3]

colnames(data)[1:2] <- c("subject", "activity")

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## split the data for each activity and each subject
splitted <- split(data, list(data$subject, data$activity))

## give each variables' avarages.
means <- t (sapply(splitted, function(x) apply(as.data.frame(x)[,3:ncol(data)], 2, mean)))

## create the second tidy data by adding subject variables and activity variables.
subject <- lapply(splitted, function(x) as.data.frame(x)[1,1])
activity <- lapply(splitted, function(x) as.data.frame(x)[1,2])
tidy.data <- cbind(subject, activity, means)

# Write into a text files
write.table(tidy.data, file = "tidydata.txt", row.names = FALSE)
