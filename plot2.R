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
                 select = 1:3,
                 stringsAsFactors = FALSE) %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007")
epcData$Global_active_power <- as.numeric(epcData$Global_active_power)
epcData$Date <- parse_date_time(paste(epcData$Date, epcData$Time),
                                "%d/%m/%Y %H:%M:%S")
#
# Making plot
#
# You can copy your plotting to png-file with
#   dev.copy(png, file = "plot2.png",
#            width = 480, height = 480, units = "px")
# But with my code histogram looks more like the original.
# I don't know why!
# The only downside is that you can look at the hist by opening plot1.png
# but not in R-Studio's Plots-window.
#
# Warning. The days of week on plotting are printed in local language.
# In my case locale is RU (Russian). So 'Чт'='Thu', 'Пт'='Fri', 'Сб'='Sat'
#
png(filename = "plot2.png",
    width = 480, height = 480, units = "px")
par(bg = "transparent")
plot(epcData$Date, epcData$Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()