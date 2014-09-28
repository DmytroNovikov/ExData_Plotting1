# data.table is faster then data.frame
require(data.table)
# 'filter' function and chains are from 'dplyr' library
require(dplyr)
# I decided to test 'parse_date_time' function from 'lubridate' library.
# That library was presented by swirl Programming Assignment for this cource.
require(lubridate)

#
# This block of code is for reading and converting data
#
dataFile <- "household_power_consumption.txt"
epcData <- fread(dataFile,
                 sep = ";",
                 header = TRUE,
                 na.strings = c("?"),
                 select = c(1:2, 7:9),
                 stringsAsFactors = FALSE) %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007")
epcData <- mutate(epcData, Date_with_time = 
                      parse_date_time(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))    
epcData$Sub_metering_1 <- as.numeric(epcData$Sub_metering_1)
epcData$Sub_metering_2 <- as.numeric(epcData$Sub_metering_2)
epcData$Sub_metering_3 <- as.numeric(epcData$Sub_metering_3)

#
# Making plot
#
# You can copy your plotting to png-file with
#   dev.copy(png, file = "plot3.png",
#            width = 480, height = 480, units = "px")
# But with my code histogram looks more like the original.
# I don't know why!
# The only downside is that you can look at the hist by opening plot1.png
# but not in R-Studio's Plots-window.
#
# Warning. The days of week on plotting are printed in local language.
# In my case locale is RU (Russian). So 'Чт'='Thu', 'Пт'='Fri', 'Сб'='Sat'
#
png(filename = "plot3.png",
    width = 480, height = 480, units = "px")
par(bg = "transparent")
plot(epcData$Date_with_time, epcData$Sub_metering_1, type = "l",
                    col = "black",
                    xlab = "",
                    ylab = "Energy sub metering")
lines(epcData$Date_with_time, epcData$Sub_metering_2, col = "red")
lines(epcData$Date_with_time, epcData$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2",
                  "Sub_metering_3"))
dev.off()