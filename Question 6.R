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

#------------------ Question 6 -----------------------#
#(a) Are the rates of Dengue disease in San Diego and in San Francisco statistically different? 
#- Which test should be used to investigate the statistical difference? 

#Filter for San Francisco Dengus Rate  ---- Total Sex & 2001-2014
San_Francisco_Dengus <- InfectiousDisease %>%
  filter(Disease == "Dengue" & County == "San Francisco" & Sex == "Total") 
San_Francisco_Dengus
summary(San_Francisco_Dengus) #Sample Size n = 14

#Filter for San Diego Dengus Rate ---- Total Sex & 2001-2014
San_Diego_Dengus <- InfectiousDisease %>%
  filter(Disease == "Dengue" & County == "San Diego" & Sex == "Total")
San_Diego_Dengus
summary(San_Diego_Dengus) #Sample Size n = 14

#Test for normality
#Histogram
hist(San_Francisco_Dengus$Rate, col='steelblue', main='Dengus Rate in San Francisco', xlab = "Dengus Rate") 
#Result: Left skewed no bell curve
hist(San_Diego_Dengus$Rate, col='steelblue', main='Dengus Rate in San Diego', xlab = "Dengus Rate") 
#Result: Left skewed no bell curve

#Shapiro-Wilk Test
shapiro.test(San_Francisco_Dengus$Rate) 
#Results: p-value = 0.0001465 < 0.05
shapiro.test(San_Diego_Dengus$Rate) 
#Results: p-value = 0.01337 < 0.05

#Both sample data are non-parametric


#Wilcoxon–Mann–Whitney (WMW) test
wilcox.test(San_Francisco_Dengus$Rate, San_Diego_Dengus$Rate, paired=FALSE) 
#Results = W = 83.5, p-value = 0.4917

#Clear all data.
rm(list = ls())