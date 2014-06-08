
require(ggplot2)

setwd("/Users/dnilwang/Desktop/ExData_Plotting1")
data<-read.table("household_power_consumption.txt",sep=";",header = TRUE)
head(data)

data$Date <- as.character(data$Date)
data$Time <- as.character(data$Time)
data$Date_time<-strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S") 

data$Date <- as.Date(data$Date,"%d/%m/%Y")

data_sub<- data[which(data$Date=="2007-02-01" | data$Date=="2007-02-02"),]

data_sub$Global_active_power<-as.numeric(as.character(data_sub$Global_active_power))

png("plot1.png", width = 480, height = 480)
qplot(Global_active_power, binwidth=0.5,data=data_sub,
      ylab="Frequency",xlab="Global Active Power (kilowatts)",
      main="Global Active Power",fill=I("red"))
dev.off()