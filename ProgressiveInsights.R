colnames(FinalHealthData)

finalData <-  cbind(FinalHealthData$`Sub-district`,FinalHealthData$District,FinalHealthData$Month,FinalHealthData$FinancialYear)
rm(finalData)
length(unique(FinalHealthData$FinancialYear))

unique(FinalHealthData$District)


str(FinalHealthData)
