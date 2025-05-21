install.packages("recommenderlab")
library(recommenderlab)
library(tidyverse)

# Remove CustomerID column and convert to matrix
item_matrix <- as.matrix(user_item_matrix[,-1])
rownames(item_matrix) <- user_item_matrix$CustomerID

# Convert to recommenderlab format
rating_matrix <- as(item_matrix, "realRatingMatrix")

# Build a recommender model using user-based collaborative filtering
ubcf_model <- Recommender(rating_matrix, method = "UBCF")

# Get top 5 recommendations for first 5 users
recommended <- predict(ubcf_model, rating_matrix[1:5], n = 5)

# View recommendations
as(recommended, "list")

