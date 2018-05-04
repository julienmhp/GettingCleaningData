## Set Working Directory with setwd()
URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL,destfile="Dataset.zip",method="curl")

## Upload datasets
	setwd("./test")
		xtest<-read.table("X_test.txt")
		ytest<-read.table("y_test.txt")
		stest<-read.table("subject_test.txt")
	setwd("..")	
	setwd("./train")
		xtrain<-read.table("X_train.txt")	
		ytrain<-read.table("y_train.txt")
		strain<-read.table("subject_train.txt")
	setwd("..")
			
## Put data sets together
	train<-cbind(strain,ytrain,xtrain)
	test<-cbind(stest,ytest,xtest)
		data<-rbind(test,train)

## Upload and fidle with features (column names)
	features<-read.table("features.txt")	
		features[,2]<-as.character(features[,2])		
		featuress<-features[,2]		
			featuress<-gsub("[-()]","",featuress)
			featuress<-gsub("mean","Mean",featuress)	
			featuress<-gsub("std","Std",featuress)
			featuress<-gsub("mad","Mad",featuress)
			featuress<-gsub("max","Max",featuress)
			featuress<-gsub("min","Min",featuress)
			featuress<-gsub("sma","Sma",featuress)
			featuress<-gsub("energy","Energy",featuress)
			featuress<-gsub("igr","Igr",featuress)
			featuress<-gsub("entropy","Entropy",featuress)
			featuress<-gsub("arCoeff","ArCoef",featuress)
			featuress<-gsub("correlation","Correl",featuress)
			featuress<-gsub("maxInds","MaxInds",featuress)
			featuress<-gsub("meanFreq","MeanFreq",featuress)
			featuress<-gsub("skewness","Skew",featuress)
			featuress<-gsub("kurtosis","Kurt",featuress)
			featuress<-gsub("bandsEnergy","BandsEnergy",featuress)
			featuress<-gsub("angle","Angle",featuress)
## Upload and fiddle with activity labels
	labels<-read.table("activity_labels.txt")	
		labels[,2]<-as.character(labels[,2])
## Naming the dataset
	colnames(data)<-c("Subject","Activity",featuress)
	
## Prepare data for formatting
	data$Activity<-factor(data$Activity,levels=labels[,1],labels=labels[,2])
		data$Subject<-factor(data$Subject)
## Selecting only Subject and Activity columns and columns with Mean or Std
	where<-grep("Subject|Activity|Mean|Std",names(data))
		dataa<-data[,where]
## Format data
	library(reshape2)
		dataa.m<-melt(dataa,id=c("Subject","Activity"))
			dataa.mean<-dcast(dataa.m,Subject+Activity~variable,mean)

## Save formatted data
	write.table(dataa.mean,file="TidyDataSet.txt")