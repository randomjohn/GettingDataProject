# R analysis file for Coursera Getting Data class project
# see Readme.md for details


# set globals and parameters ----------------------------------------------

data.root <- file.path("data/UCI HAR Dataset")


# extract data ------------------------------------------------------------

# we assume we have downloaded the UCI HAR dataset from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# along with the description
# if we have not already, unzip the file
# note I assume that there is no tampering with the files inside the directory

if (!file.exists("data/UCI HAR Dataset")) {
  unzip("data/project.zip",exdir="data")
}


# read and manipulate feature labels ---------------------------------

# now, read in the feature labels
feat.lab <- read.table(file.path(data.root,"features.txt"))
# which variables are for mean or standard deviations?
to.keep <- grep("mean\\(|std\\(",feat.lab[,2])
# create labels from these features - take out parens and turn dashes to periods
feat.lab.pretty <- feat.lab[to.keep,2]
feat.lab.pretty <- gsub("\\(|\\)","",feat.lab.pretty)
feat.lab.pretty <- gsub("-",".",feat.lab.pretty)


# read and manipulate activity labels --------------------------------

activity.labels <- read.table(file.path(data.root,"activity_labels.txt"))
names(activity.labels) <- c("code","activity.label")

# read and manipulate training data ------------------------------------------------------------

# first, read in the training datasets
sub.train <- read.table(file.path(data.root,"train/subject_train.txt"))
X.train <- read.table(file.path(data.root,"train/X_train.txt"))
Y.train <- read.table(file.path(data.root,"train/Y_train.txt"))

# subset X.train (done here to save memory)
X.train <- X.train[,to.keep]

# merge activity labels
Y.train.lab <- merge(Y.train,activity.labels,by.x="V1",by.y="code",sort=FALSE)
Y.train.lab <- Y.train.lab[,2] # drop the code

# horizontally concatenate datasets and set labels
train <- cbind(sub.train,X.train,Y.train.lab,"Train")
names(train) <- c("Subject",feat.lab.pretty,"activity","Dataset")


# read and manipulate test data -------------------------------------------------------

sub.test <- read.table(file.path(data.root,"test/subject_test.txt"))
X.test <- read.table(file.path(data.root,"test/X_test.txt"))
Y.test <- read.table(file.path(data.root,"test/Y_test.txt"))

# subset X.test (done here to save memory)
X.test <- X.test[,to.keep]

# merge activity labels
Y.test.lab <- merge(Y.test,activity.labels,by.x="V1",by.y="code",sort=FALSE)
Y.test.lab <- Y.test.lab[,2] # drop the code

# horizontally concatenate datasets and set labels
test <- cbind(sub.test,X.test,Y.test.lab,"Test")
names(test) <- c("Subject",feat.lab.pretty,"activity","Dataset")


# concatenate train and test ----------------------------------------------

activity <- rbind(train,test)


# final renaming - t to time and f to freq --------------------------------

names(activity) <- sub("^t(.+)$","time\\1",names(activity))
names(activity) <- sub("^f(.+)$","freq\\1",names(activity))

if (!file.exists("outdata")) dir.create("outdata")
write.table(activity,"outdata/activity.txt",row.names=F)

# create new dataset of average of subject and activity within sub --------

library(plyr)
activity.2 <- activity[,-ncol(activity)]
nc <- ncol(activity.2)-1
activity.mean <- ddply(activity.2,.(Subject,activity),function(x) colMeans(x[,1:nc]))

write.table(activity.mean,"outdata/activity_mean.txt",row.names=F)
