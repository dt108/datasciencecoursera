#read file
input_file <- "household_power_consumption.txt"

#skipping na="?" changes the x-axis scale
input_data <- read.table(input_file, header=TRUE, sep=";", na="?")

#filter based on dates
filter_vector_c <- c("1/2/2007","2/2/2007")
filtered_data <- input_data[input_data$Date %in% filter_vector_c, ]

#extract field
global_active_power <- as.numeric(filtered_data$Global_active_power)

datetime <- strptime(paste(filtered_data$Date, filtered_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#extract sub metering data
metering_1 <- as.numeric(filtered_data$Sub_metering_1)
metering_2 <- as.numeric(filtered_data$Sub_metering_2)
metering_3 <- as.numeric(filtered_data$Sub_metering_3)

#force type="l" for lines. draw plot and add lines
plot(datetime, metering_1, ylab="Energy Sub metering", type="l", xlab="")
lines(datetime, metering_2,type="l", col="red")
lines(datetime, metering_3,type="l", col="blue")

#legend description and colors vector
legend_desc <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend_col <- c("black", "red", "blue")
legend("topright", legend_desc, lty=1, lwd=2.5, col=legend_col)

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()