library(tidyverse)
library(ggplot2)

bikeshare=read.csv("data/bikeshare.csv")

head(bikeshare, 10)

# Plot A: a line graph showing average bike rentals (total) versus hour of the day (hr).
avg_hr_rent=bikeshare %>%
  group_by(hr) %>%
  summarize(avg_hour_rental=mean(total))

ggplot(data=avg_hr_rent) + 
  geom_line(aes(x=hr, y=avg_hour_rental)) +
  scale_x_continuous(breaks=0:23)

#Plot B: a faceted line graph showing average bike rentals versus hour of the day, faceted according to whether it is a working day (workingday).
avg_hr_work_rent=bikeshare %>%
  group_by(hr, workingday) %>%
  summarize(avg_hour_working_rental=mean(total))


ggplot(data=avg_hr_work_rent) + 
  geom_line(aes(x=hr, y=avg_hour_working_rental)) +
  scale_x_continuous(breaks=0:23) +
  facet_wrap(~ workingday, nrow=2)

#Plot C: a faceted bar plot showing average ridership during the 8 AM hour by weather situation code (weathersit), faceted according to whether it is a working day or not.
bikeshare_8am=bikeshare %>%
  filter(hr==8)

bike_8am_work_wather= bikeshare_8am %>%
  group_by(workingday, weathersit) %>%
  summarise(avg_8am_working_wather=mean(total))

ggplot(data=bike_8am_work_wather) + 
  geom_col(aes(x=weathersit, y=avg_8am_working_wather, fill=weathersit)) +
  facet_wrap(~ workingday, nrow=2)

