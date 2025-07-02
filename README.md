# 🧠 Recommender Systems Project – Dataquest 2025 Challenge

This project was developed for the **Dataquest 2025 Recommender Systems Challenge**. It explores various techniques for product recommendation—starting from simple popularity models and progressing to advanced hybrid systems that incorporate **user behavior, item relationships, regional patterns, and seasonal trends.**

---

## 📦 Tools & Technologies

| Tool             | Purpose |
|------------------|---------|
| **R & RStudio**  | Data processing, modeling, evaluation, and visualization |
| **README.md/MS Word** | Project documentation and interpretation |

---

## 🗂️ Project Structure

```
├── DataquestRcSys2025.Rproj     # R project file
├── raw_data/                    # Raw transaction data
├── cleaned_data/                # Cleaned datasets for modeling
├── R_scripts/                   # Modular R scripts for each model
├── visuals/                     # All plots and evaluation images
├── documentation/               # Final project report and analysis
├── README.md                    # Project summary
└── .gitignore                   # Excluded files from version control
```

---

## 📁 Key Folders & Contents

### 🔹 `cleaned_data/`
| File                     | Description |
|--------------------------|-------------|
| `clean_data.xlsx`        | Cleaned dataset used for modeling |
| `customer_item.xlsx`     | User-item purchase matrix |
| `user_item_matrix.xlsx`  | Binary matrix (for collaborative filtering) |
| `popular_by_country.xlsx`| Top items per country (group-specific popularity) |
| `top_products.xlsx`      | Globally most purchased products |

---

### 🔹 `R_scripts/`
| Script File                                | Description |
|--------------------------------------------|-------------|
| `main.R`                                   | Master script - runs full pipeline |
| `data_analysis1.R`                         | EDA and quantity distribution |
| `user_based_collaborative_filtering.R`     | UBCF implementation and evaluation |
| `item_based_collaborative_filtering.R`     | IBCF implementation and evaluation |
| `comparison_of_collab_filters.R`           | Side-by-side comparison of UBCF vs IBCF |
| `popularity_based_recommender.R`           | Global popularity recommendation logic |
| `group_specific_popularity_recommender.R`  | Country-specific popularity logic |
| `month_country_popularity_recommender.R`   | Seasonal + country popularity |
| `hybrid_via_score_averaging.R`             | Equal weight hybrid recommender |
| `hybrid_via_score_averaging_(weighted).R`  | Weighted score hybrid (70/30) |
| `full_weighted_hybrid_recommender.R`       | Final 4-signal hybrid (UBCF + IBCF + region + season) |
| `ubcf_evaluation_scheme.R`                 | UBCF performance evaluation |
| `ibcf_evaluation_scheme.R`                 | IBCF performance evaluation |

---

## ✅ Completed Milestones

- ✅ **Data cleaning:** removed nulls, returns,
- ✅ **EDA:** top products, top customers, quantity trends
- ✅ **Popularity models:** global, country, and seasonal logic
- ✅ **UBCF & IBCF:** implemented using recommenderlab, with evaluation
- ✅ **Performance analysis:** compared precision and recall metrics
- ✅ **Hybrid systems:** baseline merge, weighted hybrid, and full hybrid (4 signals)
- ✅ **Final model:** Weighted hybrid of UBCF + IBCF + country + month
- ✅ **Visualization:** graphs for similarity, performance, seasonal trends
- ✅ **Interpretation:** technical report explaining trade-offs and outcomes

---

## 📊 Model Performance (Precision@5 & Recall@5)

| Model                        | Precision@5 | Recall@5  |
|------------------------------|-------------|-----------|
| Global Popularity            | 0.0021      | 0.006     |
| Country-Based Popularity     | 0.0005      | 0.0024    |
| Month + Country Popularity   | 0.0035      | 0.0177    |
| User-Based CF (UBCF)         | 0.0014      | 0.0071    |
| Item-Based CF (IBCF)         | 0.0220      | 0.1090    |
| Hybrid (UBCF + IBCF, 70/30)  | 0.0195      | 0.098     |
| Hybrid + Group Popularity    | 0.0195      | 0.098     |
> 🔍 Although IBCF performed best in precision and recall, I preferred the full hybrid model for its contextual adaptability to seasonal and regional patterns—making it better suited for real-world deployment.
---

## 🔮 Future Work

- [ ] Introduce matrix factorization or model stacking (Python)
- [ ] Explore external visualization tools (Power BI, Tableau)
- [ ] Experiment with online/offline evaluation metrics (MAP@K, DCG)

---

## 📁 .gitignore Description

The `.gitignore` file excludes local environment files and history logs:

```gitignore
# R session files
.Rhistory
.Rproj.user/

# Project-specific history files
raw_data/.Rhistory
cleaned_data/.Rhistory
```
---

## 📚 References & Challenge Context

### 📘 Source

This project was developed as part of the **DataQuest 2025 Recommender Systems Challenge**, hosted by Bernard Spies of **nav.D2–Personalised Solutions**.

---

### 🧠 Context

> We aim to provide personalised offers across all interfaces to maximise the lifetime value of the relationship with all our customers.  
> Diverse, relevant and novel offers are part of a bigger customer journey that are personalised through context and executed across multiple interfaces.  
> Recommender System models are designed to solve this challenge well. Examples of other companies who do this well are the personalised recommendations from Amazon, Netflix and Spotify.

---

### ❓ Problem Statement

> The delivery of personalised offers should be prioritised and ranked based on customer needs derived through contextual data points.  
> To deliver the best possible customer experience, you need to develop a recommender system model, that can recommend the most relevant offers to each customer.

---

### ✅ Challenge Objectives

1. **Train** a recommender system machine learning model of your choice to solve this challenge, using the dataset provided.  
2. **Show accuracy and beyond-accuracy measures** to motivate why your model is expected to work well.  
3. **Describe additional considerations** expected if this system is used in a live/production environment.

---

### ✅ Status
✅ Project complete — documentation, modeling, and interpretation finalized.
Next steps will include optional enhancements in Python for deeper evaluation.

---

### 📂 Dataset Access

The dataset used in this project was provided as part of the challenge. A similar open retail dataset can be found here:  
🔗 [Online Retail II Dataset – UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Online+Retail+II)
