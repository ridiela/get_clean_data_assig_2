#1 Merges the training and the test sets to create one data set.

#get and format features labels
col_names <- read.table("./data/UCI HAR Dataset/features.txt")
vect_label<-as.character(col_names$V2)

#get training set
train_values<-read.csv("./data/UCI HAR Dataset/train/X_train.txt",sep="",header=FALSE,col.names=vect_label)
train_labels<-read.csv("./data/UCI HAR Dataset/train/y_train.txt",header=FALSE,col.names="labels")
train_subjects<-read.csv("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE,col.names="subjects")

#get test set
test_values<-read.csv("./data/UCI HAR Dataset/test/X_test.txt",sep="",header=FALSE,col.names=vect_label)
test_labels<-read.csv("./data/UCI HAR Dataset/test/y_test.txt",col.names="labels",header=FALSE)
test_subjects<-read.csv("./data/UCI HAR Dataset/test/subject_test.txt",col.names="subjects",header=FALSE)

#unite test data
test_data<-cbind(test_values,test_labels)
test_data<-cbind(test_data,test_subjects)

#unite train data
train_data<-cbind(train_values,train_labels)
train_data<-cbind(train_data,train_subjects)

#merge all
merged_data<-merge(test_data,train_data,all=TRUE)

dim(test_data)
dim(train_data)
dim(merged_data)

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#mean on everything except the two last columns, labels and subjects
#feature_means<-apply(merged_data[,-(562:563)],2,mean)
#feature_variances<-apply(merged_data[,-(562:563)],2,var)
#gets labels and substracts those columns whose label contains "mean" or "std", in a case_sentitive search

var_lab<-names(merged_data)
merged_data_subset<-subset(merged_data, select = var_lab[grepl("std",tolower(var_lab)) | grepl("mean",tolower(var_lab))])

#add labels and subjects columns
merged_data_subset$labels <-merged_data$labels
merged_data_subset$subjects <-merged_data$subjects

#3 Uses descriptive activity names to name the activities in the data set

assigner<-read.csv("./data/UCI HAR Dataset/activity_labels.txt",col.names=c("number","value"),sep=" ",header=FALSE)
merged_data_subset3<-merge(merged_data_subset,assigner,by.x="labels",by.y="number",all=TRUE)
#substract $labels column
merged_data_subset3<-merged_data_subset3[,-(1)]

#4 Appropriately labels the data set with descriptive activity names. 

datanames <-names(merged_data_subset3)

names(merged_data_subset3)<-gsub("Acc","Acceleration ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("Gyro","Gyroscope ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("Mag","Magnitude ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("std","Standard_Deviation ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("Freq","Frequency ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("Mean","Mean ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("mean","Mean ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("Body","Body ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("Jerk","Jerk ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("Gravity","Gravity ",names(merged_data_subset3))
names(merged_data_subset3)<-gsub("gravity","Gravity ",names(merged_data_subset3))

#5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

merged_data_subset_last<-aggregate(. ~ subjects + value, data= merged_data_subset3, mean)
write.csv(merged_data_subset_last,"./data/UCI HAR Dataset/clean_dataset.csv")
