# UBCF evaluation (explicitly rerun or extract from combined)
ubcf_eval_results <- evaluate(
  x = eval_scheme,
  method = "UBCF",
  parameter = list(method = "Cosine", nn = 30),
  type = "topNList",
  n = c(1, 3, 5, 10)
)

# Combined comparison of UBCF and IBCF
comparison_results <- evaluate(
  x = eval_scheme,
  method = list(
    "User-Based CF" = list(name = "UBCF", param = list(method = "Cosine", nn = 30)),
    "Item-Based CF" = list(name = "IBCF", param = list(method = "Cosine", k = 30))
  ),
  type = "topNList",
  n = c(1, 3, 5, 10)
)

# Extract and summarize
ubcf_summary <- avg(ubcf_eval_results)
ibcf_summary <- avg(comparison_results[["Item-Based CF"]])

# Extract metrics for n = 5
ubcf_at_5 <- ubcf_summary[ubcf_summary[, "n"] == 5, ]
ibcf_at_5 <- ibcf_summary[ibcf_summary[, "n"] == 5, ]

# Combine into comparison data frame
comparison_df <- data.frame(
  Model = c("UBCF", "IBCF"),
  Precision_at_5 = c(ubcf_at_5["precision"], ibcf_at_5["precision"]),
  Recall_at_5 = c(ubcf_at_5["recall"], ibcf_at_5["recall"]),
  TPR_at_5 = c(ubcf_at_5["TPR"], ibcf_at_5["TPR"]),
  FPR_at_5 = c(ubcf_at_5["FPR"], ibcf_at_5["FPR"])
)

print(comparison_df)

# Optional: View average metrics
avg_comparison <- lapply(comparison_results, avg)
avg_comparison
