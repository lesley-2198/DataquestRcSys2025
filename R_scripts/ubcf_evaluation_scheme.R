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


print(item_matrix)
