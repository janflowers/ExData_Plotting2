plot4 <- function(){
  
  ## Read in the datasets. This first line will likely take a few seconds. Be patient!
  NEI <<- readRDS("./summarySCC_PM25.rds")
  SCC <<- readRDS("./Source_Classification_Code.rds")
  
  library(ggplot2)
  
  #search EI.Sector column for combustion related categories, then from that subset,
  #search for coal related categories in the detailed level four column
  srchCombEI <- grepl("comb", SCC$EI.Sector, ignore.case=TRUE)
  subSCC <- SCC[srchCombEI,]
  srchCoalLvl4 <- grepl("coal", subSCC$SCC.Level.Four, ignore.case=TRUE)
  subSCC <- subSCC[srchCoalLvl4,]
  
  #subset the NEI data set with those categories found in the search
  combcoalNEI <- subset(NEI, SCC %in% subSCC$SCC)
  
  #sum of emissions by year of the combustion coal related subset
  sumOfCombCoal <<- aggregate(Emissions ~ year, combcoalNEI, sum)
  
  #create bar graph
  png("plot4.png", height=480, width=480, units = "px")
  barplot(sumOfCombCoal$Emissions/10^3, 
          names.arg = sumOfCombCoal$year, 
          main="PM2.5 Coal Combustion-Related Emissions for United States, 1999-2008", 
          xlab = "Year", 
          ylab="In Tons (10^3)")
  
  #close charting device
  dev.off()
  
}