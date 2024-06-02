# Install package
install.packages("dplyr")
# Import package
library(dplyr)

# Install package "ggplot2"
install.packages("ggplot2")
# Import package
library(ggplot2)
  
#Data
InfectiousDisease <- read.csv("Infectious Disease 2001-2014.csv")
InfectiousDisease

summary(InfectiousDisease)


#----------Question 4-----------#
#In the period of 2010 - 2012, which county had at NO infected case for Tuberculosis? 

#To turn off scientific notation
options(scipen=999)

# Filter data for the years 2010 to 2012 and Tuberculosis
tuberculosis <- InfectiousDisease %>%
  filter(Disease == "Tuberculosis" & Year >= 2010 & Year <= 2012 & Sex == "Total")
tuberculosis

# 0 cases of tuberculosis (Count == 0) --- returns n count  
zero_cases <- tuberculosis %>%
  filter(Count == 0) %>%
  select(Count)%>%
  count()
zero_cases

# List of 0 cases of tuberculosis (count == 0) --- returns name of counties
zero_cases_names <- tuberculosis %>%
  filter(Count == 0) %>%
  select(County)
zero_cases_names

# At least 10 cases of tuberculosis (Count >= 1 & Count <= 0) --- returns n count    
at_least_10_cases <- tuberculosis %>%
  filter(Count <= 10) %>%
  select(Count)%>%
  count()
at_least_10_cases

# Everyother county with tuberculosis (Count > 10) --- returns n count      
more_than_10_cases <- tuberculosis %>%
  filter(Count >= 10) %>%
  select(Count)%>%
  count()
more_than_10_cases

#The ratio of counties with NO case to the other counties? 
ratio_zerocases <- zero_cases / (more_than_10_cases + at_least_10_cases)
ratio_zerocases
  #result 0.25

#The ratio of counties with at-least-10 to the other counties? 
ratio_at_least_10_cases <- at_least_10_cases / more_than_10_cases
ratio_at_least_10_cases
  #result 1.432432

# Filter data for the years 2010 to 2012 and Tuberculosis
Avg_Population <- tuberculosis %>%
  group_by(County) %>%
  summarise(cases = sum(Count),average = round(mean(Population),digits = 0))
Avg_Population

#Correlation between average population size by county and tuberculosis cases 
correlation_tuberculosis<- cor(Avg_Population$cases, Avg_Population$average)
correlation_tuberculosis
  #results [1] 0.9965467

scatterplot_population_tuberculosis <-ggplot(data = Avg_Population, aes(x = cases, y = average)) + 
  geom_point (size=2, shape=25, color = 'red') +
  geom_smooth (formula = y ~ x, method = 'lm', color='black', linetype="dashed") +
  labs(x = "Cases", y = "Avg Population", 
       title = "Average Population Size and Tuberculosis cases by County") 
scatterplot_population_tuberculosis


#Clear all data.
rm(list = ls())
