# Exploratory Data Analysis Programming Assignment #2
# Question #1 
# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

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

nei_sum = NEI %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))
fit = lm(nei_sum$totalEmissions ~ nei_sum$year)

png(file="q1.png")
plot(nei_sum$year, nei_sum$totalEmissions, type="l")
points(nei_sum$year, nei_sum$totalEmissions)
abline(fit, col="blue")
dev.off()