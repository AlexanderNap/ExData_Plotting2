library(ggplot2)

#reading data from rds-files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#evaluate PM in the Baltimore City 
BaltimorePM<-NEI[which(NEI$fips == 24510),]
bty<-data.frame(table(BaltimorePM$type,BaltimorePM$year))
names(bty)<-c("type", "year", "Emissions")


#open PNG-device
png("plot3.png", width = 800, height = 600)

g<-ggplot(bty, aes(year, Emissions))

g + geom_point() + facet_grid(.~type) + 
  geom_smooth(method="lm", aes(group=1)) + 
  labs(y=expression("Emissions of PM"[2.5]* ", tons")) + 
  labs(x="Year") + 
  labs(title=expression("Variation of PM"[2.5]*" in Baltimore by year for each source"))

dev.off()