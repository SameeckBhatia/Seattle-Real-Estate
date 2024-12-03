# Seattle Real Estate

## Overview

This repository contains an end-to-end project for creating a property valuation model Seattle using data from Redfin. The goal is to use R programming and statistical modeling to estimate property values based on features found in current listing data. This project includes data processing, exploratory analysis, model building, and validation to better value real estate in Seattle.

## File Structure

The repo is structured as follows:

-   `data` contains all data (simulation, raw, analysis, and spatial) relevant to the research.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, sketches, and a datasheet for the raw data.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Statement on LLM Usage

Parts of this project, including code for unit testing, data cleaning, and data visualization, were created with the assistance of ChatGPT 4o. The details of these interactions are recorded in `other/llm/usage.txt`.

## Installation Instructions

To replicate the analysis using all required libraries, run the R script located in `scripts` titled `package_installation.R`.
