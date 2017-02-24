plot1 = function() {
  #read data from txt file, with headers, with ; as separator, data no avalaible with ?, data Type defined by varType
  varType = c(rep('character',2), rep('numeric',7))
  data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = varType)
  
  ## data only for 1/2/2007 and  2/2/2007
  data <- data[data$Date=='1/2/2007' | data$Date=='2/2/2007',]
  
  ## clear incomplete cases
  data <- data[complete.cases(data),]
  
  ## Combine Date and Time column
  dtime <- paste(data$Date, data$Time)
  
  ## name the column of dateTime as "DateTime"
  dtime <- setNames(dtime, "DateTime")
  
  ## Remove Date and Time columns
  data <- data[ ,!(names(data) %in% c("Date","Time"))]
  
  ## Add the DateTime column
  data <- cbind(dtime, data)
  
  #build the histogram and save file
  hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
  
  dev.copy(png,"plot1.png", width=480, height=480)
  dev.off()
}