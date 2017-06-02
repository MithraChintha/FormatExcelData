library(data.table)
getwd()
setwd("F:/Work/Progressive Insights/")
#Change the directory "2014-2015" to get the data for other years
path = "F:/Work/Progressive Insights/10182016/2016-2017/A.Monthwise/"

#get all sub directories
Directories <- list.dirs(path, recursive = F)

target <- data.frame()

start = 1
merge = 0
#loop to get the files in the directory
for (i in 1:length(Directories)) {
  SubDirectories  <- list.dirs(Directories[i],recursive = F)
  SubDirectories <- str_replace(SubDirectories,"//","/")
  for (j in 1:length(SubDirectories)) {
    #All xlsx files in a folder
    Allfiles <- list.files(SubDirectories[j], pattern = "*.xlsx")

    if (length(Allfiles) > 0) {
      for (k in 1:length(Allfiles)) {
        #format data function loads the data, transpose the data
        system.time(data <-
                      formatData(SubDirectories[j], fileName = Allfiles[k]))
        #if the loop is for the first time then it is assigned to data
        #from second time onwards it is concatenated
        if (start == 1) {
          target <- data
          start = 2
        } else{
          target <- rbind(target, as.data.frame(data))
        }
        data <- data.frame()
      }
    }

    #Every time the prepared data reached 1000 rows data will be dumped into excel file to clean the in memory
    if(nrow(target)>1000){
    target <- setDT(target, keep.rownames = TRUE)
    if (merge == 0) {
      merge = 1
      write.csv(target, "Cumulative.csv",row.names = FALSE)
    } else{
      cumulative <-read.csv("Cumulative.csv",check.names = F)
      write.csv(rbind(cumulative,target),"Cumulative.csv",row.names = FALSE)
    }
    target <- data.frame()
    cumulative <- data.frame()

    }
  }


  }
View(target[,200:231])
#merge 3 years data
part1 <- read.csv("F:/Work/Progressive Insights/Cumulative_2014-2015.csv", dec=",")
part2 <- read.csv("F:/Work/Progressive Insights/Cumulative_2015-2016.csv", dec=",")
part3a <- read.csv("F:/Work/Progressive Insights/Cumulative_2016-2017_a.csv", dec=",")
part3b <- read.csv("F:/Work/Progressive Insights/Cumulative_2016-2017_b.csv", dec=",")


Final <- rbind(part1,part2,part3a,part3b)
colnames(Final)[1] <- "Sub-district"

rm(part1)
rm(part2)
rm(part3b)
rm(part3a)

write.csv(Final,"F:/Work/Progressive Insights/FinalHealthData.csv")




