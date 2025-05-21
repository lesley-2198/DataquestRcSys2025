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
├── python_scripts/            # Python scripts
├── raw_data.csv               # datasets
├── R_scripts/                 # R and Python scripts
├── visuals/                   # R scripts
├── README.md                  # Project documentation
└── .gitignore                 # Git tracking exclusions
```

---

## ✅ Completed Milestones

- ✅ **Data cleaning** using R (missing values, returns, invalid prices)
- ✅ **Exploratory Data Analysis** (top products, top customers, quantity distributions)
- ✅ **Popularity-based recommendation** (global and group-specific)
- ✅ **User-based Collaborative Filtering** (UBCF) using R's `recommenderlab`

---

## 🔜 Upcoming Tasks

- [ ] Evaluate UBCF recommender (precision, recall)
- [ ] Implement Item-Based Collaborative Filtering (IBCF)
- [ ] Build hybrid recommender systems (R + Python)
- [ ] Incorporate Python logic (matrix factorization or ensemble logic)
- [ ] Visualize performance comparisons
- [ ] Prepare presentation materials

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
