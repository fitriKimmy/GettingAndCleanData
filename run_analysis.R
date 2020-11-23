install.packages("writexl")
install.packages("qdapTools")
library("writexl")
library(qdapTools)

subject_train <- read.table("./Data/train/subject_train.txt")
x_train <- read.table("./Data/train/X_train.txt")
y_train <- read.table("./Data/train/Y_train.txt")

subject_test <- read.table("./Data/test/subject_test.txt")
x_test <- read.table("./Data/test/X_test.txt")
y_test <- read.table("./Data/test/Y_test.txt")

features <- read.table("./Data/features.txt")

mergeSets <- rbind(x_train, x_test)
mergeSets$labels <- rbind(y_train, y_test)
mergeSets$subjects <- rbind(subject_train, subject_test)

colnames(mergeSets) <- features$V2

df2 <- mergeSets[,grepl("mean()|std()", names(mergeSets))]
df2 <- cbind(subjects = rbind(subject_train, subject_test), labels = rbind(y_train, y_test), df2)

colnames(df2)[1]<-"subject"
colnames(df2)[2]<-"activity"

activity_names <- read.table("./Data/activity_labels.txt")

## lookup the activities names according to given number
df2[,2] <- lookup(df2[,2], activity_names, key.reassign = NULL, missing = NA)

write.table(df2,"./data/tidy-data.txt", row.name=FALSE)

## Export final data into xlsx format
# write_xlsx(df2,"./data/tidy-data.xlsx")    
