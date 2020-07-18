##loading libraries

library(dplyr)
library(ggplot2)
#Download and unzip the data

filename <- "exdata_data_NEI_data.zip"

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(URL, filename, method="curl")

unzip(filename)

NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")


##Question 3
##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
##which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
## Which have seen increases in emissions from 1999–2008? 
##Use the ggplot2 plotting system to make a plot answer this question.

subsetNEI  <- NEI[NEI$fips=="24510", ]
#head(subsetNEI)

maryland_emissions2 <- aggregate(Emissions ~ year + type, subsetNEI, sum)

#head(maryland_emissions)

png("plot3.png")

g <- ggplot(maryland_emissions2, aes(year, Emissions, color = type))
x <- g + geom_line() +
  xlab("year") +
  ylab(expression("Total PM 2.5 Emissions")) +
  ggtitle("Total Emissions in Baltimore City, Maryland  from 1999 to 2008")
print(x)
dev.off()