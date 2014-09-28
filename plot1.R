# data.table is faster then data.frame
require(data.table)
# 'filter' function and chains are from 'dplyr' library
require(dplyr)

#
# This block of code reads and converting data from file.
#
dataFile <- "household_power_consumption.txt"    
#
# The next commands are most elegant and fast ... but don't work!
# For additional information please check the link:
#  http://stackoverflow.com/questions/25724918/
#   wrong-columns-modes-when-reading-data-with-na-strings-and-colclasses-argume
#
#epcData <- fread(dataFile,
#                 sep = ";",
#                 header = TRUE,
#                 na.strings = c("?"),
#                 select = 1:3,
#                 colClasses = c("character", "character", rep("numeric", 7)),
#                 stringsAsFactors = FALSE) %>%
#            filter(Date == "1/2/2007" | Date == "2/2/2007")
#
# Next commad works fine. But it is about 14 times slowly than 'fread' above.
#epcData <- tbl_df(read.table(dataFile,
#                             header=TRUE,
#                             sep=";",
#                             na.strings = "?",
#                             colClasses = c("character","character",
#                                            rep("numeric",7)),
#                             stringsAsFactors = FALSE)) %>%
#    filter(Date == "1/2/2007" | Date == "2/2/2007")
#
# So I decided to use 'fread' and 'as.numeric' functions.
epcData <- fread(dataFile,
                 sep = ";",
                 header = TRUE,
                 na.strings = c("?"),
                 select = 1:3,
                 stringsAsFactors = FALSE) %>%
            filter(Date == "1/2/2007" | Date == "2/2/2007")
epcData$Global_active_power <- as.numeric(epcData$Global_active_power)

#
# Making plot
#
# You can copy your plotting to png-file with
#   dev.copy(png, file = "plot1.png",
#            width = 480, height = 480, units = "px")
# But with my code histogram looks more like the original.
# I don't know why!
# The only downside is that you can look at the hist by opening plot1.png
# but not in R-Studio's Plots-window.
#
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")
par(bg = "transparent")
hist(epcData$Global_active_power,
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()