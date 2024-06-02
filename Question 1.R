#Read the data set
Infectious_Diseases <- read.csv("Infectious Disease 2001-2014.csv")

#Install and run necessary packages for our graphs.
install.packages("ggplot2")
library(ggplot2)

install.packages("dplyr")
library(dplyr)

install.packages("trend")
library(trend)

#----------- #Question 1 -----------# 
#Which county had the upward trend of Amebiasis disease regardless of gender?

#Filter data for cases of Amebiasis based off total cases and group each county by year.
Amebiasis <- Infectious_Diseases %>%
filter(Sex == "Total", Disease == "Amebiasis") %>%
group_by(County, Year) %>%
summarise(Cases = sum(Count))

#Print's the data so we know the filters have worked.
print(n = 826, Amebiasis)

#Create separate line plots for each county to visualize any upward trends.
ggplot(data = Amebiasis, aes(x = Year, y = Cases, color = County, group = County)) +
geom_smooth() + geom_point() + theme_bw() + facet_wrap(~County) +
labs(title = "Trend of Amebiasis Cases by County", x = "Year", y = "Total Cases", color = "County")

#Filter the Amebiasis data even more for counties which have a higher infection count in 2014 than in 2001
increasing_trends <- Amebiasis %>%
filter(Cases[Year == 2014] > Cases[Year == 2001])

#Print's the data so we know the filters have worked.
print(n = 126, increasing_trends)

#Plot that new data
ggplot(data = increasing_trends, aes(x = Year, y = Cases, color = County, group = County)) +
geom_smooth() + geom_point() + theme_bw() + facet_wrap(~County) +
labs(title = "Trend of Amebiasis Cases by County", x = "Year", y = "Total Cases", color = "County")

#Filter the data for the county with the most significant Amebiasis upward trend. 
SanDiego <- Amebiasis %>%
filter(County == "San Diego")

#Create a Mann-Kendall trend test for the San Diego data set.
mk.test(SanDiego$Cases)

#Clear all data for the next test.
rm(list = ls())
