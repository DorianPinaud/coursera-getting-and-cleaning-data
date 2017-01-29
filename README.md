# coursera-getting-and-cleaning-data
Repository for the final assessment of "getting and cleaning data" coursera course.

The run_analysis.R file operates the following action:
* Gets all the data from the UCI HAR DataSet. **(line 42)**
* Merges the test and the train dataset. **(line 46)**
* Sets the names of each variables in the data set from the features file. **(line 49)**
* Grep the features with the mean() and std() attributes and exclude the others. **(line 57)**
* Replace the activity number with the activity label for each record. **(line 60)**
* Add a column with the average of the variables. **(line 70)**