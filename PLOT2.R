install.packages("data.table")
library("data.table")

setwd("C://Users//u182335//Documents//DataScience//Course 4 Week 1")

#Import data
data2 <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Reformat
data2[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Create date in order to filter by time/date
data2[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 01/02/2007 and 02/02/2007
data2 <- data2[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = data2[, dateTime]
     , y = data2[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()