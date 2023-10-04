rm(list=ls()) # clear the environment
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#-------Import necessary packages here-------------------#
library(tidyverse) 

#------ Uploading PERMID --------------------------------#
PERMID <- "xxxxx" #Type your PERMID with the quotation marks
PERMID <- as.numeric(gsub("\\D", "", PERMID)) #Don't touch
set.seed(PERMID) #Don't touch

#------- Answers ----------------------------------------#

mySecretNumber <- sample(c(1:1000) , 1)
# creating a vector containing numbers 1 to 26
key <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26)

# creating variable equal to 1000 plus secret number
size <- 1000 + mySecretNumber

# randomly sample with replacement numbers from key using size variable
random_index <- sample(key, size, replace = T)

# creating a vector such that the first value is the first number 
# in random_index, second is last in random_index, and third is 
# the secret number value
index <- c(random_index[1], random_index[size], random_index[mySecretNumber])

# creating vector where first value is letter corresponding with first 
# random index value, and so on for three values
code <- c(LETTERS[random_index[1]], LETTERS[random_index[2]], 
          LETTERS[random_index[3]])

# print secret code
cat("My secret code is", code)


#------Problem 2-----------------------------------#

# importing data and saving it under a new name
stearnsWharfTemp_data <- read_csv("stearnsWharfTemp.csv")

# filtering the data to only in the year 2022
stearnsWharfTemp_2022f <- filter(stearnsWharfTemp_data, (theYear == 2022))

# creating a tibble for temp, month, and hour columns
stearnsWharfTemp_2022 <- tibble("temperature" = stearnsWharfTemp_2022f$temperature, 
                                  "theMonth" = stearnsWharfTemp_2022f$theMonth, 
                                  "theHour" = stearnsWharfTemp_2022f$theHour)

# creating a tibble for the filtered data with temp converted to Celsius 
temperature_C <- (stearnsWharfTemp_2022$temperature - 32)/1.8
stearnsWharfTemp_2022_C <- tibble("temperature" = stearnsWharfTemp_2022$temperature,
                                  "theMonth" = stearnsWharfTemp_2022$theMonth,
                                  "theHour" = stearnsWharfTemp_2022$theHour,
                                  temperature_C)

# filter the 2022 data between the hours of 5am and 8am and only during the summer months
filterMorningSummer <- filter(stearnsWharfTemp_2022_C, theHour %in% c(5, 6, 7, 8), theMonth %in% c(6, 7, 8))

# creating tibble that reports summary stats
morning_summer_C <- tibble("minimum_temp" = min(filterMorningSummer$temperature_C), 
                           "average_temp" =mean(filterMorningSummer$temperature_C), 
                           "median_temp" =median(filterMorningSummer$temperature_C), 
                           "maximum_temp" =max(filterMorningSummer$temperature_C))

# filter the 2022 data between the hours of 5pm and 8pm and only during the summer months
filterEveningSummer <- filter(stearnsWharfTemp_2022_C, theHour %in% c(17, 18, 19 , 20),
                              theMonth %in% c(6, 7, 8))

# creating a tibble that reports the summary stats for the evening summer
evening_summer_C <- tibble("minimum_temp" = min(filterEveningSummer$temperature_C), 
                           "average_temp" =mean(filterEveningSummer$temperature_C), 
                           "median_temp" =median(filterEveningSummer$temperature_C), 
                           "maximum_temp" =max(filterEveningSummer$temperature_C))




