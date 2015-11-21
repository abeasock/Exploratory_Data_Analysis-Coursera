## Set my working directory to where I downloaded the project data
setwd('/Users/Beasock/R/Exploratory Data Analysis/exdata-data-NEI_data')

## Read in the two data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008

## Subset for the years 1999, 2002, 2005, & 2008
subset_year <- NEI[grep('(1999|2002|2005|2008)', NEI$year),]

## Take the sum for each year
Total_Emissions_ByYr <- aggregate(Emissions ~ year, subset_year, sum)

## Plot
png("plot1.png")
barplot(height=Total_Emissions_ByYr$Emissions, names.arg= Total_Emissions_ByYr$year, main="Total PM2.5 Emissions by Year", xlab="Year", ylab="Total PM2.5 Emissions", ylim=c(0,8000000))
dev.off()