# Getting and Cleaning Data Course Project

#load required packages
library(dplyr)
library(tidyr)

# dowload and unzip data into the /data folder
if(!dir.exists('./data')) {
    dir.create('./data')
}
if(!file.exists('./data/dataset.zip')){
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
                  destfile = './data/dataset.zip',
                  mode = 'wb')
}
if(!file.exists('./data/UCI HAR Dataset')){
    unzip(zipfile = './data/dataset.zip',
          exdir = './data')
}

########### Reading in all data and naming them appropriately ##################
###3.Use descriptive activity names to name the activities in the data set######
####4.Appropriately label the data set with descriptive variable names.#########

# read in all features
features <- as.character(
    read.table('./data/UCI HAR Dataset/features.txt')$V2
    )

# read in activity names
activity_names <- read.table('data/UCI HAR Dataset/activity_labels.txt')$V2



# read in the test data
testdata_activities <- as.factor(
    read.table('./data/UCI HAR Dataset/test/y_test.txt',header = FALSE)$V1
    )
levels(testdata_activities) <- activity_names # actual activity names as levels

testdata <- read.table('./data/UCI HAR Dataset/test/x_test.txt', header = FALSE)
testdata_subject <- read.table('./data/UCI HAR Dataset/test/subject_test.txt',
                               header = FALSE)$V1

# name the testdata sets' variables for easier working afterwards
# each feature vector is a row in the data set
names(testdata) <- features

# add labels and subjects column
testdata <- cbind(subject = testdata_subject, activity = testdata_activities,
                  testdata)



# read in the train data
traindata_activities <- as.factor(
    read.table('./data/UCI HAR Dataset/train/y_train.txt', header = FALSE)$V1
    )
levels(traindata_activities) <- activity_names # actual activity names as levels

traindata <- read.table('./data/UCI HAR Dataset/train/X_train.txt',
                        header = FALSE)
traindata_subject<- read.table('./data/UCI HAR Dataset/train/subject_train.txt',
                                header = FALSE)$V1

# name the traindata sets' variables for easier working afterwards
# each feature vector is a row in the data set
names(traindata) <- features

# add labels and subjects column
traindata <- cbind(subject = traindata_subject, activity = traindata_activities,
                   traindata)


########1.Merge the training and the test sets to create one data set.##########

# merge test data and train data together
data <- rbind(testdata, traindata)
names(data)


####2.Extract only the measurements on the mean and standard deviation #########
########################for each measurement.###################################

# exctract only mean and sd for each measurement
relevant_colums <- grepl(pattern = "subject|activity|mean\\(\\)|std\\(\\)", 
                         names(data))
#relevant_colums_names <- grep(pattern="subject|activity|mean\\(\\)|std\\(\\)", 
#                              names(data), value = TRUE)
data <- data[,relevant_colums]



####5.From the data set above, creates a second, independent tidy data set #####
######with the average of each variable for each activity and each subject.#####

newdata <- data %>% group_by(subject, activity) %>% summarise_all(funs(mean))

# write the new tidy data into a text file tidydata.txt
write.csv(newdata, file = "tidydata.csv", row.names = FALSE, quote = FALSE)
