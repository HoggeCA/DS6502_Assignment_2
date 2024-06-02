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

#------------------ Question 5 -----------------------#
#(a) What is the correlation (R) between the rates of Chlamydia and Salmonellosis diseases in California? 
#(You are required to create a suitable plot to support the statistical analysis) 


#filter for chlamydia
chlamydia <- InfectiousDisease %>%
  filter(Disease == "Chlamydia" & County == "California" & Sex == "Total")
chlamydia

#filter for salmonellosis
salmonellosis <- InfectiousDisease %>%
  filter(Disease == "Salmonellosis" & County == "California" & Sex == "Total")
salmonellosis

#combine both salmonellosis and chlamydi
salmonellosis_chlamydia <- InfectiousDisease %>%
  filter(grepl('Salmonellosis|Chlamydia',Disease) & County == "California" & Sex == "Total")
salmonellosis_chlamydia

#correlation between Chlamydia and Salmonellosis in California
CS_correlation <- cor(chlamydia$Rate, salmonellosis$Rate)
CS_correlation
  #Outcome:[1] 0.4160056

#correlation between Chlamydia and Salmonellosis in California using Spearmans method
CS_correlation_spearmans <- cor(chlamydia$Rate, salmonellosis$Rate, method = "spearman")
CS_correlation_spearmans 
  #Outcome:[1] 0.4857143


#scatterplot
scatterplot_chlamydia_salmonellosis <-ggplot(data = salmonellosis_chlamydia, aes(x = Year, y = Rate)) + 
  geom_point(size=2, shape=23, color = 'red') +
  geom_smooth(method = 'lm', color='black', linetype="dashed") +
  labs(x = "Year", y = "Rate", 
       title = "Correlation between the rates of Chlamydia and Salmonellosis diseases in California") 
scatterplot_chlamydia_salmonellosis


#Clear all data.
rm(list = ls())
