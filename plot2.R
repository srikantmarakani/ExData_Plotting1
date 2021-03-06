# I am assuming that the zoo and chron packages are installed. If not, please uncomment the following two lines
# install.packages("zoo")
# install.packages("chron")
library(zoo)
library(chron)
# Read in the data as a zoo file with the index being chron objects containing the date and time
f <- function(d, t) as.chron(paste(as.Date(chron(d, format="d/m/y")), t))
household_power <- read.zoo("household_power_consumption.txt", na.strings="?", header=TRUE, index = 1:2, FUN=f, sep=";")
# Subset the data to the required period 
household_power_assignment <- subset(household_power, index(household_power) >= as.chron(paste(as.Date("2007-02-01"), "00:00:00")) & index(household_power) <= as.chron(paste(as.Date("2007-02-02"), "23:59:59")))
# Make the plot - the code until here is the same for all the parts of the assignment
# Please note that read.zoo converts the date and time to an index so that there are now only 7 columns with the first being the 
# global active power
png("plot2.png")
plot(household_power_assignment[,1], ylab = "Global Active Power (kilowatts)", type="l", xlab="", xaxt="n")
axis(1, at = c(as.chron(paste(as.Date("2007-02-01"), "00:00:00")), as.chron(paste(as.Date("2007-02-02"), "00:00:00")), as.chron(paste(as.Date("2007-02-02"), "23:59:59"))), labels = c("Thu", "Fri", "Sat"))
dev.off()