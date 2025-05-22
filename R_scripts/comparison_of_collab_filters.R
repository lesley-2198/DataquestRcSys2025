library (recommenderlab)

# Re-run UBCF predictions using the same eval_scheme
ubcf_results <- evaluate(
  x = eval_scheme,
  method = "UBCF",
  parameter = list(method = "Cosine", nn = 30)
)


# Summarize UBCF
ubcf_summary <- avg(ubcf_results)

# Summarize IBCF
ibcf_summary <- avg(ibcf_results)

# Print them
ubcf_summary
ibcf_summary
