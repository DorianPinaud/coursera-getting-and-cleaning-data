library(dplyr)

pathsTrain <- c("UCI HAR Dataset/train/subject_train.txt",
                "UCI HAR Dataset/train/y_train.txt", 
                "UCI HAR Dataset/train/X_train.txt",
                "UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", 
                "UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt",
                "UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt",
                "UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", 
                "UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt",
                "UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt",
                "UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", 
                "UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt",
                "UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")

pathsTest <- c("UCI HAR Dataset/test/subject_test.txt",
               "UCI HAR Dataset/test/y_test.txt",
               "UCI HAR Dataset/test/X_test.txt",
               "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",
               "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt",
               "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt",
               "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt",
               "UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt",
               "UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt",
               "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt",
               "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt",
               "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")

loadData <- function(paths)
{
    data <- read.table(paths[[1]])
    print(paste("load data", paths[[1]], sep = " "))
    for (i in 2:length(paths))
    {
        new.data <- read.table(paths[[i]])
        print(paste("load data", paths[[i]], sep = " "))
        data <- cbind(data, new.data)
    }
    data
}

dataTest <- loadData(pathsTest)
print("data test fully loaded")
dataTrain <- loadData(pathsTrain)
print("training data fully loaded")
data <- rbind(dataTest, dataTrain)
print("data fully merged")

features <- read.table("UCI HAR Dataset/features.txt")
print("get features")
dataName <- "Subject"
dataName <- c(dataName, "Activity")
dataName <- c(dataName, as.character(features[,2]))
names(data) <- dataName
print("attribute variable name to the data set")

featureWanted <- grep(".*(mean\\(|std\\()).*", colnames(data), value=TRUE, ignore.case=TRUE)
data <- cbind(data[,1:2], data[,which(names(data) %in% featureWanted)])

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels <- as.character(activityLabels[,2])
data[,2] <- as.character(data[,2])
for (i in 1:length(activityLabels))
{
    data[,2] <- replace(data[,2], data[,2] == as.character(i), activityLabels[[i]])
    print(paste("replace the activity number", i, "with the activity label", activityLabels[[i]], sep=" "))
}
print("replace all activity numbers by the activity labels")