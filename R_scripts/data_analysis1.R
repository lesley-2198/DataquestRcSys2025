# Load required packages
library(tidyverse)   # For data wrangling and visualization
library(lubridate)   # For date handling

# Read the CSV data
data <- read_csv("data.csv")

# Check structure of the dataset
glimpse(data)  # Quick look at columns and data types

# View column names and summary stats
colnames(data)
summary(data)

# Count total rows
nrow(data)

# Count missing values
sum(is.na(data))


# Filter out invalid transactions
clean_data <- data %>%
  filter(
    !is.na(CustomerID),        # Remove rows with missing customer
    Quantity > 0,              # Remove returns and cancellations
    UnitPrice > 0              # Remove erroneous pricing
  )

# Optional: Convert InvoiceDate to Date format
clean_data <- clean_data %>%
  mutate(InvoiceDate = ymd_hms(InvoiceDate))  # if it's in "day-month-year hour:min" format


# Top 10 most purchased products
clean_data %>%
  group_by(Description) %>%
  summarise(total_quantity = sum(Quantity)) %>%
  arrange(desc(total_quantity)) %>%
  slice_head(n = 10)


# Top 10 most active customers
clean_data %>%
  group_by(CustomerID) %>%
  summarise(total_purchases = n()) %>%
  arrange(desc(total_purchases)) %>%
  slice_head(n = 10)


# Distribution of quantity purchased
ggplot(clean_data, aes(x = Quantity)) +
  geom_histogram(bins = 30) +
  labs(title = "Distribution of Quantity Purchased")













