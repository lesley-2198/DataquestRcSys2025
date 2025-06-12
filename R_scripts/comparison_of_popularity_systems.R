library(ggplot2)
library(dplyr)
library(tidyr)

# Original scores (in decimal form)
popularity_results <- data.frame(
  Model = c("Global", "Country-Based", "Country + Month"),
  Precision_at_5 = c(0.0021, 0.0005, 0.0035),
  Recall_at_5 = c(0.0106, 0.0024, 0.0177)
)

# Convert scores to percentages
popularity_results <- popularity_results %>%
  mutate(across(c(Precision_at_5, Recall_at_5), ~ . * 100))

# Reshape for grouped bar chart
popularity_long <- popularity_results %>%
  pivot_longer(cols = c(Precision_at_5, Recall_at_5),
               names_to = "Metric", values_to = "Score")

# Create the grouped bar chart
ggplot(popularity_long, aes(x = Model, y = Score, fill = Metric)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6) +
  geom_text(aes(label = paste0(round(Score, 2), "%")),
            position = position_dodge(width = 0.7),
            vjust = -0.4, size = 4.2) +
  labs(
    title = "Precision@5 and Recall@5 for Popularity-Based Recommenders",
    x = "Recommender Model", y = "Score (%)"
  ) +
  scale_fill_manual(values = c("#0072B2", "#E69F00"),
                    labels = c("Precision@5", "Recall@5")) +
  theme_minimal() +
  theme(legend.title = element_blank())

ggsave("visuals/popularity_model_comparison_percent_clean.png", width = 9, height = 6, dpi = 300)
