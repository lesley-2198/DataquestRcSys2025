
# Get Global Top 5 Products
global_top5 <- clean_data %>%
  group_by(Description) %>%
  summarise(total_quantity = sum(Quantity), .groups = "drop") %>%
  arrange(desc(total_quantity)) %>%
  slice_head(n = 5) %>%
  pull(Description)

# Get Binary Test Matrix
test_data <- getData(eval_scheme, "unknown")
actual_matrix <- as(test_data, "matrix")

# Function to compute precision@5 for each user
precision_global <- function(actual_matrix, recommended_items, n = 5) {
  precisions <- sapply(1:nrow(actual_matrix), function(i) {
    actual_items <- names(which(actual_matrix[i, ] > 0))
    if (length(actual_items) == 0) return(NA)
    hits <- sum(recommended_items %in% actual_items)
    return(hits / n)
  })
  mean(precisions, na.rm = TRUE)
}

# Run it
global_precision_5 <- precision_global(actual_matrix, global_top5, n = 5)
print(paste("Global Popularity Precision@5:", round(global_precision_5, 4)))

# Function to compute recall@5 for each user
recall_global <- function(actual_matrix, recommended_items) {
  recalls <- sapply(1:nrow(actual_matrix), function(i) {
    actual_items <- names(which(actual_matrix[i, ] > 0))
    if (length(actual_items) == 0) return(NA)
    hits <- sum(recommended_items %in% actual_items)
    return(hits / length(actual_items))
  })
  mean(recalls, na.rm = TRUE)
}

# Run it
global_recall_5 <- recall_global(actual_matrix, global_top5)
print(paste("Global Popularity Recall@5:", round(global_recall_5, 4)))
