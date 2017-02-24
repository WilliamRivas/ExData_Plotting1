plot2 = function() {
  varType = c(rep('character',2), rep('numeric',7))
  data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = varType)
  #only two days 
  data <- data[data$Date=='1/2/2007' | data$Date=='2/2/2007',]
  
  dtime <-strptime(paste(data$Date, data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
  dtime <- setNames(dtime, "DateTime")
  data <- cbind(dtime, data)
  plot(data$dtime, data$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
  dev.copy(png,"plot2.png", width=480, height=480)
  dev.off()  
}
