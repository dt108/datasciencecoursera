#read file
input_file <- "household_power_consumption.txt"

#skipping na="?" changes the x-axis scale
input_data <- read.table(input_file, header=TRUE, sep=";", na="?")

#filter based on dates
filter_vector_c <- c("1/2/2007","2/2/2007")
filtered_data <- input_data[input_data$Date %in% filter_vector_c, ]

#extract field
global_active_power <- as.numeric(filtered_data$Global_active_power)

#datetime of date and time fields from filtered dataset
datetime <- strptime(paste(filtered_data$Date, filtered_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#force type="l" for lines
plot(datetime, global_active_power, ylab="Global Active Power (kilowatts)", type="l", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()