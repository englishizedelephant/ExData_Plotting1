## install packages
install.packages("dplyr")
install.packages('readr')
library(dplyr)
library(readr)

## Read a dataset
file <- "household_power_consumption.txt"
dat <- read.table(file, sep = ';',header = TRUE, na.strings = '?')

## Check the dataset
str(dat)

## Combine Date and Time into Date/Time class
datModDate <- dat %>%
  filter(Date == '1/2/2007' | Date == '2/2/2007') %>%
  mutate(DateTime = strptime(paste(Date, Time, sep = " "),
                             format = "%d/%m/%Y %H:%M:%S",
                             tz = "UTC"),
         .keep = 'all',
         .after = Time) %>%
  mutate(Date = as.Date(Date, '%d/%m/%Y'))

str(datModDate)

## Plot3
with(datModDate,{
  plot(DateTime, Sub_metering_1, type = 'l', xaxt = 'n',
       xlab = '', ylab = 'Evergy sub metering')
  
  points(DateTime, Sub_metering_2, col = 'red', type = 'l')
  points(DateTime, Sub_metering_3, col = 'blue', type = 'l')
  
  axis.POSIXct(1, at = seq(min(DateTime), max(DateTime),
                           length.out = 3),
               format = "%a",labels = TRUE)
  legend('topright',
         c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
         lty = 1, col = c('black','red','blue'))
})

dev.copy(png, file = 'plot3.png', width = 480, height = 480)
dev.off()
