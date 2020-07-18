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


##Question 6
##Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
##in Los Angeles County, California (fips == "06037").
##Which city has seen greater changes over time in motor vehicle emissions?

subsetNEI_Q6 <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

maryland_california <- aggregate(Emissions ~ year + fips, subsetNEI_Q6, sum)
maryland_california$fips[maryland_california$fips=="24510"] <- "Baltimore, MD"
maryland_california$fips[maryland_california$fips=="06037"] <- "Los Angeles, CA"


png("plot6.png")
g4<-ggplot(maryland_california, aes(x=factor(year), y=Emissions, fill=fips, label = round(Emissions,2))) 
x6<-g4+ geom_bar(stat="identity") + 
  facet_grid(fips~., scales="free") +
  ylab(expression("total PM 2.5 emissions in tons")) + 
  xlab("year") +
  ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons"))

print(x6)

dev.off()

