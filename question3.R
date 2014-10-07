#Exploratory Data Analysis Programming Assignment #2

#Q3 

#Of the four types of sources indicated by the type (point, nonpoint, onroad,
#nonroad) variable, which of these four sources have seen decreases in emissions
#from 1999–2008 for Baltimore City? Which have seen increases in emissions from
#1999–2008?

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

nei_sum = NEI %>% filter(Pollutant=="PM25-PRI") %>% 
  filter(fips=="24510") %>% group_by(year,type) %>% summarize(totalEmissions = sum(Emissions))

ggplot(nei_sum, aes(x=year, y=totalEmissions, colour=type)) + 
  geom_point() + geom_line() + theme_few()
ggsave("q3.png", width=4.8, height=4.8, dpi=100)
