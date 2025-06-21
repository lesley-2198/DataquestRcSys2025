# 1. Predict top-10 items using both models
ubcf_topN <- predict(ubcf_model, getData(eval_scheme, "known"), type = "topNList", n = 10)
ibcf_topN <- predict(ibcf_model, getData(eval_scheme, "known"), type = "topNList", n = 10)

# 2. Convert to list format
ubcf_list <- as(ubcf_topN, "list")
ibcf_list <- as(ibcf_topN, "list")

# 3. Build weighted hybrid recommender (e.g., 70% IBCF, 30% UBCF)
get_weighted_hybrid_topN <- function(ubcf_list, ibcf_list, n = 5, w_ubcf = 0.3, w_ibcf = 0.7) {
  user_ids <- intersect(names(ubcf_list), names(ibcf_list))
  sapply(user_ids, function(user) {
    combined <- c(
      rep(ubcf_list[[user]], each = round(10 * w_ubcf)),  # UBCF votes
      rep(ibcf_list[[user]], each = round(10 * w_ibcf))   # IBCF votes
    )
    ranked <- sort(table(combined), decreasing = TRUE)
    names(ranked)[1:n]
  })
}

# 4. Generate top-5 weighted hybrid recommendations
topN_5 <- get_weighted_hybrid_topN(ubcf_list, ibcf_list, n = 5, w_ubcf = 0.3, w_ibcf = 0.7)

# 5. Evaluate against actual test data
actual_items <- as(getData(eval_scheme, "unknown"), "matrix")

# Precision@5
precision_at_5 <- function(predicted, actual, n = 5) {
  precisions <- sapply(1:ncol(predicted), function(i) {
    pred_items <- predicted[, i]
    actual_items_user <- names(which(actual[i, ] > 0))
    if (length(actual_items_user) == 0) return(NA)
    hits <- sum(pred_items %in% actual_items_user)
    return(hits / n)
  })
  mean(precisions, na.rm = TRUE)
}

# Recall@5
recall_at_5 <- function(predicted, actual) {
  recalls <- sapply(1:ncol(predicted), function(i) {
    pred_items <- predicted[, i]
    actual_items_user <- names(which(actual[i, ] > 0))
    if (length(actual_items_user) == 0) return(NA)
    hits <- sum(pred_items %in% actual_items_user)
    return(hits / length(actual_items_user))
  })
  mean(recalls, na.rm = TRUE)
}

# 6. Run evaluation
precision_5 <- precision_at_5(topN_5, actual_items, n = 5)
recall_5 <- recall_at_5(topN_5, actual_items)

print(paste("Weighted Hybrid Precision@5:", round(precision_5, 4)))
print(paste("Weighted Hybrid Recall@5:", round(recall_5, 4)))

#Get graph visualizing the impact of weighting on hybrid recommender performance 
# Create a dataframe for the two models
hybrid_comparison <- data.frame(
  Model = rep(c("Hybrid", "Weighted Hybrid"), each = 2),
  Metric = rep(c("Precision@5", "Recall@5"), times = 2),
  Value = c(0.0068, 0.0341, 0.0153, 0.0765)
)

# Convert percentages for labels
hybrid_comparison$Label <- paste0(round(hybrid_comparison$Value * 100, 2), "%")

# Plot grouped bar chart
ggplot(hybrid_comparison, aes(x = Metric, y = Value, fill = Model)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6) +
  geom_text(aes(label = Label),
            position = position_dodge(width = 0.7),
            vjust = -0.5, size = 4) +
  scale_fill_manual(values = c("#7aa6c2", "#f4a261")) +
  labs(
    title = "Performance Comparison: Hybrid vs Weighted Hybrid Recommender",
    y = "Score",
    x = "Metric",
    fill = "Model"
  ) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  theme_minimal(base_size = 13)

ggsave("visuals/hybrid_model_comparison_percent_clean.png", width = 10, height = 5, dpi = 300)
