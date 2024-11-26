#### Preamble ####
# Purpose: Cleans the raw data to prepare for analysis.
# Author: Sameeck Bhatia
# Date: 23 November 2024
# Contact: sameeck.bhatia@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   - `tidyverse` package must be installed.
#   - `janitor` package must be installed.
#   - `arrow` package must be installed.
# Any other information needed? None

# Loading required libraries
library(tidyverse)
library(janitor)
library(arrow)

# Reading the raw data
raw_0bed <- read_csv("data/raw_data/raw_0bed.csv")
raw_1bed <- read_csv("data/raw_data/raw_1bed.csv")
raw_2bed <- read_csv("data/raw_data/raw_2bed.csv")
raw_3bed <- read_csv("data/raw_data/raw_3bed.csv")
raw_4bed <- read_csv("data/raw_data/raw_4bed.csv")
raw_5bed <- read_csv("data/raw_data/raw_5bed.csv")

# Merging the data
raw_data <- rbind(raw_0bed, raw_1bed, raw_2bed, raw_3bed, raw_4bed, raw_5bed)

# Cleaning the data
cleaned_data <- raw_data |>
  clean_names() |>
  select(sale_type, mls_number, property_type, city, zip_or_postal_code, beds, 
         baths, location, square_feet, year_built, days_on_market, hoa_month,
         price, latitude, longitude) |>
  filter(sale_type != "New Construction Plan",
         !is.na(square_feet), !is.na(year_built),
         year_built <= 2024) |>
  rename(mls_id = mls_number,
         zip_code = zip_or_postal_code,
         neighbourhood = location,
         sqft = square_feet) |>
  mutate(hoa_month = replace_na(hoa_month, 0),
         half_bath = ifelse(is.numeric(baths) & (baths - floor(baths) > 0), 1, 0),
         baths = floor(baths),
         property_age = 2024 - year_built,
         price_sqft = round(price / sqft, 2),
         property_type = case_when(property_type == "Single Family Residential" ~ "Single Family",
                                   .default = property_type))

colSums(is.na(cleaned_data))

cleaned_data |>
  select(mls_id, neighbourhood, beds, baths, sqft, price) |>
  filter(is.na(neighbourhood) | is.na(sqft))

# Exporting cleaned data
write_parquet(cleaned_data, "data/cleaned_data/cleaned_data.parquet")
