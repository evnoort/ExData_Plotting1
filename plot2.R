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

png("plot2.png", width=480, height=480)

plot(   df$DateTime
      , df$Global_active_power
      , type = "l"
      , ylab="Global Active Power (kilowatts)"
      , xlab = ""
      , main=""
      )

dev.off()
