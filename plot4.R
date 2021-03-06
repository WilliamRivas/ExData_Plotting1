plot4 = function() {
  data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
  
  ## Format date to Type Date d/m/Y
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  
  ## two days
  data <- subset(data,Date == as.Date("2007-2-1") | Date == as.Date("2007-2-2"))
  
  ## Remove incomplete cases
  data <- data[complete.cases(data),]
  
  ## Combine Date and Time column
  dtime <- paste(data$Date, data$Time)
  dtime <- setNames(dtime, "DateTime")
  ## Remove Date and Time column
  data <- data[ ,!(names(data) %in% c("Date","Time"))]
  ## Add column
  data <- cbind(dtime, data)
  ## Format dateTime Column
  data$dtime <- as.POSIXct(dtime)
  
  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  
  with(data, {
    plot(Global_active_power~dtime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~dtime, type="l", ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~dtime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dtime,col='Red')
    lines(Sub_metering_3~dtime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~dtime, type="l",ylab="Global Rective Power (kilowatts)",xlab="")
  })
  dev.copy(png, file="plot4.png", height=480, width=480)
  dev.off()
}
