
require(ggplot2)

setwd("/Users/dnilwang/Desktop/ExData_Plotting1")
data<-read.table("household_power_consumption.txt",sep=";",header = TRUE)
head(data)

data_copy <- data
data_copy$Date <- as.character(data_copy$Date)
data_copy$Time <- as.character(data_copy$Time)
data_copy$Date_time<-strptime(paste(data_copy$Date, data_copy$Time), format = "%d/%m/%Y %H:%M:%S") 

data_copy$Date <- as.Date(data_copy$Date,"%d/%m/%Y")

data_sub<- data_copy[which(data_copy$Date=="2007-02-01" | data_copy$Date=="2007-02-02"),]

data_sub$Global_active_power<-as.numeric(as.character(data_sub$Global_active_power))
data_sub$Day_of_week<-weekdays(data_sub$Date)

png("plot2.png", width = 480, height = 480)
test<-qplot(Date_time,Global_active_power,data=data_sub,geom = "line",
            xlab="",ylab="Global Active Power (kilowatts)")
test + scale_x_datetime(breaks=date_breaks("1 day"),labels = date_format("%a"))
dev.off()