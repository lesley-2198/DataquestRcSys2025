library (recommenderlab)

# Re-run UBCF predictions using the same eval_scheme
ubcf_results <- evaluate(
  x = eval_scheme,
  method = "UBCF",
  parameter = list(method = "Cosine", nn = 30)
)

# Combine evaluation results
comparison_results <- evaluate(
  x = eval_scheme,
  method = list(
    "User-Based CF" = list(name = "UBCF", param = list(method = "Cosine", nn = 30)),
    "Item-Based CF" = list(name = "IBCF", param = list(method = "Cosine", k = 30))
  ),
  n = c(1, 3, 5, 10)
)

# Get values from the row where n == 5
ubcf_at_5 <- ubcf_summary[ubcf_summary[, "n"] == 5, ]
ibcf_at_5 <- ibcf_summary[ibcf_summary[, "n"] == 5, ]

# Combine into a comparison data frame
comparison_df <- data.frame(
  Model = c("UBCF", "IBCF"),
  Precision_at_5 = c(ubcf_at_5["precision"], ibcf_at_5["precision"]),
  Recall_at_5 = c(ubcf_at_5["recall"], ibcf_at_5["recall"]),
  TPR_at_5 = c(ubcf_at_5["TPR"], ibcf_at_5["TPR"]),
  FPR_at_5 = c(ubcf_at_5["FPR"], ibcf_at_5["FPR"])
)

print(comparison_df)


# Generate summary stats
avg_comparison <- lapply(comparison_results, avg)
avg_comparison


