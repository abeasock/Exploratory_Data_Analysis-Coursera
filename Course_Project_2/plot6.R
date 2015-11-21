## Set my working directory to where I downloaded the project data
setwd('/Users/Beasock/R/Exploratory Data Analysis/exdata-data-NEI_data')

library(ggplot2)

## Read in the two data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge NEI & SCC together
NEISCC <- merge(NEI, SCC, by="SCC")

## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

## Subset for Baltimore City (where fips==24510) & Los Angeles County (fips == "06037")
## for motor vehicles (where type = "ON-ROAD")

subset <- subset(NEISCC, (fips == "24510" | fips == "06037") & type == "ON-ROAD")

Emissions_ByYr <- aggregate(Emissions ~ year + fips, subset, sum)

Emissions_ByYr[Emissions_ByYr$fips == "24510","fips"] <- "Baltimore City"
Emissions_ByYr[Emissions_ByYr$fips == "06037","fips"] <- "Los Angeles"

## Plot
png("plot6.png", width=640, height=480)
g <- ggplot(Emissions_ByYr, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y = "sum") +
    ylab(expression("Total PM2.5 Emissions")) +
    ggtitle("Total Emissions in Baltimore City vs Los Angeles from 1999 to 2008")
    scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))
dev.off()