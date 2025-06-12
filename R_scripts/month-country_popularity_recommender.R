# Convert InvoiceDate to date-time if necessary
clean_data <- clean_data %>%
  mutate(InvoiceDate = ymd_hms(InvoiceDate))  # or ymd() if no time

# Add Month column (as a labeled factor like Jan, Feb, etc.)
clean_data <- clean_data %>%
  mutate(Month = month(InvoiceDate, label = TRUE))

# Most popular items per month (based on quantity)
monthly_popularity <- clean_data %>%
  group_by(Month, Description) %>%
  summarise(total_quantity = sum(Quantity), .groups = "drop") %>%
  arrange(Month, desc(total_quantity)) %>%
  group_by(Month) %>%
  slice_max(order_by = total_quantity, n = 10)  # top 10 items per month


# Convert to a named list for easy access
month_pop_list <- monthly_popularity %>%
  group_by(Month) %>%
  summarise(items = list(Description)) %>%
  deframe()


# Top 10 popular items per country (based on quantity purchased)
country_popularity <- clean_data %>%
  group_by(Country, Description) %>%
  summarise(total_quantity = sum(Quantity), .groups = "drop") %>%
  arrange(Country, desc(total_quantity)) %>%
  group_by(Country) %>%
  slice_max(order_by = total_quantity, n = 10)

#Lookup list
country_pop_list <- country_popularity %>%
  group_by(Country) %>%
  summarise(items = list(Description)) %>%
  deframe()


# Get total quantity by Month, Country, and Product Description
country_month_popularity <- clean_data %>%
  group_by(Month, Country, Description) %>%
  summarise(total_quantity = sum(Quantity), .groups = "drop")

# Select top 5 most globally popular products
top_products <- clean_data %>%
  count(Description, sort = TRUE) %>%
  slice_head(n = 5) %>%
  pull(Description)

# Select top 5 countries by transaction volume
top_countries <- clean_data %>%
  count(Country, sort = TRUE) %>%
  slice_head(n = 5) %>%
  pull(Country)

# Filter for those
filtered_popularity <- country_month_popularity %>%
  filter(
    !is.na(Country),
    !is.na(Month),
    Description %in% top_products,
    Country %in% top_countries
  )


ggplot(filtered_popularity, aes(x = Month, y = total_quantity, fill = Country)) +
  geom_col(position = "dodge") +
  facet_wrap(~ Description, scales = "free_y") +
  theme_minimal() +
  labs(
    title = "Monthly Product Popularity Across Top Countries",
    x = "Month", y = "Total Quantity Purchased"
  )

ggsave("visuals/monthly_product_popularity_by_country.png", width = 15, height = 10, dpi = 300)

# Filter data for one product
seasonal_product <- "WHITE HANGING HEART T-LIGHT HOLDER"

product_trend <- country_month_popularity %>%
  filter(Description == seasonal_product, Country %in% top_countries)

# Plot
ggplot(product_trend, aes(x = Month, y = total_quantity, color = Country, group = Country)) +
  geom_line(size = 1.2) +
  geom_point() +
  theme_minimal() +
  labs(
    title = paste("Monthly Popularity of", seasonal_product),
    x = "Month", y = "Quantity Purchased"
  )

ggsave("visuals/monthly_trend_white_heart.png", width = 9, height = 5, dpi = 300)
