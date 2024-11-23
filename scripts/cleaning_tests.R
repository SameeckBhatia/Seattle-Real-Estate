#### Preamble ####
# Purpose: Tests the validity and structure of the cleaned data.
# Author: Sameeck Bhatia
# Date: 23 November 2024
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
cleaned_data <- read_parquet("data/cleaned_data/cleaned_data.parquet")

# Doing unit tests
test_that("IDs are unique", {
  n <- nrow(cleaned_data)
  expect_equal(length(unique(cleaned_data$mls_id)), n)
})

test_that("ZIP code values are valid", {
  expect_true(all(is.numeric(cleaned_data$zip_code)))
})

test_that("Number of beds and baths have at least one instance", {
  expect_true(min(table(cleaned_data$beds)) > 0)
  expect_true(min(table(cleaned_data$baths)) > 0)
})

test_that("Square footage values are non-negative", {
  expect_true(all(cleaned_data$sqft > 0))
})

test_that("Year built values are valid", {
  expect_true(all(cleaned_data$year_built <= 2024))
})

test_that("Price values are non-negative", {
  expect_true(all(cleaned_data$price > 0))
})

test_that("Geographic coordinate values are non-zero", {
  expect_true(all(cleaned_data$latitude != 0))
  expect_true(all(cleaned_data$longitude != 0))
})
