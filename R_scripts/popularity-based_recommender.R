# Top products by quantity purchased
top_products <- clean_data %>%
  group_by(Description) %>%
  summarise(total_quantity = sum(Quantity), .groups = "drop") %>%
  arrange(desc(total_quantity))


# Show top 10 product names
head(top_products, 10)


#Visualize top 10 products
top_products %>%
  slice_head(n = 10) %>%
  ggplot(aes(x = reorder(Description, total_quantity), y = total_quantity)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = total_quantity), hjust = -0.1, size = 3.5) +
  coord_flip() +
  theme_minimal() +
  labs(title = "Top 10 Most Popular Products",
       x = "Product Description", y = "Total Quantity Purchased") +
  ylim(0, max(top_products$total_quantity) * 1.15)  # Add space to fit labels

# Save graph as .png
ggsave("visuals/top_10_products.png", width = 12, height = 4)

recommend_popular_items <- function(n = 5) {
  top_products %>%
    slice_head(n = n) %>%
    select(Description, total_quantity)
}

# Example usage
recommend_popular_items(5)
