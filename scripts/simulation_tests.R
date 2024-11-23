#### Preamble ####
# Purpose: Tests the validity and structure of the simulated data.
# Author: Sameeck Bhatia
# Date: 22 November 2024
# Contact: sameeck.bhatia@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   - `tidyverse` package must be installed.
#   - `testthat` package must be installed.
# Any other information needed? None

# Loading required libraries
library(tidyverse)
library(testthat)

# Loading the simulated data
simulated_data <- read_csv("data/simulated_data/simulated_data.csv")

# Doing unit tests
test_that("IDs are unique", {
  expect_equal(length(unique(simulated_data$id)), n)
})

test_that("Square footage values are non-negative", {
  expect_true(all(simulated_data$sqft > 0))
})

test_that("Square footage values are non-negative", {
  expect_true(all(simulated_data$sqft > 0))
})

test_that("Studios have at least one bath", {
  expect_true(any(simulated_data$beds == 0 & simulated_data$baths >= 1))
})

test_that("Number of beds and baths have at least one instance", {
  expect_true(min(table(simulated_data$beds)) > 0)
  expect_true(min(table(simulated_data$baths)) > 0)
})