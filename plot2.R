#read in data from table
powerData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
#Create collapsed DateTime column
dateTime <- apply(powerData[,colnames(powerData) %in% c("Date", "Time")], 1, paste0, collapse=" ")
#Set DateTime as POSIXlt
powerData$dateTime <- strptime(dateTime, format = "%d/%m/%Y %H:%M:%S")
#Set numeric columns as.numeric
powerData[,3:6] <- lapply(powerData[,3:6], as.numeric)
#Set top and bottom ranges for these data
bottomRange <- strptime('2007-02-01 00:00:00', format = "%Y-%m-%d %H:%M:%S")
topRange <- strptime('2007-02-02 23:59:59', format = "%Y-%m-%d %H:%M:%S")
#Subset the data for the correct dates and create a new df
powerDataGraph <- powerData[(powerData$dateTime >= bottomRange & powerData$dateTime <= topRange),]
#Open a connection to the file
png("plot2.png", height=480, width=480)
#Make a line chart. Use type = 'l' to call this.
with(powerDataGraph, plot(dateTime, Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab=""))

dev.off()
