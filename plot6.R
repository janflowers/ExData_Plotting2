plot6 <- function(){
  
  ## Read in the datasets. This first line will likely take a few seconds. Be patient!
  NEI <<- readRDS("./summarySCC_PM25.rds")
  SCC <<- readRDS("./Source_Classification_Code.rds")
  
  library(ggplot2)
  
  #search for motor vehicle categories
  srchVehicle <- grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE)
  subSCC <- SCC[srchVehicle,]
  
  #subset all NEI data of vehicle related categories
  vehicleNEI <- subset(NEI, SCC %in% subSCC$SCC)
  
  #subset baltimore data from vehicle subset
  baltimoreVehicle <- vehicleNEI[vehicleNEI$fips=="24510",]
  baltimoreVehicle <- aggregate(Emissions ~ year, baltimoreVehicle, sum)
  baltimoreVehicle$location <- "Baltimore"
  
  #subset LA data from vehicle subset
  laVehicle <- vehicleNEI[vehicleNEI$fips=="06037",]
  laVehicle <- aggregate(Emissions ~ year, laVehicle, sum)
  laVehicle$location <- "LA" 
  
  #combine the baltimore and LA subsets
  bothVehicleNEI <- rbind(baltimoreVehicle, laVehicle)
  
  #create bar graph
  png("plot6.png", height=480, width=600, units = "px")
  theplot <- ggplot(bothVehicleNEI, aes(x=factor(year), y=Emissions, group=location, colour=location)) +
    geom_line(size=1.25) +
    geom_point(size=4, shape=19) +
    xlab("Year") + ylab("in Tons") + ggtitle("PM2.5 Vehicle Emissions for Baltimore and LA, 1999-2008") +
    scale_colour_hue(name="City", l=30)
  print(theplot)
  
  #close charting device
  dev.off()
  
}