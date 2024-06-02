#Read the data set
Infectious_Diseases <- read.csv("Infectious Disease 2001-2014.csv")

#Install and run necessary packages for our graphs.
install.packages("ggplot2")
library(ggplot2)

install.packages("dplyr")
library(dplyr)

install.packages("multcomp")
library(multcomp)

#----------- #Question 7 -----------#
#Are the rates of Cryptosporidiosis in California, Lake, San Diego, and San Francisco statistically different from each other (ignoring the year)?

#Filter cases of cryptosporidiosis regardless of sex and limited to the four specified counties.
Cryptosporidiosis <- Infectious_Diseases %>%
filter(Sex == "Total", Disease == "Cryptosporidiosis", County %in% c("California", "Lake", "San Diego", "San Francisco"))

#Proving the filters have worked
print(Cryptosporidiosis)

#Creating a box plot 
Cboxplot <- ggplot(Cryptosporidiosis, aes(x = County, y = Count, fill = County)) +
geom_boxplot() +
labs(title = "Cryptosporidiosis Cases by County", x = "County", y = "Cases")

#Print off the box plot.
print(Cboxplot)

#ANOVA Test
AnovaTest <- aov(Count ~ County, data = Cryptosporidiosis)
#ANOVA Test Result.
summary(AnovaTest)

#TukeyHSD Test based off ANOVA test data
Tfindings<- TukeyHSD(AnovaTest)

#TukeyHSD results
#Shows that California is the most significantly different from all counties and that San Diego and San Francisco are the most similar.
print(Tfindings)

#Clear all data.
rm(list = ls())
