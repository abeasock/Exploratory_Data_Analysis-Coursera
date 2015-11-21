## Set my working directory to where I downloaded the project data
setwd('/Users/Beasock/R/Exploratory Data Analysis/exdata-data-NEI_data')

## Read in the two data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## Subset for Baltimore City (where fips==24510)
baltimore <- subset(NEI, fips == "24510")

## Take the sum for each year
Total_Emissions_ByYr <- aggregate(Emissions ~ year, NEI_baltimore, sum)

## Plot
png("plot2.png")
barplot(height=Total_Emissions_ByYr$Emissions, names.arg= Total_Emissions_ByYr$year, main="Total PM2.5 Emissions in Baltimore City from 1999 to 2008", xlab="Year", ylab="Total PM2.5 Emissions", ylim=c(0, 3500))
dev.off()
