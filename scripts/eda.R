#### Preamble ####
# Purpose: Conducting exploratory data analysis on the cleaned data.
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

# Reading the cleaned data
cleaned_data <- read_parquet("data/cleaned_data/cleaned_data.parquet")

glimpse(cleaned_data)

# Displaying summary statistics
summary(cleaned_data)

# Plotting histograms
ggplot(cleaned_data, aes(x = sqft)) + 
  geom_histogram(fill = "beige", color = "black") +
  labs(x = "Size (sqft)", y = NULL)

ggplot(cleaned_data, aes(x = days_on_market)) + 
  geom_histogram(fill = "beige", color = "black") +
  labs(x = "Days on Market", y = NULL)

ggplot(cleaned_data, aes(x = hoa_month)) + 
  geom_histogram(fill = "beige", color = "black") +
  labs(x = "HOA Fees ($/month)", y = NULL)

ggplot(cleaned_data, aes(x = price)) + 
  geom_histogram(fill = "beige", color = "black") +
  labs(x = "Price ($)", y = NULL)

ggplot(cleaned_data, aes(x = property_age)) + 
  geom_histogram(fill = "beige", color = "black") +
  labs(x = "Property Age (years)", y = NULL)

# Plotting bar charts
cleaned_data |> 
  ggplot(aes(x = property_type)) +
  geom_bar(fill = "beige", color = "black") +
  labs(x = "Property Type", y = NULL)

cleaned_data |> 
  mutate(beds = as.factor(beds)) |>
  ggplot(aes(x = beds)) +
  geom_bar(fill = "beige", color = "black") +
  labs(x = "Beds", y = NULL)

cleaned_data |> 
  mutate(baths = as.factor(baths)) |>
  ggplot(aes(x = baths)) +
  geom_bar(fill = "beige", color = "black") +
  labs(x = "Baths", y = NULL)

# Plotting box plots
cleaned_data |> 
  ggplot(aes(x = property_type, y = price)) +
  geom_boxplot(fill = "beige", color = "black") +
  labs(x = "Property Type", y = "Price ($)") +
  coord_flip()

cleaned_data |> 
  mutate(beds = as.factor(beds)) |>
  ggplot(aes(x = beds, y = price)) +
  geom_boxplot(fill = "beige", color = "black") +
  labs(x = "Beds", y = "Price ($)") +
  coord_flip()

cleaned_data |> 
  mutate(baths = as.factor(baths)) |>
  ggplot(aes(x = baths, y = price)) +
  geom_boxplot(fill = "beige", color = "black") +
  labs(x = "Baths", y = "Price ($)") +
  coord_flip()

# Plotting scatter plots
cleaned_data |> 
  ggplot(aes(x = sqft, y = price)) + 
  geom_point(color = "black") +
  labs(x = "Size (sqft)", y = "Price ($)")

cleaned_data |> 
  ggplot(aes(x = price, y = hoa_month)) + 
  geom_point(color = "black") +
  labs(x = "Price ($)", y = "HOA Fees ($/month)")
