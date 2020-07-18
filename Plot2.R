##loading libraries

library(dplyr)
#Download and unzip the data

filename <- "exdata_data_NEI_data.zip"

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(URL, filename, method="curl")

unzip(filename)

NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")


##Question 2
##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question.


subsetNEI  <- NEI[NEI$fips=="24510", ]

maryland_emissions <- aggregate(Emissions ~ year, subsetNEI, sum)

png('plot2.png')

barplot(height=maryland_emissions$Emissions/1000, names.arg=maryland_emissions$year,
            xlab="years", ylab=expression("total PM 2.5 emission in kilotons"),ylim=c(0,4),
            main=expression("Total PM 2.5 emissions in Baltimore City-MD in kilotons"))

dev.off()
