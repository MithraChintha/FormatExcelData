#rm(list = ls())

library(xlsx)
library(stringr)



formatData <- function(path,fileName){

data<-  read.xlsx(paste(path,"/",fileName,sep=""),sheetIndex = 1,startRow = 6)
#Delete the unwanted columns
data$NA..1 <- NULL
data$NA..3 <- NULL
data$NA. <- NULL
#delete the rows with the feature name as NA
data <- data[!is.na(data$NA..2),]

#Transpose the data to merge the data conviniently
data<- t(data)
colnames(data)[1:ncol(data)] <- data[1,1:ncol(data)]
data <- data[2:nrow(data),]
data <-as.data.frame(data)
#path<- "F:\\Work\\Progressive Insights\\10182016\\2015-2016\\A.Monthwise\\Andhra Pradesh\\Guntur"
values <- str_split(path,pattern = "/")
data$FinancialYear <-   rep(values[[1]][5],nrow(data))
data$State <- values[[1]][7]
data$District<-  values[[1]][8]
fileName <- str_split(fileName,"_")[[1]][2]
data$Month<-str_split(fileName,".xlsx")[[1]][1]
return(as.matrix(data))
}


