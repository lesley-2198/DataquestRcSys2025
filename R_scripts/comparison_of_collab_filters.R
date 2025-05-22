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

comparison_df <- data.frame(
  Model = c("UBCF", "IBCF"),
  Precision_at_5 = c(ubcf_summary["precision", "5"], ibcf_summary["precision", "5"]),
  Recall_at_5 = c(ubcf_summary["recall", "5"], ibcf_summary["recall", "5"]),
  TPR_at_5 = c(ubcf_summary["TPR", "5"], ibcf_summary["TPR", "5"]),
  FPR_at_5 = c(ubcf_summary["FPR", "5"], ibcf_summary["FPR", "5"])
)


# Generate summary stats
avg_comparison <- lapply(comparison_results, avg)
avg_comparison


