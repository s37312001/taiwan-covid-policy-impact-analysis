# Taiwan COVID-19 Policy Impact Analysis

Sys.setlocale("LC_ALL", "en_GB.UTF-8") #translate graph into English

#1. Read data from csv
#Date from 2021/01/16 to 2022/07/03
covid_data <- read.csv("owid-covid-data.csv", header=TRUE) 

#Date from 2020/01/01 to 2022/12/05
facial_coverings <- read.csv("face-covering-policies-covid.csv", header=TRUE) 

#Date from 2020/01/01 to 2022/12/05
cancel_public_events <- read.csv("public-events-covid.csv", header=TRUE)

#Date from 2020/01/01 to 2022/12/05
stay_home_requirements <- read.csv("stay-at-home-covid.csv", header=TRUE) 

#2. Process with data
library(tidyverse)
library(lubridate)

#Separate date to 3 columns
covid_data = covid_data %>%
  mutate(date = ymd(date)) %>%
  mutate_at(vars(date), funs(year, month, day))

#Select data
library(dplyr)

#Rows
covid_data <- filter(covid_data, location=="Taiwan", year == "2021") 

#Columns
covid_data <- select(covid_data, location, date, new_cases) 

facial_coverings = facial_coverings %>%
  mutate(Day = ymd(Day)) %>%
  mutate_at(vars(Day), funs(year, month, day))
facial_coverings <- filter(facial_coverings, Entity=="Taiwan", year == "2021")
facial_coverings <- facial_coverings[,-1:-2]

cancel_public_events = cancel_public_events %>%
  mutate(Day = ymd(Day)) %>%
  mutate_at(vars(Day), funs(year, month, day))
cancel_public_events <- filter(cancel_public_events, Entity=="Taiwan", year == "2021")
cancel_public_events <- cancel_public_events[,-1:-2]

stay_home_requirements = stay_home_requirements %>%
  mutate(Day = ymd(Day)) %>%
  mutate_at(vars(Day), funs(year, month, day))
stay_home_requirements <- filter(stay_home_requirements, Entity=="Taiwan", year == "2021")
stay_home_requirements <- stay_home_requirements[,-1:-2]

#3. Combine & select data by “Day”
colnames(covid_data)[2]  <- "Day"
covid_data = covid_data %>% left_join(facial_coverings, by="Day")
covid_data = covid_data %>% left_join(cancel_public_events, by="Day")
covid_data = covid_data %>% left_join(stay_home_requirements, by="Day")

covid_data <- covid_data[,-c(5,6,7,9,10,11,13,14,15)]

head(covid_data)
tail(covid_data)

#4. Transfer continuous variable (new_cases) to categorical data and add behind the dataset
level_new_cases <- cut(covid_data$new_cases, breaks = 5, labels = 0:4)
covid_data <- cbind(covid_data, level_new_cases)

head(covid_data)
tail(covid_data)

#5. Chi-square test analysis for three policies
chisq.test(covid_data$level_new_cases, covid_data$facial_coverings, correct=FALSE)
#X-squared = 90.402, df = 8, p-value = 3.853e-16

chisq.test(covid_data$level_new_cases, covid_data$cancel_public_events, correct=FALSE)
#X-squared = 119.69, df = 8, p-value < 2.2e-16

chisq.test(covid_data$level_new_cases, covid_data$stay_home_requirements, correct=FALSE)
#X-squared = 119.33, df = 4, p-value < 2.2e-16

#6. Visualisation
library(ggplot2)
library(gridExtra)

facial.plot <- ggplot(covid_data, aes(x=Day))+
  geom_line(aes(y=new_cases/100, col="New Cases (hundred)"))+
  geom_line(aes(y=facial_coverings, col="Levels of Facial Covering Policies"))+
  labs(x=NULL, y=NULL,
    title="Levels of Facial Covering Policies in 2021")+
  scale_colour_manual(name="Legend",
      values=c("New Cases (hundred)"="red",
        "Levels of Facial Covering Policies"="blue"))

plot(facial.plot)

public.plot <- ggplot(covid_data, aes(x=Day))+
  geom_line(aes(y=new_cases/100, col="New Cases (hundred)"))+
  geom_line(aes(y=cancel_public_events, col="Levels of Public Event Cancellation"))+
  labs(x=NULL, y=NULL,
    title="Levels of Public Event Cancellation in 2021")+
  scale_colour_manual(name="Legend",
      values=c("New Cases (hundred)"="red",
        "Levels of Public Event Cancellation"="green"))

plot(public.plot)

home.plot <- ggplot(covid_data, aes(x=Day))+
  geom_line(aes(y=new_cases/100, col="New Cases (hundred)"))+
  geom_line(aes(y=stay_home_requirements, col="Levels of Stay at Home Requirement"))+
  labs(x=NULL, y=NULL,
    title="Levels of Stay at Home Requirement in 2021")+
  scale_colour_manual(name="Legend",
      values=c("New Cases (hundred)"="red",
        "Levels of Stay at Home Requirement"="purple"))

plot(home.plot)

library(gridExtra)
grid.arrange(facial.plot, public.plot, home.plot, ncol=1)

#7. Obtain data again & Choose other indicators
covid_data_2022 <- read.csv("owid-covid-data.csv", header=TRUE)

covid_data_2022 = covid_data_2022 %>%
  mutate(date = ymd(date)) %>%
  mutate_at(vars(date), funs(year, month, day))

covid_data_2022 <- filter(covid_data_2022, location == "Taiwan", year == "2022")
covid_data_2022 <- select(covid_data_2022, location, date, people_vaccinated, total_cases, total_deaths)

#8. Process with missing value
install.packages("zoo")
library("zoo")
covid_data_2022 <- na.locf(covid_data_2022, na.rm = FALSE)
#na.rm = FALSE, in order to keep Null value
covid_data_2022$people_vaccinated[1] <- 18712858

#9. Visualisation
people_vaccinated.bar <- ggplot(covid_data_2022, aes(date,
people_vaccinated/1000000))+geom_bar(stat="identity", fill="lightgreen")+
  labs(x=NULL, y="People vaccinated (million)",
    title="People vaccinated (million) in 2022 (cumulative)")

total_cases.bar <- ggplot(covid_data_2022, aes(date,
total_cases/1000000))+geom_bar(stat="identity", fill="lightblue")+
  labs(x=NULL, y="Total cases (million)",
    title="Total cases (million) in 2022 (cumulative)")

total_deaths.bar <- ggplot(covid_data_2022, aes(date,
total_deaths/1000000))+geom_bar(stat="identity", fill="purple")+
  labs(x=NULL, y="Total deaths (million)",
    title="Total deaths (million) in 2022 (cumulative)")

grid.arrange(people_vaccinated.bar, total_cases.bar, total_deaths.bar, ncol=1)

ggplot(covid_data_2022, aes(date, total_deaths/total_cases))+ geom_line(colour="red")+
  labs(x=NULL, y="Total Deaths/Total Cases", title="Mortality rate")
