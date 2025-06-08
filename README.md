# 🧠 Recommender Systems Project – Dataquest 2025 Challenge

Welcome to the **Recommender Systems** project for the **Dataquest 2025 Challenge**. This project focuses on exploring different recommendation techniques to suggest relevant products to users based on historical retail transaction data.

---

## 📦 Tools & Technologies

| Tool             | Purpose |
|------------------|---------|
| **R & RStudio**  | Data cleaning, wrangling, modeling, visualization |
| **Python & VS Code** | Future integration for hybrid modeling & evaluation |
| **Excel**        | Optional visualization support |
| **PowerPoint**   | Final presentation and storytelling |

---

## 🗂️ Project Structure

```
├── DataquestRcSys2025.Rproj   # R project file
├── cleaned_data/              # Cleaned datasets
├── raw_data                   # datasets
├── R_scripts/                 # R scripts
├── visuals/                   # Charts, evaluation plots
├── README.md                  # Project documentation
└── .gitignore                 # Git tracking exclusions
```

---

## 📁 Key Folders & Contents

### 🔹 `cleaned_data/`
| File                     | Description |
|--------------------------|-------------|
| `clean_data.xlsx`        | Full cleaned dataset used for all modeling |
| `customer_item.xlsx`     | User-item purchase matrix |
| `user_item_matrix.xlsx`  | Binary matrix for collaborative filtering |
| `popular_by_country.xlsx`| Top items per country (group-specific popularity) |
| `top_products.xlsx`      | Overall top purchased products |

---

### 🔹 `R_scripts/`
| Script File                                | Description |
|--------------------------------------------|-------------|
| `data_analysis1.R`                         | Initial EDA and quantity distribution |
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

- ✅ **Data cleaning** using R (missing values, returns, invalid prices)  
- ✅ **Exploratory Data Analysis** (top products, top customers, quantity distributions)  
- ✅ **Popularity-based recommendation** (global and group-specific)  
- ✅ **Implemented User-based Collaborative Filtering** (UBCF) using R's `recommenderlab`  
- ✅ **Evaluated UBCF recommender** (precision, recall)  
- ✅ **Implemented Item-Based Collaborative Filtering** (IBCF) using R's `recommenderlab`  
- ✅ **Evaluated IBCF recommender** (precision, recall)  
- ✅ **Compared UBCF vs IBCF performance** (side-by-side analysis)  
- ✅ **Built baseline Hybrid recommender system** (merged top-N lists from UBCF + IBCF)  
- ✅ **Adjusted hybrid voting mechanism based on evaluation performance** (Item-Based CF 70–80% weighted)  
- ✅ **Integrated group-based popularity signals** (by country and season/month) into hybrid recommender  
- ✅ **Finalized 4-signal hybrid recommender** (UBCF + IBCF + regional popularity + seasonal popularity) achieving **Precision@5 = 0.0181**, **Recall@5 = 0.0906**

---

## 📌 Finalization Tasks

- [ ] Visualize and compare performance of all models (bar charts or tables)
- [ ] Interpret results and explain improvements from each technique
- [ ] Prepare final presentation materials (slides, charts, notes)
- [ ] (Later) Explore matrix factorization or model stacking in Python

---
## 📊 Model Performance (Precision@5 & Recall@5)

| Model                        | Precision@5 | Recall@5  |
|------------------------------|-------------|-----------|
| User-Based CF (UBCF)         | 0.0014      | 0.0071    |
| Item-Based CF (IBCF)         | 0.0167      | 0.0835    |
| Hybrid (UBCF + IBCF, 70/30)  | 0.0167      | 0.0835    |
| Hybrid + Group Popularity    | **0.0181**  | **0.0906** |

---

## 📁 .gitignore Description

The `.gitignore` file ensures that unnecessary or sensitive files are not tracked in version control.  
It currently excludes:

```gitignore
# R session files
.Rhistory
.Rproj.user/

# Project-specific history files
raw_data/.Rhistory
cleaned_data/.Rhistory
```
---

## 📌 Notes

This README will be updated as the project progresses.
The core R-based recommender system is now complete. The current focus is on interpreting results, visualizing model comparisons, and preparing clear documentation. Python integration (matrix factorization or stacking) will be explored later as an extension for deeper personalization.

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

### 📂 Dataset Access

The dataset used in this project was provided as part of the challenge. A similar open retail dataset can be found here:  
🔗 [Online Retail II Dataset – UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Online+Retail+II)
