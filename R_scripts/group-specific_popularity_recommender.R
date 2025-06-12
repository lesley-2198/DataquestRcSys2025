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

top_products <- clean_data %>%
  group_by(Description) %>%
  summarise(total_quantity = sum(Quantity), .groups = "drop") %>%
  arrange(desc(total_quantity)) %>%
  slice_head(n = 10) %>%
  pull(Description)


top_products_by_country <- popular_by_country %>%
  filter(Description %in% top_products)

top_countries <- clean_data %>%
  count(Country, sort = TRUE) %>%
  slice_head(n = 8) %>%
  pull(Country)

top_products_by_country <- top_products_by_country %>%
  filter(Country %in% top_countries)

ggplot(top_products_by_country, aes(x = reorder(Description, -total_quantity), y = total_quantity, fill = Country)) +
  geom_col(position = position_dodge(width = 0.9), width = 0.7)+
  labs(
    title = "Top 10 Global Products Across Countries",
    x = "Product",
    y = "Total Quantity Purchased"
  ) +
  scale_fill_brewer(palette = "Set2")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("visuals/top_products_grouped_by_country.png", width = 10, height = 6, dpi = 300)



# Plot top 5 products in a specific country
recommend_by_country("Spain", 10) %>%
  ggplot(aes(x = reorder(Description, total_quantity), y = total_quantity)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +
  labs(title = "Top 5 Products in United Kingdom",
       x = "Product", y = "Quantity Purchased")
