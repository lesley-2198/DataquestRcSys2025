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
.
├── cleaned_data/              # Cleaned datasets
├── raw_data                   # datasets
├── R_scripts/                 # R scripts
├── visuals/                   # R scripts
├── README.md                  # Project documentation
└── .gitignore                 # Git tracking exclusions
```

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

## 🔜 Upcoming Tasks
  
- [ ] Visualize performance comparisons  
- [ ] Prepare presentation materials
- [ ] Incorporate Python logic (matrix factorization or ensemble logic) for more precision, personalization and personal skill development & tech 

---

## 📁 .gitignore Example

Typical `.gitignore` contents:

```

# R temporary files
*.RData
.Rhistory
.Rproj.user/

# Python cache
__pycache__/
.ipynb_checkpoints/

# Output files
cleaned_data/*.csv
```

---

## 📌 Notes

This README will be updated as the project progresses. The current focus is on refining R-based models before moving into hybrid solutions using Python.

---

## 📚 References

- [`recommenderlab` CRAN package](https://cran.r-project.org/web/packages/recommenderlab/)
- Dataquest 2025 Challenge materials
