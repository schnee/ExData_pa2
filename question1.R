# Exploratory Data Analysis Programming Assignment #2

# read the files
files = dir("data")
if(sum(grepl("summarySCC_PM25.rds", files))>0){
  NEI <- readRDS("data/summarySCC_PM25.rds")
}
if(sum(grepl("Source_Classification_Code.rds", files))>0){
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

