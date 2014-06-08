Getting Data class project
=============================

Purpose
-------------------------------

The purpose of this document is to describe my solution to the class project for the Getting Data Coursera class (http://class.coursera.org/getdata-004/).

Assignment
------------------------------

The assignment is as follows:

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

> Here are the data for the project: 

> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

> You should create one R script called run_analysis.R that does the following. 

> 1. Merges the training and the test sets to create one data set.
> 1. Extracts only the measurements on the mean and standard deviation for each measurement. 
> 1. Uses descriptive activity names to name the activities in the data set
> 1. Appropriately labels the data set with descriptive variable names. 
> 1. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

> Good luck!

Files
---------------------------------------------

File | Description
-----|------------
Readme.md | This file
run_analysis.R | R file that accomplishes the objectives set forth in the assignment
data/project.zip | The data, already downloaded from the url above on 6/8/2014
doc/UCI Machine Learning Repository_ Human Activity Recognition Using Smartphones Data Set | description of the data

Description of the solution
----------------------------------------------

To accomplish the objectives of the assignment, the R file does the following:

* Downloading/extracting data
  * Assume the project data file has been downloaded to data/project.zip
  * If the UCI HAR Dataset directory does not yet exist, unzip data/project.zip
* Reading data
  * Read the following files into data.frames: data/UCI HAR Dataset/train/subject_train.txt, data/UCI HAR Dataset/train/X_train.txt, data/UCI HAR Dataset/train/y_train.txt
  * Read the following files into data.frames: data/UCI HAR Dataset/test/subject_train.txt, data/UCI HAR Dataset/test/X_train.txt, data/UCI HAR Dataset/test/y_train.txt
  * Read the data/UCI HAR Dataset/features.txt as if it were a dataset, to be able to manipulate labels in a semi-automated fashion
* Manipulating labels
  * Finding out which labels are means or standard deviations by looking for `mean(` and `std(` in the label names
  * Removing parens and converting dashes to periods to prettify the R table
  * Reading in the activity_labels.txt
  * Merging with Y_train, not sorting
  * Dropping the original code
* Manipulating data
  * Subsetting the X_train set on the labels discovered above
  * `cbind`ing the three datasets, along with a column that says "Train" to keep track of source during concatenation
  * Naming the variables using "subject",labels found above,"activity"
* Repeat the above manipulations for test data, labeling the records as "Test"
* Using the `plyr` package, create a new dataset giving the average of each variable by subject and activity within subject

Acknowledgments
----------------------------------------------

The data were obtained using the following source:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
