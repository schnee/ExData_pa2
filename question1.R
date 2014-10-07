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

nei_sum = NEI %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))

png(file="q1.png")
plot(nei_sum$year, nei_sum$totalEmissions, type="l")
points(nei_sum$year, nei_sum$totalEmissions)
dev.off()