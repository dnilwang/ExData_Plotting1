
require(ggplot2)
require(reshape)

setwd("/Users/dnilwang/Desktop/ExData_Plotting1")
data<-read.table("household_power_consumption.txt",sep=";",header = TRUE)
head(data)

data_copy <- data
data_copy$Date <- as.character(data_copy$Date)
data_copy$Time <- as.character(data_copy$Time)
data_copy$Date_time<-strptime(paste(data_copy$Date, data_copy$Time), format = "%d/%m/%Y %H:%M:%S") 

data_copy$Date <- as.Date(data_copy$Date,"%d/%m/%Y")

data_sub<- data_copy[which(data_copy$Date=="2007-02-01" | data_copy$Date=="2007-02-02"),]

data_sub$Sub_metering_1<-as.numeric(as.character(data_sub$Sub_metering_1))
data_sub$Sub_metering_2<-as.numeric(as.character(data_sub$Sub_metering_2))
data_sub$Sub_metering_3<-as.numeric(as.character(data_sub$Sub_metering_3))

data_sub_trans <- melt(data_sub[,c("Date_time","Sub_metering_1","Sub_metering_2","Sub_metering_3")], id.vars = "Date_time")

png("plot3.png", width = 480, height = 480)
test<-qplot(Date_time,value,data=data_sub_trans,geom = "line",
            colour = variable, xlab="",ylab="Energy sub metering")
test + scale_x_datetime(breaks=date_breaks("1 day"),labels = date_format("%a"))
test + theme(legend.position=c(1,1),legend.justification=c(1,1))
dev.off()