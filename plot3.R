plot3 <- function(){
    library(data.table)
    library(dplyr)
    library(lubridate)

    #
    # This block of code is for reading and converting data
    #
    dataFile <- "household_power_consumption.txt"
    epcData <- fread(dataFile, sep = ";", header = TRUE, na.strings = "?",
                     select = c(1:2, 7:9),
                     stringsAsFactors = FALSE)
    epcData <- epcData %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
    epcData$Sub_metering_1 <- as.numeric(epcData$Sub_metering_1)
    epcData$Sub_metering_2 <- as.numeric(epcData$Sub_metering_2)
    epcData$Sub_metering_3 <- as.numeric(epcData$Sub_metering_3)
    epcData$Date <- parse_date_time(paste(epcData$Date, epcData$Time),
                                    "%d/%m/%Y %H:%M:%S")
    #
    # plot3.png file created in ./figure
    #
    png(filename = "./figure/plot3.png",
        width = 480, height = 480, units = "px")
    
    #
    # Making plot
    #
    par(bg = "transparent")
    plot(epcData$Date, epcData$Sub_metering_1, type = "l",
         col = "black",
         xlab = "",
         ylab = "Energy sub metering")
    points(epcData$Date, epcData$Sub_metering_2, type = "l",
         col = "red")
    points(epcData$Date, epcData$Sub_metering_3, type = "l",
           col = "blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    dev.off()
}