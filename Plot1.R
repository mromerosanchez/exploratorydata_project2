##loading libraries

library(dplyr)
#Download and unzip the data

filename <- "exdata_data_NEI_data.zip"

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(URL, filename, method="curl")

unzip(filename)

NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

## Question 1 

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#head(NEI)
#head(SCC)

Total_emissions <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png")
barplot(height=Total_emissions$Emissions/1000, names.arg=Total_emissions$year,
        xlab="years", ylab=expression("total PM 2.5 emission in kilotons"),ylim=c(0,8000),
        main=expression("Total PM 2.5 emissions at various years in kilotons"))

dev.off()


