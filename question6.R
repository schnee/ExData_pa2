# Exploratory Data Analysis Programming Assignment #2
# Question #6

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == 06037).
# Which city has seen greater changes over time in motor vehicle emissions?

require(dplyr)
require(ggplot2)
require(ggthemes)  

# read the files

if(sum(grepl("NEI", ls())) == 0){
  if(file.exists("data/summarySCC_PM25.rds")){
    NEI <- readRDS("data/summarySCC_PM25.rds")
  }
}
if(sum(grepl("SCC", ls())) == 0){
  if(file.exists("data/Source_Classification_Code.rds")){
    SCC <- readRDS("data/Source_Classification_Code.rds")
  }
}

NEI$Pollutant = factor(NEI$Pollutant)
NEI$fips = factor(NEI$fips)
NEI$type = factor(NEI$type)
NEI$SCC = factor(NEI$SCC)
#
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips ==
# "06037"). Which city has seen greater changes over time in motor vehicle
# emissions?
# 
# We typically do not count "vessels" ("boats") as vehicles, nor do we count "aircraft"
#
# here, we want SCC Level Two, whch shows the sources. Initially, we can 
# grep for "Vehicle"
#
# a "unique(SCC$SCC.Level.Two)" really helped here

SCCVehicle = SCC %>% filter(grepl(".*Vehicle.*", SCC.Level.Two))

# we now have 
# Highway Vehicles - Gasoline            Highway Vehicles - Diesel              
# Off-highway Vehicle Gasoline, 2-Stroke
# Off-highway Vehicle Gasoline, 4-Stroke Off-highway Vehicle Diesel 

# add in a couple more
SCCVehicle = rbind(SCCVehicle, SCC[SCC$SCC.Level.Two=="Off-highway 2-stroke Gasoline Engines",])
SCCVehicle = rbind(SCCVehicle, SCC[SCC$SCC.Level.Two=="Off-highway 4-stroke Gasoline Engines",])

nei_sum = NEI %>% 
  filter(fips=="24510" | fips=="06037") %>%   #Baltimore OR Los Angeles
  filter(SCC %in% SCCVehicle$SCC) %>% #Motor vehicles
  group_by(year, fips) %>% summarize(totalEmissions = sum(Emissions))

nei_sum$fips = factor(nei_sum$fips, label=c("Los Angeles Co", "Balitmore"))

ggplot(nei_sum, aes(x=year, y=totalEmissions, colour=fips)) + 
  geom_point() + geom_line() + theme_few() + ggtitle("Motor Vehicle-related Emissions\n(Baltimore and Los Angeles)")
ggsave("q6.png", width=4.8, height=4.8, dpi=100)
