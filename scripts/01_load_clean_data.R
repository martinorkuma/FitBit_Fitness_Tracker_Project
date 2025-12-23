# scripts/01_load_clean_data

# Load the require libraries
install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")
install.packages("tidyr")
install.packages("readr")

library(tidyverse)
library(skimr)
library(janitor)
library(tidyr)
library(readr)

# Load data sets
daily_activity_path <- "data/daily_activity_merged.csv"
daily_steps_path <- "data/dailySteps_merged.csv"
sleep_time_path <- "data/sleepDay_merged.csv"

daily_activity <- read.csv(daily_activity_path, stringsAsFactors = FALSE)
daily_steps <- read.csv(daily_steps_path, stringsAsFactors = FALSE)
sleep_time <- read.csv(sleep_time_path, stringsAsFactors = FALSE)

glimpse(daily_activity)
glimpse(daily_steps)
glimpse(sleep_time)

# Checking for missing data
print("Count of total missing values in daily_activity:")
sum(is.na(daily_activity))
print("Count of total missing values in daily_steps")
sum(is.na(daily_steps))
print("Count of total missing values in sleep_time")
sum(is.na(sleep_time))

# Renaming columns to all lower case
colnames(daily_activity) <- tolower(colnames(daily_activity))
colnames(daily_steps) <- tolower(colnames(daily_steps))
colnames(sleep_time) <- tolower(colnames(sleep_time))

# Examining the new column names
colnames(daily_activity)
colnames(daily_steps)
colnames(sleep_time)

# Using the rename() function to rename the date columns. 
daily_activity <- daily_activity %>% 
  rename(date = activitydate)

daily_steps <- daily_steps %>% 
  rename(date = activityday)

sleep_time <- sleep_time %>% 
  rename(date_raw = sleepday)

sleep_time <- sleep_time %>% 
  separate(date_raw, into = c("date", "time"), sep = " ")

# format all date-time columns across all datasets:
daily_activity$date = as.POSIXct(daily_activity$date, format = "%m/%d/%Y")
daily_steps$date = as.POSIXct(daily_steps$date, format = "%m/%d/%Y")
sleep_time$date = as.POSIXct(sleep_time$date, format = "%m/%d/%Y")

# Use the is.na function to check for missing values.
sum(is.na(daily_activity))
sum(is.na(daily_steps))
sum(is.na(sleep_time))
