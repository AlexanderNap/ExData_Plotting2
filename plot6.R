library(ggplot2)

#reading data from rds-files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get data of emissions from motor vehicle sources
motorVehicleData<-SCC[which(SCC$Data.Category=="Onroad"), c("SCC", "Data.Category")]
#get data of PM in Baltimore and Los Angeles
citiesPM<-NEI[which(NEI$fips=='24510' | NEI$fips=='06037'),]
#evelute emissions from motor vehicle sources in Baltimore and Los Angeles
motorPMinCities<-merge(motorVehicleData, citiesPM, by="SCC")

motorEms<-data.frame(table(motorPMinCities$year, motorPMinCities$fips))
names(motorEms)<-c("year", "City", "Emissions")
motorEms$City<-factor(motorEms$City, labels = c("Los Angeles", "Baltimore"))

yearLabels<-unique(motorEms$year)
motorEms$year<-as.integer(motorEms$year)

#open PNG-device
png("plot6.png", width=480, height=480)

g<-ggplot(motorEms, aes(x=year, y=Emissions))
g + geom_line(aes(color=City),size=1.5) +
  scale_x_discrete(breaks=unique(motorEms$year), labels=yearLabels) +
  labs(y=expression("Emissions of PM"[2.5]* ", tons")) + 
  labs(x="Year") +
  labs(title=expression("Variation of PM"[2.5]*" from motor vehicle sources"))

dev.off()