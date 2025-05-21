# Top products by country
popular_by_country <- clean_data %>%
  group_by(Country, Description) %>%
  summarise(total_quantity = sum(Quantity), .groups = "drop") %>%
  arrange(Country, desc(total_quantity))


# Function to recommend top N popular items for a given country
recommend_by_country <- function(country_name, n = 5) {
  popular_by_country %>%
    filter(Country == country_name) %>%
    slice_head(n = n)
}


# Plot top 5 products in a specific country
recommend_by_country("United Kingdom", 5) %>%
  ggplot(aes(x = reorder(Description, total_quantity), y = total_quantity)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +
  labs(title = "Top 5 Products in United Kingdom",
       x = "Product", y = "Quantity Purchased")
