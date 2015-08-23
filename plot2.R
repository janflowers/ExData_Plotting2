plot2 <- function(){
  
  ## Read in the datasets. This first line will likely take a few seconds. Be patient!
  NEI <<- readRDS("./summarySCC_PM25.rds")
  SCC <<- readRDS("./Source_Classification_Code.rds")
  
  library(ggplot2)
  
  # filter NEI dataset by baltimore city and sum of emissions by year
  baltimoreCity <<- NEI[NEI$fips=="24510",]
  sumByBaltimore <<- aggregate(Emissions ~ year, baltimoreCity, sum)
  
  # create bar graph
  png("plot2.png", height=480, width=480, units = "px")
  barplot(sumByBaltimore$Emissions, 
          names.arg = sumByBaltimore$year, 
          main="PM2.5 Emissions for Baltimore City, 1999-2008", 
          xlab = "Year", 
          ylab="In Tons")
  
  # close charting device
  dev.off()
  
}