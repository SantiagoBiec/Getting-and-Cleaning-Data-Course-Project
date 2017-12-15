# Read the datasets

rm(list=ls())
library(plyr)
library(reshape2)


# Steps 1,2,4

measures = c("body_acc_x", "body_acc_y", "body_acc_z", 
                 "body_gyro_x", "body_gyro_y", "body_gyro_z",
                 "total_acc_x","total_acc_y","total_acc_z")


folders = c("test","train")

df = data.frame()

# Loop through test and train folders
for (f in folders){
    
    activity = read.table(paste0("UCI HAR Dataset/",f,"/y_",f ,".txt"))
    subject = read.table(paste0("UCI HAR Dataset/",f,"/subject_",f,".txt"))
    
    activity = activity$V1
    subject = subject$V1
    
    #Intialize an auxiliary dataframe with the activity and subject variables
    df_aux = data.frame(activity, subject)
    path = paste0("UCI HAR Dataset/",f,"/Inertial Signals/")
    
    # Loop through all the measures in the Intertial Signals Folder
    for (m in measures){
        x = read.table(paste0(path,m,"_",f,".txt"))
        #C ompute the mean and standar deviation of the measures
        avg = apply(x,1,mean)
        sd = apply(x,1,sd)
        
        splitted = strsplit(m,"_")
        var_name = paste(splitted[[1]][1],splitted[[1]][2],splitted[[1]][3],sep = ".")
        # Add them to the auxiliary dataframe
        df_aux[[paste0(var_name,".mean")]] = avg
        df_aux[[paste0(var_name,".sd")]] = sd
        
    }
    #Add the auxiliary dataframe to the master one
    df = rbind(df,df_aux)
}

# Step 3: Rename activity variable
activity = as.factor(df$activity)

x=revalue(activity,c("1"="walking","2"="walking_upstairs","3"="walking_downstairs",
                  "4"="sitting","5"="standing","6"="laying"))
df["activity"] = x


# Step 5
melted <- melt(df, id=c("subject","activity"))
tidy <- dcast(melted, subject+activity ~ variable, mean)

write.table(df,,row.names = F)
