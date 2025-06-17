ubcf_summary <- avg(ubcf_eval_results)
ibcf_summary <- avg(ibcf_eval_results)

# Extract row where n == 10
ubcf_at_10 <- ubcf_summary[ubcf_summary[, "n"] == 10, ]
ibcf_at_10 <- ibcf_summary[ibcf_summary[, "n"] == 10, ]

# Sample structure
ubcf_at_10["precision"]
ubcf_at_10["recall"]

ibcf_at_10["precision"]
ibcf_at_10["recall"]
