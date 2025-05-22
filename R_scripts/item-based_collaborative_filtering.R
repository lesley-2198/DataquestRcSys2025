library(recommenderlab)

# Convert the item matrix to realRatingMatrix (required for recommenderlab)
rating_matrix <- as(item_matrix, "realRatingMatrix")

# 80% for training, 20% for testing
ibcf_eval_scheme <- evaluationScheme(rating_matrix, method = "split", train = 0.8, given = -1, goodRating = 1)

# Build item-based recommender
ibcf_model <- Recommender(getData(ibcf_eval_scheme, "train"), method = "IBCF", parameter = list(k = 30))

# Make predictions on the test set
ibcf_predictions <- predict(ibcf_model, getData(ibcf_eval_scheme, "known"), type = "topNList", n = 5)

# Evaluate the recommender model using precision/recall
ibcf_results <- evaluate(ibcf_eval_scheme, method = "IBCF", n = c(1, 3, 5, 10))

# Plot ROC curve
plot(ibcf_results, annotate = TRUE)
