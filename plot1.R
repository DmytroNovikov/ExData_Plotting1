library(data.table)
library(dplyr)

plot1 <- function(){
    #
    # This block of code is for reading and converting data
    #
    dataFile <- "household_power_consumption.txt"
    epcData <- fread(dataFile, sep = ";", header = TRUE, na.strings = "?",
                     select = 1:3,
                     stringsAsFactors = FALSE)
    epcData <- epcData %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
    epcData$Global_active_power <- as.numeric(epcData$Global_active_power)
    
    #
    # plot1.png file created in ./figure
    #
    png(filename = "./figure/plot1.png",
        width = 480, height = 480, units = "px")
    
    #
    # Making plot
    #
    hist(epcData$Global_active_power,
         col = "red", 
         main = "Global Active Power",
         xlab = "Global Active Power (kilowatts)")
    dev.off()
}