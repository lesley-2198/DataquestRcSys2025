actual_matrix <- as(getData(eval_scheme, "unknown"), "matrix")


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

# Precision@5 for per-user recommendations
precision_at_5 <- function(actual_matrix, recommendations_list) {
  precisions <- sapply(1:nrow(actual_matrix), function(i) {
    actual_items <- names(which(actual_matrix[i, ] > 0))
    recommended <- recommendations_list[[i]]
    if (length(actual_items) == 0 || all(is.na(recommended))) return(NA)
    hits <- sum(recommended %in% actual_items)
    return(hits / 5)
  })
  mean(precisions, na.rm = TRUE)
}

# Recall@5
recall_at_5 <- function(actual_matrix, recommendations_list) {
  recalls <- sapply(1:nrow(actual_matrix), function(i) {
    actual_items <- names(which(actual_matrix[i, ] > 0))
    recommended <- recommendations_list[[i]]
    if (length(actual_items) == 0 || all(is.na(recommended))) return(NA)
    hits <- sum(recommended %in% actual_items)
    return(hits / length(actual_items))
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
