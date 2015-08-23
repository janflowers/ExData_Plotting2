plot3 <- function(){
  
  ## Read in the datasets. This first line will likely take a few seconds. Be patient!
  NEI <<- readRDS("./summarySCC_PM25.rds")
  SCC <<- readRDS("./Source_Classification_Code.rds")
  
  library(ggplot2)
  
  # filter NEI dataset by baltimore city and sum of emissions by year and by type
  baltimoreCity <<- NEI[NEI$fips=="24510",]
  baltimoreByType <- aggregate(x=baltimoreCity$Emissions, by=list(year=baltimoreCity$year, type=baltimoreCity$type), FUN=sum)
  
  # create line graph to see over time across types
  png("plot3.png", height=480, width=480, units = "px")
  theplot <- ggplot(baltimoreByType, aes(x=factor(year), y=x, group=type, colour=type)) +
    geom_line(size=1.25) +
    geom_point(size=4, shape=19) +
    xlab("Year") + ylab("in Tons") + ggtitle("PM2.5 Emissions for Baltimore City, 1999-2008 By Source Type") +
    scale_colour_hue(name="Type", l=30)
  print(theplot)
  
  # close charting device
  dev.off()
  
}