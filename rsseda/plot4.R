#read file
input_file <- "household_power_consumption.txt"

#skipping na="?" changes the x-axis scale
input_data <- read.table(input_file, header=TRUE, sep=";", na="?")

#filter based on dates
filter_vector_c <- c("1/2/2007","2/2/2007")
filtered_data <- input_data[input_data$Date %in% filter_vector_c, ]

#extract fields
global_active_power <- as.numeric(filtered_data$Global_active_power)
global_reactive_power <- as.numeric(filtered_data$Global_reactive_power)
voltage <- as.numeric(filtered_data$Voltage)

datetime <- strptime(paste(filtered_data$Date, filtered_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#extract sub metering data
metering_1 <- as.numeric(filtered_data$Sub_metering_1)
metering_2 <- as.numeric(filtered_data$Sub_metering_2)
metering_3 <- as.numeric(filtered_data$Sub_metering_3)

#4 plots in all
par(mfrow = c(2, 2))

#1st plot -> top left
plot(datetime, global_active_power, type="l", cex=0.2, ylab="Global Active Power")

#2nd plot -> top right
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

#3rd plot -> bottom left
#force type="l" for lines. draw plot and add lines
plot(datetime, metering_1, ylab="Energy Sub metering", type="l", xlab="")
lines(datetime, metering_2,type="l", col="red")
lines(datetime, metering_3,type="l", col="blue")

#legend description and colors vector
legend_desc <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend_col <- c("black", "red", "blue")
legend_border <- "n" # no border for legend as it might overlap on the plot
legend("topright", legend_desc, lty=, lwd=1, bty=legend_border,col=legend_col)

#4th plot -> bottom right
plot(datetime, global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()