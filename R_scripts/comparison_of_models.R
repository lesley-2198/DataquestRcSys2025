# Data
model_performance <- data.frame(
  Model = c(
    "Global Popularity", "Country Popularity", "Month+Country",
    "UBCF", "IBCF", "Simple Hybrid", "Weighted Hybrid", "Full Hybrid"
  ),
  Precision = c(0.0021, 0.0005, 0.0035, 0.0014, 0.022, 0.0482, 0.0195, 0.0195),
  Recall = c(0.0106, 0.0024, 0.0177, 0.0071, 0.109, 0.0482, 0.0976, 0.0976)
)

# Convert to long format
plot_data <- pivot_longer(model_performance, cols = c("Precision", "Recall"), names_to = "Metric", values_to = "Score")

# Plot
ggplot(plot_data, aes(x = reorder(Model, -Score), y = Score, fill = Metric)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.7), width = 0.65) +
  geom_text(aes(label = scales::percent(Score, accuracy = 0.1)), 
            position = position_dodge(width = 0.7), vjust = -0.4, size = 3) +
  scale_fill_manual(values = c("Precision" = "#0073C2", "Recall" = "#EFC000")) +
  labs(
    title = "Precision@5 and Recall@5 Comparison Across Recommender Models",
    x = "Recommender Model",
    y = "Score (as %)",
    fill = "Metric"
  ) +
  theme_minimal(base_size = 11) +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))

ggsave("visuals/all_model_comparison.png", width = 15, height = 5, dpi = 300)
