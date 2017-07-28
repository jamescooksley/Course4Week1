install.packages("data.table")
library("data.table")

setwd("C://Users//u182335//Documents//DataScience//Course 4 Week 1")

#Import data
data1 <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Reformat to produce histogram
data1[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Reformat the date
data1[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter dates for 01/02/2007 and 02/02/2007
data1 <- data1[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(data1[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()





