
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
data_sub$Global_active_power<-as.numeric(as.character(data_sub$Global_active_power))
data_sub$Global_reactive_power<-as.numeric(as.character(data_sub$Global_reactive_power))
data_sub$Voltage<-as.numeric(as.character(data_sub$Voltage))

data_sub_trans <- melt(data_sub[,c("Date_time","Sub_metering_1","Sub_metering_2","Sub_metering_3")], id.vars = "Date_time")

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

Plot1<-qplot(Date_time,Global_active_power,data=data_sub,geom = "line",
            xlab="",ylab="Global Active Power")
Plot1<-Plot1+scale_x_datetime(breaks=date_breaks("1 day"),labels = date_format("%a"))

Plot2<-qplot(Date_time,Voltage,data=data_sub,geom = "line",
             xlab="datetime",ylab="Voltage")
Plot2<-Plot2+scale_x_datetime(breaks=date_breaks("1 day"),labels = date_format("%a"))

Plot3<-qplot(Date_time,value,data=data_sub_trans,geom = "line",
            colour = variable, xlab="",ylab="Energy sub metering")
Plot3<-Plot3+scale_x_datetime(breaks=date_breaks("1 day"),labels = date_format("%a"))
Plot3<-Plot3+theme(legend.title=element_text(size=4),legend.text=element_text(size=4))

Plot4<-qplot(Date_time,Global_reactive_power,data=data_sub,geom = "line",
             xlab="datetime",ylab="Global reactive power")
Plot4<-Plot4+scale_x_datetime(breaks=date_breaks("1 day"),labels = date_format("%a"))

png("plot4.png", width = 480, height = 480)
multiplot(Plot1
          , Plot3
          , Plot2
          , Plot4
          , cols=2)
dev.off()