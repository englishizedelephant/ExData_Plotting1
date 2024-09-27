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
         .after = Time) %>%
  mutate(Date = as.Date(Date, '%d/%m/%Y'))

str(datModDate)

## Plot1
with(datModDate,
     hist(Global_active_power, col = 'red', 
          main = "Global Active Power",
          xlab = 'Global Active Power (kilowatts)'
     )
)

dev.copy(png, file = 'plot1.png', width = 480, height = 480)
dev.off()
