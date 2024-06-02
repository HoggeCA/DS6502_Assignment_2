#Read the data set
Infectious_Diseases <- read.csv("Infectious Disease 2001-2014.csv")

#Install and run necessary packages for our graphs.
install.packages("ggplot2")
library(ggplot2)

install.packages("dplyr")
library(dplyr)

#----------- #Question 3 -----------#
#In the year 2010, which county had at least 10 infected cases of Malaria?

#Filter the data so that total sex, malaria disease, year, and case count meet the requirements.
Malaria <- Infectious_Diseases %>%
filter(Sex == "Total", Disease == "Malaria", Year == "2010", Count >= 10)

#Verify the filters have been applied successfully.
print(Malaria)

#Code to write a horizontal bar plot comparing counties by malaria case count. 
Mbar <- ggplot(data = Malaria, aes(x = Count, y = County, fill = County)) + 
geom_bar(stat = "identity") + 
labs(title = "Counties with more than 10 cases of Malaria in 2010", x = "Number of Cases", y = "Counties")

#Displays the created bar graph.
print(Mbar)

#Clear all data for the next test.
rm(list = ls())
