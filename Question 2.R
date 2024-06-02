#Read the data set
Infectious_Diseases <- read.csv("Infectious Disease 2001-2014.csv")

#Install and run necessary packages for our graphs.
install.packages("ggplot2")
library(ggplot2)

install.packages("dplyr")
library(dplyr)

#----------- #Question 2 -----------#
#In the year 2005, which county had the highest rate of infected females for HIV?

#Filter the data set to meet the requirements of sex disease type year and filter out counties that have less than 10 cases.
HIV <- Infectious_Diseases %>%
filter(Sex == "Female", Disease == "HIV", Year == "2005", Count > 10)

#Print's the data so we know the filters have worked.
print(HIV)

#Plot a bar plot that compares HIV rates in the year 2005 between counties.
HIVplot <- ggplot(data = HIV, aes(x = County, y = Count, fill = County)) + 
geom_bar(stat = "identity") + 
labs(title = "Cases of HIV in females by the year 2005", x = "County", y = "Total Cases")

#Print off the bar graph.
print(HIVplot)

#Measures the correlation between population and number of HIV cases.
cor(HIV$Population, HIV$Count)

#Clear all data for the next test.
rm(list = ls())
