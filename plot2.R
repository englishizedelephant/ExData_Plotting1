## install packages
install.packages("dplyr")
install.packages('readr')
library(dplyr)
library(readr)

## Read a dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = './data.zip', method = 'curl')
zipfile <- "./data.zip"
file <- unzip(zipfile)

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
         .after = Time)

str(datModDate)

## Plot2
with(datModDate, {
  plot(DateTime, Global_active_power,type = 'l',
       xlab = '', ylab = 'Global Active Power', xaxt = 'n'
  )
  axis.POSIXct(1,at = seq(min(DateTime), 
                          max(DateTime), length.out = 3),
               format = "%a",labels = TRUE
  )
})

dev.copy(png, file = 'plot2.png', width = 480, height = 480)
dev.off()
