#### Preamble ####
# Purpose: Preparing and modeling the clean data for training and testing.
# Author: Sameeck Bhatia
# Date: 23 November 2024
# Contact: sameeck.bhatia@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   - `package_installation.R` must be run.
# Any other information needed? None

# Loading required libraries
library(tidyverse)
library(arrow)
library(rsample)
library(MLmetrics)

# Reading the cleaned data
cleaned_data <- read_parquet("data/cleaned_data/cleaned_data.parquet")

# Preparing data for the model
model_data <- cleaned_data |>
  select(property_type, beds, baths, half_bath, sqft, days_on_market,
         hoa_month, property_age, price) |>
  mutate(price = ifelse(price < quantile(price, 0.95), price, quantile(price, 0.95))) |>
  drop_na()

# Setting seed for reproducibility
set.seed(12)

split <- initial_split(model_data, prop = 0.7)

training_data <- training(split)
testing_data <- testing(split)

# Fitting model 1
model1 <- lm(data = training_data, 
             formula = price ~ .)

summary(model1)

# Fitting model 2
model2 <- lm(data = training_data, 
             formula = price ~ . - beds - baths)

summary(model2)

anova(model1, model2)

plot(fitted(model2), resid(model2))
qqnorm(resid(model2));qqline(resid(model2))

# Fitting model 3
model3 <- lm(data = training_data, 
             formula = price ~ beds + baths + sqft + hoa_month + sqft:beds)

summary(model3)

plot(fitted(model3), resid(model3))
qqnorm(resid(model3));qqline(resid(model3))

# Evaluating models
testing_data  <- testing_data |>
  mutate(pred1 = predict(model1, testing_data),
         pred2 = predict(model2, testing_data),
         pred3 = predict(model3, testing_data))

RMSE(testing_data$pred1, testing_data$price)
RMSE(testing_data$pred2, testing_data$price)
RMSE(testing_data$pred3, testing_data$price)

R2_Score(testing_data$pred1, testing_data$price)
R2_Score(testing_data$pred2, testing_data$price)
R2_Score(testing_data$pred3, testing_data$price)

# Exporting models
saveRDS(model1, "models/full_model.rds")
saveRDS(model2, "models/reduced_model.rds")
saveRDS(model3, "models/final_model.rds")