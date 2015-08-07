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
png("plot3.png", height=480, width=480)
#Plot three sets of lines with different colors. Add labels in the first one.
with(powerDataGraph, plot(dateTime, Sub_metering_1, type = "l", ylab="Energy sub metering", xlab=""))
with(powerDataGraph, lines(dateTime, Sub_metering_2, type = "l", col="red"))
with(powerDataGraph, lines(dateTime, Sub_metering_3, type = "l", col="blue"))
#Add the legend
legend("topright", colnames(powerDataGraph[7:9]), lty = c(1,1,1),  col=c("black", "red", "blue"))


dev.off()
