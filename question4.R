# Exploratory Data Analysis Programming Assignment #2
# Question #4

# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

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

#SCC Level Three is the fuel type, so look for those SCC numbers with "Coal" in the fuel
#I suppose there's an assumption here that we can only burn coal (to generate emissions)
SCCcoal = SCC %>% filter(grepl(".*Coal.*", SCC.Level.Three))

nei_sum = NEI %>% filter(SCC %in% SCCcoal$SCC) %>% 
  group_by(year) %>% summarize(totalEmissions = sum(Emissions))

ggplot(nei_sum, aes(x=year, y=totalEmissions)) + 
  geom_point() + geom_line() + theme_few() + ggtitle("Coal-related Emissions (US)")
ggsave("q4.png", width=4.8, height=4.8, dpi=100)
