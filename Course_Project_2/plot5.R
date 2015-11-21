## Set my working directory to where I downloaded the project data
setwd('/Users/Beasock/R/Exploratory Data Analysis/exdata-data-NEI_data')

## Read in the two data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge NEI & SCC together
NEISCC <- merge(NEI, SCC, by="SCC")

## How have emissions from motor vehicle sources 
## changed from 1999–2008 in Baltimore City?

## Subset for Baltimore City (where fips==24510) & for motor vehicles (where type = "ON-ROAD")
subset <- subset(NEISCC, fips == "24510" & type == "ON-ROAD")

Emissions_ByYr <- aggregate(Emissions ~ year, subset, sum)

## Plot
png("plot5.png", width=840, height=480)
barplot(height=Emissions_ByYr$Emissions, names.arg= Emissions_ByYr$year, main="Total Emissions from Motor Vehicle Sources in Baltimore from 1999 to 2008", xlab="Year", ylab="Total PM2.5 Emissions", ylim = c(0, 350))
dev.off()