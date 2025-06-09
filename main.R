# main.R (Master Script)

# 1. Load packages
library(tidyverse)
library(recommenderlab)
library(lubridate)
library(readxl)

# 2. Import required data manually

# Read cleaned data
clean_data <- read_csv("cleaned_data/clean_data.csv")

# Read matrices
customer_item <- read_csv("cleaned_data/customer_item.csv")
user_item_matrix <- read_csv("cleaned_data/user_item_matrix.csv")

# Read popularity data
top_products <- read_csv("cleaned_data/top_products.csv")
popular_by_country <- read_csv("cleaned_data/popular_by_country.csv")

# 3. Run popularity models
source("R_scripts/popularity-based_recommender.R")
source("R_scripts/group-specific_popularity_recommender.R")
source("R_scripts/month-country_popularity_recommender.R")

# 4. Run collaborative filtering models
source("R_scripts/user-based_collaborative_filtering.R")
source("R_scripts/item-based_collaborative_filtering.R")

# 5. Run evaluations (optional on every start)
source("R_scripts/ubcf_evaluation_scheme.R")
source("R_scripts/ibcf_evaluation_scheme.R")

# 6. Run hybrid logic
source("R_scripts/hybrid_via_score_averaging.R")
source("R_scripts/hybrid_via_score_averaging_(weighted).R")
source("R_scripts/full_weighted_hybrid_recommender.R")

# 7. Load visualizations (optional)
# source("visuals/plot_model_comparisons.R")  # if you create one


list.files("R_scripts")
