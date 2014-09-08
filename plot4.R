plot4 <- function(){
    library(data.table)
    library(dplyr)
    library(lubridate)
    
    #
    # This block of code is for reading and converting data
    #
    dataFile <- "household_power_consumption.txt"
    epcData <- fread(dataFile, sep = ";", header = TRUE, na.strings = "?",
                     select = c(1:5, 7:9),
                     stringsAsFactors = FALSE)
    epcData <- epcData %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
    epcData$Date <- parse_date_time(paste(epcData$Date, epcData$Time),
                                    "%d/%m/%Y %H:%M:%S")
    epcData$Global_active_power<- as.numeric(epcData$Global_active_power)
    epcData$Global_reactive_power <- as.numeric(epcData$Global_reactive_power)
    epcData$Voltage <- as.numeric(epcData$Voltage)
    epcData$Sub_metering_2 <- as.numeric(epcData$Sub_metering_2)
    epcData$Sub_metering_3 <- as.numeric(epcData$Sub_metering_3)
    #
    # plot4.png file created in ./figure
    #
    png(filename = "./figure/plot4.png",
        width = 480, height = 480, units = "px")
    
    #
    # Making plot
    #
    par(mfcol = c(2,2), bg = "transparent", mar = c(5, 4, 3, 1))
    #
    # Making 1st plot
    #
    plot(epcData$Date, epcData$Global_active_power, type = "l",
         xlab = "",
         ylab = "Global Active Power")
    #
    # Making 2nd plot
    #
    plot(epcData$Date, epcData$Sub_metering_1, type = "l",
         col = "black",
         xlab = "",
         ylab = "Energy sub metering")
    points(epcData$Date, epcData$Sub_metering_2, type = "l",
           col = "red")
    points(epcData$Date, epcData$Sub_metering_3, type = "l",
           col = "blue")
    legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    #
    # Making 3d plot
    #
    plot(epcData$Date, epcData$Voltage, type = "l",
         xlab = "datetime",
         ylab = "Voltage")
    
    #
    # Making 4th plot
    #
    plot(epcData$Date, epcData$Global_reactive_power, type = "l",
         xlab = "datetime",
         ylab = "Global_reactive_power")
    
    dev.off()
}