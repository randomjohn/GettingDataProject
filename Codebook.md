---
title: "Codebook"
author: "John Johnson"
date: "Thursday, June 19, 2014"
output: html_document
---

Purpose
-------------------

This document describes the data in the datasets "activity" and "activity.mean".

About the data
-------------------

These datasets were prepared for a class assignment for the "Getting and Cleaning Data" Coursera class. The assignment was as follows:

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

> Here are the data for the project: 

> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

> You should create one R script called run_analysis.R that does the following. 
>  * Merges the training and the test sets to create one data set.
>  * Extracts only the measurements on the mean and standard deviation for each measurement. 
>  * Uses descriptive activity names to name the activities in the data set
>  * Appropriately labels the data set with descriptive variable names. 
>  * Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

> Good luck!

Obtaining and manipulating data
-------------------------------

Data were obtained and manipulated according to the [Readme](Readme.html).

Variable name convention
-------------------------------

All variables come from processed accelerometer and gyroscope (all in 3 dimensions X, Y, and Z). 

Variable names are composites of several different characteristics:

  * Domain
    + __time__ variables are collected over time (variables were captured with a sampling rate of 50 Hz)
    + __freq__ variables are in the frequency domain, i.e. have had a Fast Fourier Transform applied and represent frequency components
  * Acceleration source (after acceleration is denoised using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz)
    + __body__ variables indicate the acceleration of the phone not due to gravity, as determined by splitting acceleration using a further low pass Butterworth filter with corner frequency 0.3 Hz.
    + __gravity__ variables indicate the acceleration due to gravity
  * Linear and angular velocity signals
    + __acc__ variables come from the accelerometer
    + __gyro__ variables come from the gyroscope
  * __jerk__ variables were derived from accelerometer and gyroscope signals
  * Dimension variables __X__, __Y__, and __Z__ are the three dimensions of the accelerometer and gyroscope
  * __mag__ variables are the Euclidean magnitude of the signal based on __X__, __Y__, and __Z__ (i.e. `mag = sqrt(x^2+y^2+z^2)`)
  * Summary statistics (from sliding window of time of 2.56 s)
    + __mean__ are means over the window
    + __std__ are standard deviations over the window
    
Finally, __Activity__ is the activity the subject was performing in the window, and __Dataset__ is the source of the observation (train or test data).