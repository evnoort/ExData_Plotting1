require(lubridate)
require(sqldf)

library(lubridate)
library(sqldf)

df <- read.csv.sql("household_power_consumption.txt"
                   , "select * from file where Date = '1/2/2007' or Date = '2/2/2007' "
                   , sep=";"
                )

df$Date1 <- as.Date(df$Date, "%d/%m/%Y")
df$Time1 <- strptime(df$Time, format="%H:%M:%S")
df$DaysToday <- rep(days(today()),NROW(df)) 
df$DateTime <- df$Time1 + days(df$Date1) - df$DaysToday 

png("plot3.png", width=480, height=480)

maxVal <- max(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)
plot(   df$DateTime
      , df$Sub_metering_1
      , type = "l"
      , col="black"
      , ylab="Energy sub metering"
      , xlab = ""
      , main=""
      , ylim=range(0:maxVal)
      )
par(new=T)
plot(     df$DateTime
        , df$Sub_metering_2
        , type = "l"
        , col="red"
        , ylab="Energy sub metering"
        , xlab = ""
        , ylim=range(0:maxVal)
)
par(new=T)
plot(     df$DateTime
          , df$Sub_metering_3
          , type = "l"
          , col="blue"
          , ylab="Energy sub metering"
          , xlab = ""
          , ylim=range(0:maxVal)
)

legend("topright"
        ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        , col = c("black", "red", "blue")
        , pch = -1
        , lty=1
        , cex = 1
       )

dev.off()
