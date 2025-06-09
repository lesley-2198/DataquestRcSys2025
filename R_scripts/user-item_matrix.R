# Summarize total quantity per customer-item pair
customer_item <- clean_data %>%
  group_by(CustomerID, Description) %>%
  summarise(total_quantity = sum(Quantity), .groups = "drop")


# Create a customer-item matrix (wide format)
user_item_matrix <- customer_item %>%
  pivot_wider(names_from = Description, values_from = total_quantity, values_fill = 0)

write_csv(user_item_matrix, "C:\Users\lesle\source\repos\DataquestRcSys2025\cleaned_data\user_item_matrix.csv")
