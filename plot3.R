## Load Libraries
library(data.table)
library(dplyr)

## Download Data 
if(!file.exists("household_power_consumption.txt")) {
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        temp <- tempfile()
        download.file(fileurl, temp, method = "curl")
        unzip(temp)
        unlink(temp)
}

## Load Data and filter for 1/2/2007 and 2/2/2007
hcp <- fread("household_power_consumption.txt", nrows = 69516, na.string = "?")
hcp <- filter(hcp, Date == "1/2/2007" | Date == "2/2/2007")

## Format Date & Time
DateTime <- strptime(paste(hcp$Date, hcp$Time), format = "%e/%m/%Y %X")

## Create Plot 3
png(filename = "plot3.png")
plot(DateTime, hcp$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(DateTime, hcp$Sub_metering_1)
lines(DateTime, hcp$Sub_metering_2, col = "red")
lines(DateTime, hcp$Sub_metering_3, col = "blue")
legend ("topright", lty = c(1,1,1), col = c("black","red","blue"), 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()