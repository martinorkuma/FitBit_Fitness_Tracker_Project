# FitBit Fitness Tracker Data - Google Data Analytics Capstone

## **Introduction.**
This report analyzes consumers’ activity levels and usage habits of non-BellaBeat smart products, specifically FitBit. It then compares the usage behavior seen among competitors to that seen among BellaBeat customers.

### Business Task
The data obtained from the FitBit Fitness Tracker can be used to gain insights into consumer behavior, which can be leveraged to improve the design and marketing of BellaBeat products.

### Data Sources
The dataset used in the analysis comes from the [FitBit Fitness Tracker Dataset](http://www.kaggle.com/datasets/arashnic/fitbit/data) created by [Mobius](http://www.kaggle.com/arashnic). The data was collected from 30 eligible FitBit users between 4/12/2016 and 5/12/2016, and it includes details about physical activity, heart rate, and sleep monitoring. This report will focus on daily activity level data, daily steps taken, and sleep time. I downloaded .csv copies of the three datasets in this analysis and conducted all analyses using R in RStudio.

## **Key Findings and Recommendations.**
### Trends in FitBit Usage.
#### Physical Activity:
- Majority of users take between 8,000 and 12,000 steps daily, which corresponds to between 200 and 250 active minutes daily. 
- A significant number of users are logging in near 0 daily steps and 0 active minutes daily.

#### Calories Burned:
- As expected, users with increased activity levels burn more calories daily. 
- Majority of users spend between 100 and 300 minutes active, and burn between 2,000 and 3,500 calories daily.
- The analysis of the correlation between sleep and calories showed no significant correlation, indicating other factors (e.g., physical activity, metabolism, or diet) play a much larger role in calorie expenditure.

#### Sedentary Lifestyle:
- Although there was an inverse relationship between active time and time spent in bed, the correlation was only slight.
- A substantial number of FitBit users in the dataset can be classified as sedentary, logging near zero active minutes and near zero daily steps. 
- Such inactivity does not seem to sufficiently result in time spent sleeping or in bed.

### Recommendations.
- Create personalized goals: Based on data from FitBit users, creating personalized fitness and activity goals may serve as a guide for users to follow. Using insights from this analysis, we can use 10,000 daily steps and 200 daily active minutes as defaults. 
- Set goals reminders: Use reminders to encourage/motivate users to work on accomplishing the goals they have set. 
- Incorporate Machine Learning: Use machine learning to generate personalized activity and sleep recommendations based on each user's data trends. This ensures that recommendations change according to usage. 
- Sleep efficiency: Add a tracker to distinguish between time spent in bed and actual sleep time. This system should also provide feedback, providing personalized suggestions to users with excessive time in bed (>10 hours) to improve their sleep quality and reduce sedentary behavior.
- Data visualization: Providing catchy dashboards will allow users track their activity, including steps, active minutes, calories burned and sleep. This dashboard should also show progress towards their stated goal for each category.

### References
- Deguenon, Rodrigue (2024). [Capstone Project: Bellabeat](https://www.kaggle.com/rodriguedeguenon)
- Mobius (2024). [FitBit Fitness Tracker Dataset](http://www.kaggle.com/datasets/arashnic/fitbit/data)
