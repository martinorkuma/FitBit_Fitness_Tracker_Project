# scripts/02_exploratory_data_analysis

# Load the require libraries
library(tidyverse)
library(skimr)
library(janitor)
library(tidyr)
library(readr)

# Get summary statistics for each data set:
daily_activity %>% 
  select(totalsteps, totaldistance, calories) %>% 
  summary()

daily_steps %>% 
  select(steptotal) %>% 
  summary()

sleep_time %>% 
  select(totalminutesasleep, totaltimeinbed) %>% 
  summary()

# Merging data frames using the merge function, which works like an Inner JOIN. 
# I will perform the merge in successive steps.
merged_data_temp <- merge(daily_activity, daily_steps, by = c("id", "date"))
merged_data <- merge(merged_data_temp, sleep_time, by = c("id", "date"))
glimpse(merged_data)

# Ensure all numerical columns are indeed integers
merged_data$totalsteps <- as.integer(merged_data$totalsteps)
merged_data$totaldistance <- as.integer(merged_data$totaldistance)
merged_data$veryactivedistance <- as.integer(merged_data$veryactivedistance)
merged_data$lightactivedistance <- as.integer(merged_data$lightactivedistance)
merged_data$sedentaryactivedistance <- as.integer(merged_data$sedentaryactivedistance)
merged_data$calories <- as.integer(merged_data$calories)
merged_data$totalminutesasleep <- as.integer(merged_data$totalminutesasleep)
merged_data$moderatelyactivedistance <- as.integer(merged_data$moderatelyactivedistance)

# Finding distinct users in the data set
n_distinct(merged_data$id)

# Exploratory Data Analysis
# I then analyzed usage activities for the 24 FitBit users
# Plot showing the number of steps taken by users.
ggplot(data = merged_data) +
geom_histogram(
mapping = aes(x = totalsteps),
bins = 30,
color = "black",
fill = "lightblue"
) +
labs(title = "Distribution of Daily Steps", x = "Total Steps", y = "Count")

# Merging the three active columns before creating the plot:
merged_data <- merged_data %>%
mutate(total_active_minutes = veryactiveminutes + fairlyactiveminutes + lightlyactiveminutes)
# Plot showing the total active minutes among users.
ggplot(data = merged_data) +
geom_histogram(mapping = aes(x = total_active_minutes), bins = 30, fill = "violet", color = "black") +
labs(title = "Distribution of Active Time", x = "Total Active Minutes", y = "Count")

# Correlation between time spent in bed and total active time:
ggplot(merged_data, aes(x = totaltimeinbed, y = total_active_minutes)) +
  geom_point(color = "purple", alpha = 0.6) +
  geom_smooth(method = "lm", color = "red", se = TRUE) + 
  labs(
    title = "Correlation between Active Time and Time Spent in Bed",
    x = "Time Spent in Bed (Min)",
    y = "Active Time (min)"
  )

#Scatter plot showing the correlation between active time and calories burned
ggplot(data = merged_data, aes(x = total_active_minutes, y = calories)) +
  geom_point(color = "blue") +  
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Trend line with confidence interval
  labs(
    title = "Correlation between Active Time and Calories Burned",
    x = "Daily Active Time (min)",
    y = "Calories Burned (Cal)"
  )

# Correlation between time spent asleep and calories
ggplot(data = merged_data, aes(x = totalminutesasleep, y = calories)) +
  geom_point(color = "brown") +  
  geom_smooth(method = "lm", color = "blue", se = TRUE) +  # Trend line with confidence interval
  labs(
    title = "Correlation between Time Spent Asleep and Calories Burned",
    x = "Time Spent Asleep (min)",
    y = "Calories Burned (Cal)"
  )

