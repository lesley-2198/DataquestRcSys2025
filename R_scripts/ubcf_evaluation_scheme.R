# Remove CustomerID column and convert to matrix
item_matrix <- as.matrix(user_item_matrix[,-1])
rownames(item_matrix) <- user_item_matrix$CustomerID

# Convert the item matrix to a binaryRatingMatrix (since we’re dealing with implicit data)
binary_matrix <- as(item_matrix, "binaryRatingMatrix")

# Create evaluation scheme: 80% train, 20% test
eval_scheme <- evaluationScheme(binary_matrix, method = "split", train = 0.8, given = -1, goodRating = 1)

#Train the model on the training set
ubcf_model <- Recommender(getData(eval_scheme, "train"), method = "UBCF")

#Make predictions on the test set
ubcf_predictions <- predict(ubcf_model, getData(eval_scheme, "known"), type = "topNList", n = 5)

#Evaluate the predictions
ubcf_eval_results <- evaluate(eval_scheme, method = "UBCF", type = "topNList", n = c(1, 3, 5, 10))

# View summary of evaluation (precision, recall, etc.)
avg(ubcf_eval_results)

# Optional: plot the results
plot(ubcf_eval_results, annotate = TRUE, legend = "topleft")

# Compute user-user similarity matrix (Cosine method)
user_sim_matrix <- similarity(binary_matrix, method = "cosine", which = "users")

# Convert to numeric vector (removing self-similarity = 1)
user_sim_values <- as.vector(user_sim_matrix)
user_sim_values <- user_sim_values[user_sim_values < 1]

# Histogram
ubcf_hist <- ggplot(data.frame(similarity = user_sim_values), aes(x = similarity)) +
  geom_histogram(bins = 50, fill = "#0072B2", color = "white", alpha = 0.8) +
  theme_minimal() +
  labs(
    title = "User-User Similarity (UBCF) - Histogram",
    x = "Similarity Score",
    y = "Frequency"
  )

# Density plot
ubcf_density <- ggplot(data.frame(similarity = user_sim_values), aes(x = similarity)) +
  geom_density(color = "#0072B2", size = 1.2, fill = "#0072B2", alpha = 0.3) +
  theme_minimal() +
  labs(
    title = "User-User Similarity (UBCF) - Density Plot",
    x = "Similarity Score",
    y = "Density"
  )

ubcf_hist + ubcf_density
combined_ubcf_plot <- ubcf_hist + ubcf_density

ggsave("visuals/ubcf_user_similarity_distribution.png", width = 12, height = 4, dpi = 300)


# Create a simple data frame for UBCF performance
ubcf_results <- data.frame(
  Metric = c("Precision@5", "Recall@5"),
  Score = c(0.0014, 0.0071) * 100  # Convert to percentages if needed
)

# Bar chart
ggplot(ubcf_results, aes(x = Metric, y = Score, fill = Metric)) +
  geom_col(width = 0.5, show.legend = FALSE) +
  geom_text(aes(label = paste0(round(Score, 2), "%")),
            vjust = -0.3, size = 4.5, fontface = "bold") +
  scale_fill_manual(values = c("#0072B2", "#E69F00")) +
  labs(
    title = "UBCF Performance: Precision@5 and Recall@5",
    x = NULL, y = "Score (%)"
  ) +
  theme_minimal(base_size = 13)

ggsave("visuals/ubcf_precision_recall.png", width = 9, height = 6, dpi = 300)
