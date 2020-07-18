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


##Question 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

maryland_emissions3 <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

maryland_emissions_year <- aggregate(Emissions ~ year, maryland_emissions3, sum)


png("plot5.png")

g3<-ggplot(maryland_emissions_year, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) 
x3<-g3+geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM 2.5 emissions in tons")) +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")
  
print(x3)
dev.off()



