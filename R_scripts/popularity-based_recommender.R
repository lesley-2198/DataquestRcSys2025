library(tidyverse)

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
  coord_flip() +
  labs(title = "Top 10 Most Popular Products",
       x = "Product Description", y = "Total Quantity Purchased")


recommend_popular_items <- function(n = 5) {
  top_products %>%
    slice_head(n = n) %>%
    select(Description, total_quantity)
}

# Example usage
recommend_popular_items(5)
