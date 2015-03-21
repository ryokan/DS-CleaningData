features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
subject_all <- rbind(subject_test, subject_train)
X_all <- rbind(X_test, X_train)
Y_all <- rbind(Y_test, Y_train)
colnames(X_all) <- features[,2]
varnames <- features[,2]
meanstdvars <- regexpr("-mean\\(", varnames)>0 | regexpr("-std\\(", varnames)>0
X_meanstd <- X_all[,meanstdvars]

Y_labels <- apply(as.matrix(Y_all), 1, function(x) activity_labels[x,2])

data <- cbind(subject_all, Y_labels, X_meanstd)
colnames(data)[1:2] <- c("subject", "activity")

splitted <- split(data, list(data$subject, data$activity))

means <- t (sapply(splitted, function(x) apply(as.data.frame(x)[,3:68], 2, mean)))
subject <- lapply(splitted, function(x) as.data.frame(x)[1,1])
activity <- lapply(splitted, function(x) as.data.frame(x)[1,2])
tidy.data <- cbind(subject, activity, means)
write.table(tidy.data, file = "tidydata.txt", row.names = FALSE)
