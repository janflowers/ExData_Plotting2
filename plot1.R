plot1 <- function(){
  
  ## Read in the datasets. This first line will likely take a few seconds. Be patient!
  NEI <<- readRDS("./summarySCC_PM25.rds")
  SCC <<- readRDS("./Source_Classification_Code.rds")
  
  library(ggplot2)
  
  # sum of all emissions by year
  sumByYear <<- aggregate(Emissions ~ year, NEI, sum)  
  
  # create bar graph
  png("plot1.png", height=480, width=480, units = "px")
  barplot(sumByYear$Emissions/10^3, 
          names.arg = sumByYear$year, 
          main="PM2.5 Emissions for United States, 1999-2008", 
          xlab = "Year", 
          ylab="In Tons (10^3)")
  
  # close charting device
  dev.off()
  
}