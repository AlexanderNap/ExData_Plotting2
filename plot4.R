library(ggplot2)

#reading data from rds-files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get names of coal combustion-related sources
coalCombustionSource<-grep("*Coal",levels(SCC$EI.Sector), ignore.case = T, value = T)
#get data of emissions for coal combustion-related sources
coalData<-SCC[which(SCC$EI.Sector %in% coalCombustionSource), c("SCC", "EI.Sector")]
totalData<-merge(NEI, coalData, by="SCC")

#evaluate emissions from coal combustion-related sources by years
coalEms<-data.frame(table(totalData$year))
names(coalEms)<-c("year", "Emissions")
yearLabels<-unique(coalEms$year)
coalEms$year<-as.integer(coalEms$year)

#open PNG-device
png("plot4.png", width=480, height=480)

g<-ggplot(coalEms, aes(year, Emissions))
g + geom_line(color="red") + 
  scale_x_discrete(breaks=unique(coalEms$year), labels=yearLabels) +
  labs(y=expression("Emissions of PM"[2.5]* ", tons")) +
  labs(x="Year") +
  labs(title=expression("Variation of PM"[2.5]*" in the US from coal combustion-related sources"))

dev.off()