## Set my working directory to where I downloaded the project data
setwd('/Users/Beasock/R/Exploratory Data Analysis/exdata-data-NEI_data')

## Read in the two data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question

library(ggplot2)

## Subset for Baltimore City (where fips==24510)
NEI_baltimore <- subset(NEI, fips == "24510")

## Take the sum for each year & type
Total_Emissions <- aggregate(Emissions ~ year + type, NEI_baltimore, sum)

## Plot
png("plot3.png", width=640, height=480)
g <- ggplot(Total_Emissions, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun.y = "sum") +
    ylab(expression("Total PM2.5 Emissions")) +
    ggtitle("Total Emissions in Baltimore City from 1999 to 2008")
dev.off()