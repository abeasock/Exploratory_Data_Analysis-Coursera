## Set my working directory to where I downloaded the project data
setwd('/Users/Beasock/R/Exploratory Data Analysis/exdata-data-NEI_data')

## Read in the two data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge NEI & SCC together
NEISCC <- merge(NEI, SCC, by="SCC")

## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999–2008?

## Subset on NEIxSCC records with Short.Name (SCC) Coal
subset_coal <- grep("coal", NEISCC$Short.Name, ignore.case = T)
subsetNEISCC <- NEISCC[subset_coal, ]

Emissions_ByYr <- aggregate(Emissions ~ year, subsetNEISCC, sum)

## Plot
png("plot4.png", width=840, height=480)
barplot(height=Emissions_ByYr$Emissions, names.arg= Emissions_ByYr$year, main="Total Emissions by Coal Combustion-related Sources from 1999 to 2008", xlab="Year", ylab="Total PM2.5 Emissions", ylim = c(0, 700000))
dev.off()