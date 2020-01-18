## Getting and Cleaning Data Course Project
## Coursera Data Science
## Morgan Meeuwissen January 2020

## Setup
setwd("~/Coding-Repositries/R/Coursera/DataCleaning/")
require(dplyr)


## Load all required tables
activity_label_mapping<-read.table("UCIHARDataset/activity_labels.txt", 
                                   stringsAsFactors =FALSE)
feature_mapping<-read.table("UCIHARDataset/features.txt", 
                            stringsAsFactors =FALSE)

test_data<-read.table("UCIHARDataset/test/X_test.txt", stringsAsFactors =FALSE)
test_activities<-read.table("UCIHARDataset/test/y_test.txt", 
                            stringsAsFactors =FALSE)
test_subjects<-read.table("UCIHARDataset/test/subject_test.txt", 
                          stringsAsFactors =FALSE)

train_data<-read.table("UCIHARDataset/train/X_train.txt", stringsAsFactors =FALSE)
train_activities<-read.table("UCIHARDataset/train/y_train.txt", 
                             stringsAsFactors =FALSE)
train_subjects<-read.table("UCIHARDataset/train/subject_train.txt", 
                           stringsAsFactors =FALSE)


## Add set-specific data for the set origin, subject and activity and
## bind both sets into a combined dataframe
combined_data <-rbind(cbind(set_type=rep("train", nrow(train_data))
                            ,train_subjects,train_activities,train_data),
                      cbind(set_type=rep("test", nrow(test_data)),
                            test_subjects,test_activities,test_data))


## Apply variable naming with the temporary activity id matching the lookup table
## First need to fix duplicates, then add the extra columns
names_vector<-feature_mapping[,2] #Names from feature.txt
for (i in seq(2,length(names_vector))){
  if (sum(feature_mapping[,2]==feature_mapping[i,2])>1){  #Check if name is duplicated
    if (sum(feature_mapping[1:i,2]==feature_mapping[i,2])==1){
      names_vector[i]=paste0(feature_mapping[i,2],"-x")   #First duplicate is x
    }
    else if (sum(feature_mapping[1:i,2]==feature_mapping[i,2])==2){
      names_vector[i]=paste0(feature_mapping[i,2],"-y")   #Second duplicate is y
    }
    else if (sum(feature_mapping[1:i,2]==feature_mapping[i,2])==3){
      names_vector[i]=paste0(feature_mapping[i,2],"-z")   #Third duplicate is z
    }
  }
}
names_vector<-c("set.type", "subject.id","V1", names_vector)  #Add additional column names
names(combined_data)<-names_vector        #Apply naming to combined table


## Subset Data to only the means and standard deviations of measurements 
cleaned_data<-inner_join(activity_label_mapping,combined_data)%>%
  select(set.type, subject.id, V2, matches("^t.*-std.*|^t.*-mean.*"))%>%
  rename(activity.desc=V2)


## Replace column names with descriptive variables
clean_names<-names(cleaned_data)
for (i in seq(1, length(clean_names))) 
  {
  clean_names[i] = gsub("^t|\\(\\)-|\\(\\)","", clean_names[i]) #remove unnecessary characters
  clean_names[i] = gsub("()","", clean_names[i]) #remove unnecessary characters
  clean_names[i] = gsub("Acc","Acceleration", clean_names[i]) #Make acceleration explicit
  clean_names[i] = gsub("-std","StandardDeviation", clean_names[i]) #Make acceleration explicit
  clean_names[i] = gsub("Mag","Magnitude", clean_names[i]) #Make Magnitude explicit
  clean_names[i] = gsub("-mean","Mean", clean_names[i]) #Maintain camel case
}
names(cleaned_data)<-clean_names


## Create tidied data set
tidy_data<-select(cleaned_data, everything(), -set.type)%>%
  group_by(subject.id, activity.desc)%>%
  mutate_at(vars(-"activity.desc",-"subject.id"),mean)%>%
  distinct()

## Save tidied data
write.table(tidy_data,"CourseProject/output/tidy_data.txt", row.names = FALSE)
