This is the README for the final course project of the course "Getting
and Cleaning Data". The analysis file for this project is called
"run\_analysis.R" and it does the following :

1.  Download and unzip dataset if it does not already exist.

2.  Read in all features and activity names.

3.  Read in testdata and naming its variables. Add subject and
    activity column.

4.  Read in traindata and naming its variables. Add subject and
    activity column.

5.  Merge traindata and testdata sests.

6.  Extract only variables that are measurements on mean on
    standard deviation.

7.  Create a second independet dataset with the average of each variable
    for each activity and each subject.

8.  Save the new dataset in the file "tidydata.csv".
