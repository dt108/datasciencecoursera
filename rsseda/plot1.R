#read file
input_file <- "household_power_consumption.txt"

#skipping na="?" changes the x-axis scale
input_data <- read.table(input_file, header=TRUE, sep=";", na="?")

#filter based on dates
filter_vector_c <- c("1/2/2007","2/2/2007")
filtered_data <- input_data[input_data$Date %in% filter_vector_c, ]

#extract field for histogram
global_active_power <- as.numeric(filtered_data$Global_active_power)
class(global_active_power) # should be numeric for histograms

hist(global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
