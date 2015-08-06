library(dplyr)
powerData<- read.table("household_power_consumption.txt", na.strings = "?", comment.char = "", stringsAsFactors = FALSE, sep = ";", row.names = NULL, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), skip = 1, colClasses = c("character", "character", rep("numeric", 7)))
powerData <- powerData%>%
    filter(Date == "1/2/2007"|Date == "2/2/2007")%>%
    mutate(datetime = paste(Date, Time, sep = " "))%>%
    select(c(datetime, Global_active_power:Sub_metering_3))%>%
    mutate(datetime = as.POSIXct(strptime(datetime, format = "%d/%m/%Y %H:%M:%S", tz = "")))
with(powerData, hist(Global_active_power, col = "red", xlab = "Global Active Power(kilowatts)", main = "Global Active Power"))
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()