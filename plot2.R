#reading data from rds-files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#evaluate PM in the Baltimore City by Years
BaltimorePM<-NEI[which(NEI$fips == 24510),]
BaltimorePMbyYears<-table(BaltimorePM$year)

#open PNG-device
png("plot2.png", width=480, height=480)

#set margin line for axis labels
par(mgp = c(2.5, 1, 0))

plot(BaltimorePMbyYears, type="l", ylab = "Emissions, tons", main = "Total emissions in the Baltimore City, Maryland , 1999-2008", col="red")

dev.off()