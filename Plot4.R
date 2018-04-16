######
#Kathy A. April 2018
######

#library(anytime)
## Download and unzip correct dataset
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", destfile="household_power_consumption.zip")
unzip("household_power_consumption.zip")
debug(utils:::unpackPkgZip)

## read the data into R
household_power <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";")

household_power <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

household_power$Date <- as.Date(household_power$Date, format="%d/%m/%Y")



## reformat the columns
household_power$Date <- format(household_power$Date, format = "%d/%m/%Y")
household_power$Time <-format(household_power$Time, format = "%H:%M:%S")
household_power$Global_active_power <- as.numeric(household_power$Global_active_power)
household_power$Global_reactive_power <- as.numeric(household_power$Global_reactive_power)
household_power$Voltage <- as.numeric(household_power$Voltage)
household_power$Global_intensity <- as.numeric(household_power$Global_intensity)
household_power$Sub_metering_1 <- as.numeric(household_power$Sub_metering_1)
household_power$Sub_metering_2 <- as.numeric(household_power$Sub_metering_2)
household_power$Sub_metering_3 <- as.numeric(household_power$Sub_metering_3)



## extract a subset of data from the range of interest: 2007-02-01 and 2007-02-02

subsetdata <- subset(household_power,  subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#rm(household_power)


## Converting dates
paste_subsetdata<- paste(as.Date(subsetdata$Date), subsetdata$Time)
subsetdata$Datetime <- as.POSIXct(paste_subsetdata)


#Plot 4
par(mfrow=c(2,2))
with(subsetdata, plot(Datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subsetdata, plot(Datetime, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subsetdata, plot(Datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subsetdata$Datetime, subsetdata$Sub_metering_2,type="l", col= "red")
lines(subsetdata$Datetime, subsetdata$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(subsetdata, plot(Datetime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))



## Saving to file
dev.copy(png, file="~/R/ML_April2018/Coursera/Plot4.png", height=480, width=480)
dev.off()
