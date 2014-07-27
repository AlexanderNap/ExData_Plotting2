library(ggplot2)

#reading data from rds-files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get data of emissions from motor vehicle sources
motorVehicleData<-SCC[which(SCC$Data.Category=="Onroad"), c("SCC", "Data.Category")]
#evaluate PM in the Baltimore City from motor vehicle sources by years
BaltimorePM<-NEI[which(NEI$fips == 24510),]
BaltimoreMotorSource<-merge(motorVehicleData, BaltimorePM, by="SCC")
motorEms<-data.frame(table(BaltimoreMotorSource$year))
names(motorEms)<-c("year", "Emissions")

yearLabels<-unique(motorEms$year)
motorEms$year<-as.integer(motorEms$year)

#open PNG-device
png("plot5.png", width=480, height=480)

g<-ggplot(motorEms, aes(year, Emissions))
g + geom_line(color="red") + 
  scale_x_discrete(breaks=unique(motorEms$year), labels=yearLabels) +
  labs(y=expression("Emissions of PM"[2.5]* ", tons")) +
  labs(x="Year") +
  labs(title=expression("Variation of PM"[2.5]*" in Baltimore City from motor vehicle sources"))

dev.off()