actual_matrix <- as(getData(eval_scheme, "unknown"), "matrix")
# Convert list to matrix
pred_matrix <- do.call(rbind, user_country_month_recs)
pred_matrix <- t(pred_matrix)  # Now it's [items x users]

# Country-specific top 5 items for each user
user_country_recs <- sapply(rownames(actual_matrix), function(user_id) {
  user_info <- user_meta[user_meta$CustomerID == as.numeric(user_id), ]
  if (nrow(user_info) == 0 || is.null(country_pop_list[[user_info$Country]])) return(NA)
  return(country_pop_list[[user_info$Country]][1:5])
})

# Country + Month-Based
user_country_month_recs <- sapply(rownames(actual_matrix), function(user_id) {
  user_info <- user_meta[user_meta$CustomerID == as.numeric(user_id), ]
  if (nrow(user_info) == 0) return(NA)
  
  country_items <- country_pop_list[[user_info$Country]]
  month_items <- month_pop_list[[as.character(user_info$Month)]]
  
  if (is.null(country_items) || is.null(month_items)) return(NA)
  
  # Combine and get top 5 via voting (simple union here)
  combined <- c(country_items, month_items)
  top_items <- sort(table(combined), decreasing = TRUE)
  return(names(top_items)[1:5])
})

# Precision@n for per-user recommendations
precision_at_n <- function(predicted, actual, n = 5) {
  precisions <- sapply(1:ncol(predicted), function(i) {
    pred_items <- predicted[, i]
    actual_items_user <- names(which(actual[i, ] > 0))
    if (length(actual_items_user) == 0 || all(is.na(pred_items))) return(NA)
    hits <- sum(pred_items %in% actual_items_user)
    return(hits / n)
  })
  mean(precisions, na.rm = TRUE)
}

# Recall@n
recall_at_n <- function(predicted, actual, n = 5) {
  recalls <- sapply(1:ncol(predicted), function(i) {
    pred_items <- predicted[, i]
    actual_items_user <- names(which(actual[i, ] > 0))
    if (length(actual_items_user) == 0 || all(is.na(pred_items))) return(NA)
    hits <- sum(pred_items %in% actual_items_user)
    return(hits / length(actual_items_user))
  })
  mean(recalls, na.rm = TRUE)
}

# COUNTRY-BASED
country_precision_5 <- precision_at_5(actual_matrix, user_country_recs)
country_recall_5 <- recall_at_5(actual_matrix, user_country_recs)

print(paste("Country-Based Precision@5:", round(country_precision_5, 4)))
print(paste("Country-Based Recall@5:", round(country_recall_5, 4)))

# COUNTRY + MONTH
country_month_precision_5 <- precision_at_5(actual_matrix, user_country_month_recs)
country_month_recall_5 <- recall_at_5(actual_matrix, user_country_month_recs)

print(paste("Country + Month-Based Precision@5:", round(country_month_precision_5, 4)))
print(paste("Country + Month-Based Recall@5:", round(country_month_recall_5, 4)))

# COUNTRY + MONTH @10
country_month_precision_10 <- precision_at_n(pred_matrix, actual_matrix, n = 10)
country_month_recall_10 <- recall_at_n(pred_matrix, actual_matrix, n = 10)

print(paste("Country + Month-Based Precision@10:", round(country_month_precision_10, 4)))
print(paste("Country + Month-Based Recall@10:", round(country_month_recall_10, 4)))
