# 1. Generate top-N predictions from UBCF and IBCF
ubcf_model <- Recommender(getData(eval_scheme, "train"), method = "UBCF", parameter = list(method = "Cosine", nn = 30))
ibcf_model <- Recommender(getData(eval_scheme, "train"), method = "IBCF", parameter = list(method = "Cosine", k = 30))

# Predict top-10 items per user using both models
ubcf_topN <- predict(ubcf_model, getData(eval_scheme, "known"), type = "topNList", n = 10)
ibcf_topN <- predict(ibcf_model, getData(eval_scheme, "known"), type = "topNList", n = 10)

# 2. Convert to lists of recommendations per user
ubcf_list <- as(ubcf_topN, "list")
ibcf_list <- as(ibcf_topN, "list")

# 3. Merge recommendations using a simple majority vote (hybrid approach)
get_hybrid_topN <- function(ubcf_list, ibcf_list, n = 5) {
  user_ids <- intersect(names(ubcf_list), names(ibcf_list))
  sapply(user_ids, function(user) {
    combined <- c(ubcf_list[[user]], ibcf_list[[user]])
    hybrid <- sort(table(combined), decreasing = TRUE)
    names(hybrid)[1:n]
  })
}

# Generate hybrid top-5 recommendations for each user
topN_5 <- get_hybrid_topN(ubcf_list, ibcf_list, n = 5)

# 4. Evaluation Setup

# Extract ground truth: actual items each user interacted with (in the test set)
actual_items <- as(getData(eval_scheme, "unknown"), "matrix")

# Define function to calculate precision@5
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

# Define function to calculate recall@5
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

# 5. Evaluate hybrid model performance
precision_5 <- precision_at_5(topN_5, actual_items, n = 5)
recall_5 <- recall_at_5(topN_5, actual_items)

# 6. Display evaluation results
print(paste("Hybrid Precision@5:", round(precision_5, 4)))
print(paste("Hybrid Recall@5:", round(recall_5, 4)))
