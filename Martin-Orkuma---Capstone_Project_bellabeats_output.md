FitBit Fitness Tracker Data - Google Data Analytics Capstone
================

- [**Introduction.**](#introduction)
- [**Preparing the R Environment**](#preparing-the-r-environment)
- [**Processing the Data.**](#processing-the-data)
- [**Analyze the Date.**](#analyze-the-date)
- [**Exploratory Data Analysis.**](#exploratory-data-analysis)
- [**Key Findings and
  Recommendations.**](#key-findings-and-recommendations)

## **Introduction.**

This report analyzes consumers’ activity levels and usage habits of
non-BellaBeat smart products, specifically FitBit. It then compares the
usage behavior seen among competitors to that seen among BellaBeat
customers.

### Business Task

The data obtained from the FitBit Fitness Tracker can be used to gain
insights into consumer behavior, which can be leveraged to improve the
design and marketing of BellaBeat products.

### Data Sources

The dataset used in the analysis comes from the [FitBit Fitness Tracker
Dataset](http://www.kaggle.com/datasets/arashnic/fitbit/data) created by
[Mobius](http://www.kaggle.com/arashnic). The data was collected from 30
eligible FitBit users between 4/12/2016 and 5/12/2016, and it includes
details about physical activity, heart rate, and sleep monitoring. This
report will focus on daily activity level data, daily steps taken, and
sleep time. I downloaded .csv copies of the three datasets in this
analysis and conducted all analyses using R in RStudio.

## **Preparing the R Environment**

### Loading Required R Packages

I began by loading the required R packages into the environment:

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(skimr)
library(janitor)
```

    ## 
    ## Attaching package: 'janitor'
    ## 
    ## The following objects are masked from 'package:stats':
    ## 
    ##     chisq.test, fisher.test

``` r
library(tidyr)
library(readr)
```

### Load Datasets

The next step will be to load all four datasets used in this analysis.

``` r
# I loaded the datasets from the downloaded .csv files
daily_activity <- read.csv("daily_activity_merged.csv", stringsAsFactors = FALSE)
daily_steps <- read.csv("dailySteps_merged.csv", stringsAsFactors = FALSE)
sleep_time <- read.csv("sleepDay_merged.csv", stringsAsFactors = FALSE)
```

    ##           Id ActivityDate TotalSteps TotalDistance TrackerDistance
    ## 1 1503960366    4/12/2016      13162          8.50            8.50
    ## 2 1503960366    4/13/2016      10735          6.97            6.97
    ## 3 1503960366    4/14/2016      10460          6.74            6.74
    ## 4 1503960366    4/15/2016       9762          6.28            6.28
    ## 5 1503960366    4/16/2016      12669          8.16            8.16
    ## 6 1503960366    4/17/2016       9705          6.48            6.48
    ##   LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance
    ## 1                        0               1.88                     0.55
    ## 2                        0               1.57                     0.69
    ## 3                        0               2.44                     0.40
    ## 4                        0               2.14                     1.26
    ## 5                        0               2.71                     0.41
    ## 6                        0               3.19                     0.78
    ##   LightActiveDistance SedentaryActiveDistance VeryActiveMinutes
    ## 1                6.06                       0                25
    ## 2                4.71                       0                21
    ## 3                3.91                       0                30
    ## 4                2.83                       0                29
    ## 5                5.04                       0                36
    ## 6                2.51                       0                38
    ##   FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes Calories
    ## 1                  13                  328              728     1985
    ## 2                  19                  217              776     1797
    ## 3                  11                  181             1218     1776
    ## 4                  34                  209              726     1745
    ## 5                  10                  221              773     1863
    ## 6                  20                  164              539     1728

    ##           Id ActivityDay StepTotal
    ## 1 1503960366   4/12/2016     13162
    ## 2 1503960366   4/13/2016     10735
    ## 3 1503960366   4/14/2016     10460
    ## 4 1503960366   4/15/2016      9762
    ## 5 1503960366   4/16/2016     12669
    ## 6 1503960366   4/17/2016      9705

    ##           Id              SleepDay TotalSleepRecords TotalMinutesAsleep
    ## 1 1503960366 4/12/2016 12:00:00 AM                 1                327
    ## 2 1503960366 4/13/2016 12:00:00 AM                 2                384
    ## 3 1503960366 4/15/2016 12:00:00 AM                 1                412
    ## 4 1503960366 4/16/2016 12:00:00 AM                 2                340
    ## 5 1503960366 4/17/2016 12:00:00 AM                 1                700
    ## 6 1503960366 4/19/2016 12:00:00 AM                 1                304
    ##   TotalTimeInBed
    ## 1            346
    ## 2            407
    ## 3            442
    ## 4            367
    ## 5            712
    ## 6            320

``` r
glimpse(daily_activity)
```

    ## Rows: 940
    ## Columns: 15
    ## $ Id                       <dbl> 1503960366, 1503960366, 1503960366, 150396036…
    ## $ ActivityDate             <chr> "4/12/2016", "4/13/2016", "4/14/2016", "4/15/…
    ## $ TotalSteps               <int> 13162, 10735, 10460, 9762, 12669, 9705, 13019…
    ## $ TotalDistance            <dbl> 8.50, 6.97, 6.74, 6.28, 8.16, 6.48, 8.59, 9.8…
    ## $ TrackerDistance          <dbl> 8.50, 6.97, 6.74, 6.28, 8.16, 6.48, 8.59, 9.8…
    ## $ LoggedActivitiesDistance <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
    ## $ VeryActiveDistance       <dbl> 1.88, 1.57, 2.44, 2.14, 2.71, 3.19, 3.25, 3.5…
    ## $ ModeratelyActiveDistance <dbl> 0.55, 0.69, 0.40, 1.26, 0.41, 0.78, 0.64, 1.3…
    ## $ LightActiveDistance      <dbl> 6.06, 4.71, 3.91, 2.83, 5.04, 2.51, 4.71, 5.0…
    ## $ SedentaryActiveDistance  <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
    ## $ VeryActiveMinutes        <int> 25, 21, 30, 29, 36, 38, 42, 50, 28, 19, 66, 4…
    ## $ FairlyActiveMinutes      <int> 13, 19, 11, 34, 10, 20, 16, 31, 12, 8, 27, 21…
    ## $ LightlyActiveMinutes     <int> 328, 217, 181, 209, 221, 164, 233, 264, 205, …
    ## $ SedentaryMinutes         <int> 728, 776, 1218, 726, 773, 539, 1149, 775, 818…
    ## $ Calories                 <int> 1985, 1797, 1776, 1745, 1863, 1728, 1921, 203…

``` r
glimpse(daily_steps)
```

    ## Rows: 940
    ## Columns: 3
    ## $ Id          <dbl> 1503960366, 1503960366, 1503960366, 1503960366, 1503960366…
    ## $ ActivityDay <chr> "4/12/2016", "4/13/2016", "4/14/2016", "4/15/2016", "4/16/…
    ## $ StepTotal   <int> 13162, 10735, 10460, 9762, 12669, 9705, 13019, 15506, 1054…

``` r
glimpse(sleep_time)
```

    ## Rows: 413
    ## Columns: 5
    ## $ Id                 <dbl> 1503960366, 1503960366, 1503960366, 1503960366, 150…
    ## $ SleepDay           <chr> "4/12/2016 12:00:00 AM", "4/13/2016 12:00:00 AM", "…
    ## $ TotalSleepRecords  <int> 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
    ## $ TotalMinutesAsleep <int> 327, 384, 412, 340, 700, 304, 360, 325, 361, 430, 2…
    ## $ TotalTimeInBed     <int> 346, 407, 442, 367, 712, 320, 377, 364, 384, 449, 3…

## **Processing the Data.**

### Data Cleaning and Manipulation

The first step is to inspect the dataset. I did this by checking for
missing values in each dataset.

``` r
print("Count of total missing values in daily_activity")
```

    ## [1] "Count of total missing values in daily_activity"

``` r
sum(is.na(daily_activity))
```

    ## [1] 0

``` r
print("Count of total missing values in daily_steps")
```

    ## [1] "Count of total missing values in daily_steps"

``` r
sum(is.na(daily_steps))
```

    ## [1] 0

``` r
print("Count of total missing values in sleep_time")
```

    ## [1] "Count of total missing values in sleep_time"

``` r
sum(is.na(sleep_time))
```

    ## [1] 0

Notice that there are no more missing values across all three datasets.

I then renamed the column names in the dataset to match naming
conventions.

``` r
colnames(daily_activity) <- tolower(colnames(daily_activity))
colnames(daily_steps) <- tolower(colnames(daily_steps))
colnames(sleep_time) <- tolower(colnames(sleep_time))

# I am now examining the new column names
colnames(daily_activity)
```

    ##  [1] "id"                       "activitydate"            
    ##  [3] "totalsteps"               "totaldistance"           
    ##  [5] "trackerdistance"          "loggedactivitiesdistance"
    ##  [7] "veryactivedistance"       "moderatelyactivedistance"
    ##  [9] "lightactivedistance"      "sedentaryactivedistance" 
    ## [11] "veryactiveminutes"        "fairlyactiveminutes"     
    ## [13] "lightlyactiveminutes"     "sedentaryminutes"        
    ## [15] "calories"

``` r
colnames(daily_steps)
```

    ## [1] "id"          "activityday" "steptotal"

``` r
colnames(sleep_time)
```

    ## [1] "id"                 "sleepday"           "totalsleeprecords" 
    ## [4] "totalminutesasleep" "totaltimeinbed"

I renamed the ‘date’ columns in each dataset To ensure uniformity:

``` r
# I am using the rename() function to rename the date columns. 
daily_activity <- daily_activity %>% 
  rename(date = activitydate)

daily_steps <- daily_steps %>% 
  rename(date = activityday)

sleep_time <- sleep_time %>% 
  rename(date_raw = sleepday)
```

I want to ensure all values within the date columns of each dataset are
properly formatted.

``` r
# Here, I am using the separate function to separate date and time into two columns, only in the two datasets that have them combined.
sleep_time <- sleep_time %>% 
  separate(date_raw, into = c("date", "time"), sep = " ")
```

``` r
# I will now format all date-time columns across all datasets:
daily_activity$date = as.POSIXct(daily_activity$date, format = "%m/%d/%Y")
daily_steps$date = as.POSIXct(daily_steps$date, format = "%m/%d/%Y")
sleep_time$date = as.POSIXct(sleep_time$date, format = "%m/%d/%Y")

# using the head function to view the new date formats:
head(daily_activity)
```

    ##           id       date totalsteps totaldistance trackerdistance
    ## 1 1503960366 2016-04-12      13162          8.50            8.50
    ## 2 1503960366 2016-04-13      10735          6.97            6.97
    ## 3 1503960366 2016-04-14      10460          6.74            6.74
    ## 4 1503960366 2016-04-15       9762          6.28            6.28
    ## 5 1503960366 2016-04-16      12669          8.16            8.16
    ## 6 1503960366 2016-04-17       9705          6.48            6.48
    ##   loggedactivitiesdistance veryactivedistance moderatelyactivedistance
    ## 1                        0               1.88                     0.55
    ## 2                        0               1.57                     0.69
    ## 3                        0               2.44                     0.40
    ## 4                        0               2.14                     1.26
    ## 5                        0               2.71                     0.41
    ## 6                        0               3.19                     0.78
    ##   lightactivedistance sedentaryactivedistance veryactiveminutes
    ## 1                6.06                       0                25
    ## 2                4.71                       0                21
    ## 3                3.91                       0                30
    ## 4                2.83                       0                29
    ## 5                5.04                       0                36
    ## 6                2.51                       0                38
    ##   fairlyactiveminutes lightlyactiveminutes sedentaryminutes calories
    ## 1                  13                  328              728     1985
    ## 2                  19                  217              776     1797
    ## 3                  11                  181             1218     1776
    ## 4                  34                  209              726     1745
    ## 5                  10                  221              773     1863
    ## 6                  20                  164              539     1728

``` r
head(daily_steps)
```

    ##           id       date steptotal
    ## 1 1503960366 2016-04-12     13162
    ## 2 1503960366 2016-04-13     10735
    ## 3 1503960366 2016-04-14     10460
    ## 4 1503960366 2016-04-15      9762
    ## 5 1503960366 2016-04-16     12669
    ## 6 1503960366 2016-04-17      9705

``` r
head(sleep_time)
```

    ##           id       date     time totalsleeprecords totalminutesasleep
    ## 1 1503960366 2016-04-12 12:00:00                 1                327
    ## 2 1503960366 2016-04-13 12:00:00                 2                384
    ## 3 1503960366 2016-04-15 12:00:00                 1                412
    ## 4 1503960366 2016-04-16 12:00:00                 2                340
    ## 5 1503960366 2016-04-17 12:00:00                 1                700
    ## 6 1503960366 2016-04-19 12:00:00                 1                304
    ##   totaltimeinbed
    ## 1            346
    ## 2            407
    ## 3            442
    ## 4            367
    ## 5            712
    ## 6            320

To conclude the data cleaning process, I checked for missing values
following the column separation.

``` r
# I am using the is.na function to check for missing values.
sum(is.na(daily_activity))
```

    ## [1] 0

``` r
sum(is.na(daily_steps))
```

    ## [1] 0

``` r
sum(is.na(sleep_time))
```

    ## [1] 0

The analysis shows that there are no missing values in the dataset. This
means I can proceed to summarizing and analyzing the data.

## **Analyze the Date.**

### Summary of the Data

Before summarizing the data, I want to find out how many distinct
consumer IDs are reported in each of the datasets.

    ## [1] 33

    ## [1] 33

    ## [1] 24

I then examined the summary statistics of the three datasets: daily
activity, daily steps, and sleep time.

``` r
# In the daily activity dataset:
daily_activity %>% 
  select(totalsteps, totaldistance, calories) %>% 
  summary()
```

    ##    totalsteps    totaldistance       calories   
    ##  Min.   :    0   Min.   : 0.000   Min.   :   0  
    ##  1st Qu.: 3790   1st Qu.: 2.620   1st Qu.:1828  
    ##  Median : 7406   Median : 5.245   Median :2134  
    ##  Mean   : 7638   Mean   : 5.490   Mean   :2304  
    ##  3rd Qu.:10727   3rd Qu.: 7.713   3rd Qu.:2793  
    ##  Max.   :36019   Max.   :28.030   Max.   :4900

``` r
#In the daily steps dataset:
daily_steps %>% 
  select(steptotal) %>% 
  summary()
```

    ##    steptotal    
    ##  Min.   :    0  
    ##  1st Qu.: 3790  
    ##  Median : 7406  
    ##  Mean   : 7638  
    ##  3rd Qu.:10727  
    ##  Max.   :36019

``` r
# In the sleep time dataset:
sleep_time %>% 
  select(totalminutesasleep, totaltimeinbed) %>% 
  summary()
```

    ##  totalminutesasleep totaltimeinbed 
    ##  Min.   : 58.0      Min.   : 61.0  
    ##  1st Qu.:361.0      1st Qu.:403.0  
    ##  Median :433.0      Median :463.0  
    ##  Mean   :419.5      Mean   :458.6  
    ##  3rd Qu.:490.0      3rd Qu.:526.0  
    ##  Max.   :796.0      Max.   :961.0

### Trends

The summary statistics showed that FitBit users engaged in very little
physical activity, with the total steps, total distance, and total
calories burned of some participants being as low as zero. Furthermore,
some users spent less than an hour sleeping on some days.

### Merging the datasets

Merging the datasets will allow for further analysis of the trends and
insights contained in each dataset, and create a holistic insight into
the usage habits of the FitBit users sampled.

``` r
# I am using the merge function, which works like an Inner JOIN. I will perform the merge in successive steps.
merged_data_temp <- merge(daily_activity, daily_steps, by = c("id", "date"))
merged_data <- merge(merged_data_temp, sleep_time, by = c("id", "date"))
head(merged_data)
```

    ##           id       date totalsteps totaldistance trackerdistance
    ## 1 1503960366 2016-04-12      13162          8.50            8.50
    ## 2 1503960366 2016-04-13      10735          6.97            6.97
    ## 3 1503960366 2016-04-15       9762          6.28            6.28
    ## 4 1503960366 2016-04-16      12669          8.16            8.16
    ## 5 1503960366 2016-04-17       9705          6.48            6.48
    ## 6 1503960366 2016-04-19      15506          9.88            9.88
    ##   loggedactivitiesdistance veryactivedistance moderatelyactivedistance
    ## 1                        0               1.88                     0.55
    ## 2                        0               1.57                     0.69
    ## 3                        0               2.14                     1.26
    ## 4                        0               2.71                     0.41
    ## 5                        0               3.19                     0.78
    ## 6                        0               3.53                     1.32
    ##   lightactivedistance sedentaryactivedistance veryactiveminutes
    ## 1                6.06                       0                25
    ## 2                4.71                       0                21
    ## 3                2.83                       0                29
    ## 4                5.04                       0                36
    ## 5                2.51                       0                38
    ## 6                5.03                       0                50
    ##   fairlyactiveminutes lightlyactiveminutes sedentaryminutes calories steptotal
    ## 1                  13                  328              728     1985     13162
    ## 2                  19                  217              776     1797     10735
    ## 3                  34                  209              726     1745      9762
    ## 4                  10                  221              773     1863     12669
    ## 5                  20                  164              539     1728      9705
    ## 6                  31                  264              775     2035     15506
    ##       time totalsleeprecords totalminutesasleep totaltimeinbed
    ## 1 12:00:00                 1                327            346
    ## 2 12:00:00                 2                384            407
    ## 3 12:00:00                 1                412            442
    ## 4 12:00:00                 2                340            367
    ## 5 12:00:00                 1                700            712
    ## 6 12:00:00                 1                304            320

Note: I performed the merge in successive steps because the merge
function in R only accepts two data frames at a time. First, I merged
daily activity with daily steps. Then, I merged this resulting data
frame with the sleep time data frame.

Now, I want to know how many distinct users are in this new data frame.

    ## [1] 24

The results shows that the data frame includes data from 24 unique
individuals.

Before proceeding to the analysis, I want to ensure that the numerical
columns are indeed integers.

``` r
merged_data$totalsteps <- as.integer(merged_data$totalsteps)
merged_data$totaldistance <- as.integer(merged_data$totaldistance)
merged_data$veryactivedistance <- as.integer(merged_data$veryactivedistance)
merged_data$lightactivedistance <- as.integer(merged_data$lightactivedistance)
merged_data$sedentaryactivedistance <- as.integer(merged_data$sedentaryactivedistance)
merged_data$calories <- as.integer(merged_data$calories)
merged_data$totalminutesasleep <- as.integer(merged_data$totalminutesasleep)
merged_data$moderatelyactivedistance <- as.integer(merged_data$moderatelyactivedistance)
```

## **Exploratory Data Analysis.**

In this section, I analyzed the usage activities of the 24 FitBit users
in the following categories:

1.  Daily activity trends analysis.

2.  Correlation analysis.

### a. Daily Activity Trend Analysis (Daily Steps and Time Active)

#### Distribution of Daily Steps:

``` r
# Plot showing the number of steps taken by users. 
ggplot(data = merged_data) + 
  geom_histogram(
    mapping = aes(x = totalsteps), 
    bins = 30, 
    color = "black",
    fill = "lightblue"
  ) +
  labs(title = "Distribution of Daily Steps", x = "Total Steps", y = "Count")
```

![](Martin-Orkuma---Capstone_Project_bellabeats_output_files/figure-gfm/plot%20of%20steps-1.png)<!-- -->

#### Observations:

- The chart shows a roughly normal distribution, with most users taking
  around 10,000 steps daily.
- A majority of users take between 8,000 and 12,000 steps daily.
- There are several of outliers near 0 steps and others with above
  20,000 steps.

#### Distribution of active time:

Active time will be defined as the combination of the very active,
fairly active, and lightly active minutes columns.

``` r
# Merging the three active columns before creating the plot:
merged_data <- merged_data %>% 
  mutate(total_active_minutes = veryactiveminutes + fairlyactiveminutes + lightlyactiveminutes)
```

Next, I created a plot showing the distribution of active time among
users.

``` r
# Plot showing the total active minutes among users.
ggplot(data = merged_data) +
  geom_histogram(mapping = aes(x = total_active_minutes), bins = 30, fill = "violet", color = "black") +
  labs(title = "Distribution of Active Time", x = "Total Active Minutes", y = "Count")
```

![](Martin-Orkuma---Capstone_Project_bellabeats_output_files/figure-gfm/plot%20of%20active%20time-1.png)<!-- -->

#### Observations:

- The charts shows a bell-shaped (normal) distribution, with most users
  falling between 150 and 250 minutes.
- The most common range is between 200 and 250 minutes a day.
- There are significant outliers, with as little as 0 active minutes and
  \> 400 minutes a day.

### b. Correlation Analysis

#### Correlation between time spent in bed and total active time:

``` r
# Correlation between time spent in bed and total active time:
ggplot(merged_data, aes(x = totaltimeinbed, y = total_active_minutes)) +
  geom_point(color = "purple", alpha = 0.6) +
  geom_smooth(method = "lm", color = "red", se = TRUE) + 
  labs(
    title = "Correlation between Active Time and Time Spent in Bed",
    x = "Time Spent in Bed (Min)",
    y = "Active Time (min)"
    )
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Martin-Orkuma---Capstone_Project_bellabeats_output_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

#### Observations:

- The trend line shows a slight negative slope, indicating a weak
  inverse relationship between time spent in bed and active time.
- There is significant variability in the data, indicating that the
  relationship between active time and time spent in bed is not strongly
  linear.
- Users spending the most time in bed (above 800 minutes) generally
  report lower active time.

#### Correlation between Total Active Time and Calories burned:

``` r
#Scatter plot showing the correlation between active time and calories burned
ggplot(data = merged_data, aes(x = total_active_minutes, y = calories)) +
  geom_point(color = "blue") +  
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Trend line with confidence interval
  labs(
    title = "Correlation between Active Time and Calories Burned",
    x = "Daily Active Time (min)",
    y = "Calories Burned (Cal)"
  )
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Martin-Orkuma---Capstone_Project_bellabeats_output_files/figure-gfm/scatter%20plot%20showing%20active%20time%20and%20calories-1.png)<!-- -->

#### Observations:

- The trend line shows a positive slope, indicating a direct
  relationship between daily active time and calories burned. As
  expected, increased activity, yields in more calories burned.
- The scatter points are relatively close to the trend line, suggesting
  a moderate to strong positive correlation between active time and
  calories burned.
- A majority of users cluster between 100 and 300 active minutes and
  burn between 2,000 and 3,500 calories daily.

#### Correlation between Time Spent Asleep and Calories burned:

``` r
# Correlation between time spent asleep and calories
ggplot(data = merged_data, aes(x = totalminutesasleep, y = calories)) +
  geom_point(color = "brown") +  
  geom_smooth(method = "lm", color = "blue", se = TRUE) +  # Trend line with confidence interval
  labs(
    title = "Correlation between Time Spent Asleep and Calories Burned",
    x = "Time Spent Asleep (min)",
    y = "Calories Burned (Cal)"
  )
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Martin-Orkuma---Capstone_Project_bellabeats_output_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

#### Observations:

- The trend line is nearly horizontal, suggesting no significant
  correlation between time spent asleep and calories burned.
- The majority of users slept for between 400 and 600 minutes and burned
  between 2,000 and 3,000 calories daily.
- Some users showed very high calorie burn (\>4,000 calories) and
  varying sleep duration, likely indicating highly active individuals.

## **Key Findings and Recommendations.**

### Trends in FitBit Usage.

#### Physical Activity:

- Majority of users take between 8,000 and 12,000 steps daily, which
  corresponds to between 200 and 250 active minutes daily.
- A significant number of users are logging in near 0 daily steps and 0
  active minutes daily.

#### Calories Burned:

- As expected, users with increased activity levels burn more calories
  daily.
- Majority of users spend between 100 and 300 minutes active, and burn
  between 2,000 and 3,500 calories daily.
- The analysis of the correlation between sleep and calories showed no
  significant correlation, indicating other factors (e.g., physical
  activity, metabolism, or diet) play a much larger role in calorie
  expenditure.

#### Sedentary Lifestyle:

- Although there was an inverse relationship between active time and
  time spent in bed, the correlation was only slight.
- A substantial number of FitBit users in the dataset can be classified
  as sedentary, logging near zero active minutes and near zero daily
  steps.
- Such inactivity does not seem to sufficiently result in time spent
  sleeping or in bed.

### Recommendations.

- **Create personalized goals:** Based on data from FitBit users,
  creating personalized fitness and activity goals may serve as a guide
  for users to follow. Using insights from this analysis, we can use
  10,000 daily steps and 200 daily active minutes as defaults.
- **Set goals reminders:** Use reminders to encourage/motivate users to
  work on accomplishing the goals they have set.
- **Incorporate Machine Learning:** Use machine learning to generate
  personalized activity and sleep recommendations based on each user’s
  data trends. This ensures that recommendations change according to
  usage.
- **Sleep efficiency:** Add a tracker to distinguish between time spent
  in bed and actual sleep time. This system should also provide
  feedback, providing personalized suggestions to users with excessive
  time in bed (\>10 hours) to improve their sleep quality and reduce
  sedentary behavior.
- **Data visualization:** Providing catchy dashboards will allow users
  track their activity, including steps, active minutes, calories burned
  and sleep. This dashboard should also show progress towards their
  stated goal for each category.

### References

- Deguenon, Rodrigue (2024). [Capstone Project:
  Bellabeat](https://www.kaggle.com/rodriguedeguenon)
- Mobius (2024). [FitBit Fitness Tracker
  Dataset](http://www.kaggle.com/datasets/arashnic/fitbit/data)
