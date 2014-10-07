# Exploratory Data Analysis Programming Assignment #2

require(dplyr)

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

nei_sum = NEI %>% filter(Pollutant=="PM25-PRI") %>% 
  filter(fips=="24510") %>% group_by(year) %>% 
  summarize(totalEmissions = sum(Emissions))

fit = lm(nei_sum$totalEmissions ~ nei_sum$year)

png(file="q2.png")
plot(nei_sum$year, nei_sum$totalEmissions, type="l")
points(nei_sum$year, nei_sum$totalEmissions)
abline(fit, col="blue")
dev.off()
