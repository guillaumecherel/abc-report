library(tidyverse)

datafile <- "data/mixGauss3D.csv"
input_variables <- c("theta1", "theta2", "theta3") 

post <- read_csv(datafile) %>% 
  select_at(c(input_variables, "weight")) %>%
  filter(weight > 0) %>%
  mutate(weight = weight / sum(weight))

resample <- sample_n(post, 1000, replace=TRUE, weight=weight) %>%
  select(-weight)

write_csv(resample, "data/resample.csv")
