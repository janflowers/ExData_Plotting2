plot5 <- function(){
  
  ## Read in the datasets. This first line will likely take a few seconds. Be patient!
  NEI <<- readRDS("./summarySCC_PM25.rds")
  SCC <<- readRDS("./Source_Classification_Code.rds")
  
  library(ggplot2)
  
  #subset of baltimore data
  baltimoreCity <<- NEI[NEI$fips=="24510",]
  
  #search for motor vehicle categories
  srchVehicle <- grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE)
  subSCC <- SCC[srchVehicle,]
  
  #subset baltimore data to only include vehicle categories from search
  baltimoreVehicleNEI <- subset(baltimoreCity, SCC %in% subSCC$SCC)
  
  #sum of emissions by year of the vehicle related subset
  sumofBaltVehicle <<- aggregate(Emissions ~ year, baltimoreVehicleNEI, sum)
  
  #create bar graph
  png("plot5.png", height=480, width=480, units = "px")
  barplot(sumofBaltVehicle$Emissions, 
          names.arg = sumofBaltVehicle$year, 
          main="PM2.5 Motor Vehicle Emissions for Baltimore City, 1999-2008", 
          xlab = "Year", 
          ylab="In Tons")
  
  #close charting device
  dev.off()
  
}