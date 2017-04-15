require(sqldf)

library(sqldf)

df <- read.csv.sql("household_power_consumption.txt"
                   , "select * from file where Date = '1/2/2007' or Date = '2/2/2007' "
                   , sep=";"
                )

png("plot1.png", width=480, height=480)

hist( df$Global_active_power
      , col = "red"
      , xlab="Global Active Power (kilowatts)"
      , main="Global Active Power"
      )

dev.off()
