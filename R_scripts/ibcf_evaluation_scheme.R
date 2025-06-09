# Convert to matrix and set rownames
item_matrix <- as.matrix(user_item_matrix[,-1])  # Remove CustomerID column
rownames(item_matrix) <- user_item_matrix$CustomerID

# Convert to binaryRatingMatrix for implicit data
binary_matrix <- as(item_matrix, "binaryRatingMatrix")


eval_scheme <- evaluationScheme(
  binary_matrix,
  method = "split",
  train = 0.8,
  given = -1,         # Use all known interactions in test users
  goodRating = 1      # Define positive interaction
)



ibcf_model <- Recommender(
  getData(eval_scheme, "train"),
  method = "IBCF",
  parameter = list(method = "Cosine", k = 30)  # k = number of neighbors
)

ibcf_predictions <- predict(
  ibcf_model,
  getData(eval_scheme, "known"),
  type = "topNList",
  n = 5
)


ibcf_eval_results <- evaluate(
  eval_scheme,
  method = "IBCF",
  type = "topNList",
  n = c(1, 3, 5, 10)
)


ibcf_summary <- avg(ibcf_eval_results)
print(ibcf_summary)


plot(ibcf_eval_results, annotate = TRUE, legend = "topright")
