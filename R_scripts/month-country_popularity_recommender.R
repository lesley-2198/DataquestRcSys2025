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

