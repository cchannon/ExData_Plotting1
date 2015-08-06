library(dplyr)
powerData<- read.table("household_power_consumption.txt", na.strings = "?", comment.char = "", stringsAsFactors = FALSE, sep = ";", row.names = NULL, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), skip = 1, colClasses = c("character", "character", rep("numeric", 7)))
powerData <- powerData%>%
    filter(Date == "1/2/2007"|Date == "2/2/2007")%>%
    mutate(datetime = paste(Date, Time, sep = " "))%>%
    select(c(datetime, Global_active_power:Sub_metering_3))%>%
    mutate(datetime = as.POSIXct(strptime(datetime, format = "%d/%m/%Y %H:%M:%S", tz = "")))
par(mfrow = c(2, 2))
with(powerData, plot(datetime, Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)"))
with(powerData, lines(datetime, Global_active_power))
with(powerData, plot(datetime, Voltage, type = "n"))
with(powerData, lines(datetime, Voltage))
with(powerData, plot(datetime, Sub_metering_1, type = "n", ylab = "Energy sub metering"))
with(powerData, lines(datetime, Sub_metering_1, col = "black"))
with(powerData, lines(datetime, Sub_metering_2, col = "red"))
with(powerData, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", pch = "", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(powerData, plot(datetime, Global_reactive_power, type = "n"))
with(powerData, lines(datetime, Global_reactive_power))
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()