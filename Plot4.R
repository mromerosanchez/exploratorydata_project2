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


##Question 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#head(SCC)

comb_coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
comb_coal_source <- SCC[comb_coal,]


emissions_coal <- NEI[(NEI$SCC %in% comb_coal_source$SCC), ]

emissions_coal_rel <- summarise(group_by(emissions_coal, year), Emissions=sum(Emissions))

png("plot4.png")
g2<-ggplot(emissions_coal_rel, aes(x=factor(year), y=Emissions/1000, fill=year, label = round(Emissions/1000,2))) 

x<-g2+geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM 2.5  emissions in kilotons")) +
  ggtitle("Emissions from coal combustion-related sources in kilotons")
 
print(x)
dev.off()

