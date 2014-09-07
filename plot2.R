library(data.table)
library(dplyr)
library(lubridate)

plot2 <- function(){
    #
    # This block of code is for reading and converting data
    #
    dataFile <- "household_power_consumption.txt"
    epcData <- fread(dataFile, sep = ";", header = TRUE, na.strings = "?",
                     select = 1:3,
                     stringsAsFactors = FALSE)
    epcData <- epcData %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
    epcData$Global_active_power <- as.numeric(epcData$Global_active_power)
    epcData$Date <- parse_date_time(paste(epcData$Date, epcData$Time),
                                    "%d/%m/%Y %H:%M:%S")
    #
    # plot2.png file created in ./figure
    #
    png(filename = "./figure/plot2.png",
        width = 480, height = 480, units = "px")
    
    #
    # Making plot
    #
    plot(epcData$Date$Date, epcData$Date$Global_active_power, type = "l",
         xlab = "",
         ylab = "Global Active Power (kilowatts)")
    dev.off()
}