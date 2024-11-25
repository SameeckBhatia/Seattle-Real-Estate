#### Preamble ####
# Purpose: Simulates mock data on Seattle real estate sale prices.
# Author: Sameeck Bhatia
# Date: 22 November 2024
# Contact: sameeck.bhatia@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   - `tidyverse` package must be installed.
# Any other information needed? None

# Loading required libraries
library(tidyverse)

# Setting a seed for reproducibility
set.seed(12)

n <- 100

# Creating a data frame with simulated values
simulated_data <- data.frame(
  id = sample(10000:99999, n, replace = FALSE),
  zip_code = sample(98101:98140, n, replace = TRUE),
  beds = sample(c(0:5), n, replace = TRUE, prob = c(0.05, 0.1, 0.3, 0.35, 0.15, 0.05)),
  baths = sample(c(1:4), n, replace = TRUE, prob = c(0.1, 0.2, 0.5, 0.2)),
  property_age = round(rexp(n, 1/5)),
  days_on_market = round(rexp(n, 1/14)),
  sqft = round(rnorm(n, 900, 100))
) 

simulated_data <- simulated_data |>
  mutate(price = round(sqft * rpois(n, 700), -3))

# Exporting the simulated data
write_csv(simulated_data, "data/simulated_data/simulated_data.csv")