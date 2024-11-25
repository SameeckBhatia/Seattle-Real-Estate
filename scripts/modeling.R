#### Preamble ####
# Purpose: Preparing and modeling the clean data for training and testing.
# Author: Sameeck Bhatia
# Date: 23 November 2024
# Contact: sameeck.bhatia@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   - `tidyverse` package must be installed.
#   - `arrow` package must be installed.
#   - `rsample` package must be installed.
#   - `MLmetrics` package must be installed.
#   - `car` package must be installed.
# Any other information needed? None

# Loading required libraries
library(tidyverse)
library(arrow)
library(rsample)
library(MLmetrics)
library(car)

# Reading the cleaned data
cleaned_data <- read_parquet("data/cleaned_data/cleaned_data.parquet")

# Preparing data for the model
model_data <- cleaned_data |>
  select(property_type, zip_code, beds, baths, half_bath, sqft, days_on_market,
         property_age, price)

# Setting seed for reproducibility
set.seed(12)

split <- initial_split(model_data, prop = 0.7)

training_data <- training(split)
testing_data <- testing(split)

# Fitting model 1
model1 <- lm(data = training_data, 
             formula = price ~ .)

y_pred <- predict(model1, newdata = testing_data)
y_true <- testing_data$price

# Evaluating model 1
rmse1 <- RMSE(y_pred, y_true)
mae1 <- MAE(y_pred, y_true)
r2_1 <- R2_Score(y_pred, y_true)

summary(model1)

# Fitting model 2
model2 <- lm(data = training_data, 
             formula = price ~ property_type + beds + sqft + property_age)

y_pred <- predict(model2, newdata = testing_data)
y_true <- testing_data$price

# Evaluating model 2
rmse2 <- RMSE(y_pred, y_true)
mae2 <- MAE(y_pred, y_true)
r2_2 <- R2_Score(y_pred, y_true)

summary(model2)

anova(model1, model2)

plot(fitted(model2), resid(model2))
qqnorm(resid(model2));qqline(resid(model2))
powerTransform(model2)

# Fitting model 3
model3 <- lm(data = training_data, 
             formula = price^(-1/4) ~ property_type + beds + sqft + property_age + sqft:beds)

y_pred <- predict(model3, newdata = testing_data)
y_true <- testing_data$price^(-1/4)

# Evaluating model 3
rmse3 <- RMSE(y_pred, y_true)
mae3 <- MAE(y_pred, y_true)
r2_3 <- R2_Score(y_pred, y_true)

summary(model3)

plot(fitted(model3), resid(model3))
qqnorm(resid(model3));qqline(resid(model3))

# Summarizing metrics
data.frame(
  model1 = c(rmse1, mae1, r2_1),
  model2 = c(rmse2, mae2, r2_2),
  model3 = c(rmse3, mae3, r2_3),
  row.names = c("RMSE", "MAE", "R^2")
)

# Exporting model
saveRDS(model3, "models/valuation_model.rds")