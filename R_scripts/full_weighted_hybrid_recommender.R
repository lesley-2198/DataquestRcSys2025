get_full_hybrid_topN <- function(
    ubcf_list, ibcf_list, user_meta,
    country_pop_list, month_pop_list,
    n = 5, w_ubcf = 0.2, w_ibcf = 0.5,
    w_country = 0.2, w_month = 0.1
) {
  user_ids <- intersect(names(ubcf_list), names(ibcf_list))
  
  sapply(user_ids, function(user) {
    # Get metadata for the user
    user_info <- user_meta[user_meta$CustomerID == as.numeric(user), ]
    
    # 🛡 Safely look up country items
    country_items <- if (nrow(user_info) > 0 && user_info$Country %in% names(country_pop_list)) {
      country_pop_list[[user_info$Country]]
    } else {
      character(0)
    }
    
    # 🛡 Safely look up month items
    month_str <- as.character(user_info$Month)
    month_items <- if (nrow(user_info) > 0 && month_str %in% names(month_pop_list)) {
      month_pop_list[[month_str]]
    } else {
      character(0)
    }
    
    # Combine all signals with voting weights
    combined <- c(
      rep(ubcf_list[[user]], each = round(100 * w_ubcf)),
      rep(ibcf_list[[user]], each = round(100 * w_ibcf)),
      rep(country_items, each = round(100 * w_country)),
      rep(month_items, each = round(100 * w_month))
    )
    
    ranked <- sort(table(combined), decreasing = TRUE)
    names(ranked)[1:n]
  })
}


# UBCF and IBCF recommendations
ubcf_list <- as(ubcf_topN, "list")
ibcf_list <- as(ibcf_topN, "list")

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

# Create the country_pop_list from country_popularity
country_pop_list <- country_popularity %>%
  group_by(Country) %>%
  summarise(items = list(Description)) %>%
  deframe()


# User metadata: CustomerID → Country + Month
user_meta <- clean_data %>%
  group_by(CustomerID) %>%
  summarise(
    Country = first(Country),
    Month = first(month(InvoiceDate, label = TRUE)),
    .groups = "drop"
  )

topN_5 <- get_full_hybrid_topN(
  ubcf_list, ibcf_list, user_meta,
  country_pop_list, month_pop_list,
  n = 5, w_ubcf = 0.2, w_ibcf = 0.5,
  w_country = 0.2, w_month = 0.1
)

precision_5 <- precision_at_5(topN_5, actual_items, n = 5)
recall_5 <- recall_at_5(topN_5, actual_items)

print(paste("Full Hybrid (4-signal) Precision@5:", round(precision_5, 4)))
print(paste("Full Hybrid (4-signal) Recall@5:", round(recall_5, 4)))
