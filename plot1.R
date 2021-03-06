#reading data from rds-files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#evalute PM by years
PMbyYears<-table(NEI$year)

#open PNG-device
png("plot1.png", width=480, height=480)

#set margin line for axis labels
par(mgp = c(2.5, 1, 0))

plot(PMbyYears/1000, type="l", ylab = expression("Emissions of PM"[2.5]*" (" ~ 10^{3} ~ "tons)"), main = expression("Variation of PM"[2.5]*" in the US, 1999-2008"), col="red")


dev.off()