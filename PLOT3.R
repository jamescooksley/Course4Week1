install.packages("data.table")
library("data.table")

setwd("C://Users//u182335//Documents//DataScience//Course 4 Week 1")

#Import data
data3 <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Reformat data
data3[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Reformat the date so able to use time/date
data3[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 01/02/2007 and 02/02/2007
data3 <- data3[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(data3[, dateTime], data3[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(data3[, dateTime], data3[, Sub_metering_2],col="red")
lines(data3[, dateTime], data3[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()

