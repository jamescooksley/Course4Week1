install.packages("data.table")
library("data.table")

setwd("C://Users//u182335//Documents//DataScience//Course 4 Week 1")

#Import data
data4 <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Reformat
data4[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Reformat date to use time/date
data4[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 01/02/2007 and 02/02/2007
data4 <- data4[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(data4[, dateTime], data4[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(data4[, dateTime],data4[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(data4[, dateTime], data4[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(data4[, dateTime], data4[, Sub_metering_2], col="red")
lines(data4[, dateTime], data4[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(data4[, dateTime], data4[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

