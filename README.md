# Stress-Level-Prediction-for-Engineering-Students


## 📖 **Project Overview**
This project aims to explore the factors contributing to stress levels in engineering students. Engineering programs are demanding, with long study hours, heavy workloads, and high-pressure exams. Our goal is to identify what stresses students the most and provide insights that could help reduce stress and improve student well-being.

---

## 🎯 **Motivation**
Engineering students face a unique set of challenges that can impact their mental and physical health. By understanding how factors like sleep quality, study habits, headaches, and extracurricular activities affect their stress levels, we hope to identify actionable patterns. The ultimate goal is to help institutions provide better support to students by improving time management, health, and overall academic experiences.

---

## 📊 **Data Description**
The dataset contains various factors that may influence student stress levels:
- **Sleep Quality** (1 = Poor, 5 = Excellent) – Categorical
- **Headaches** (Frequency per week) – Continuous
- **Academic Performance** (1 = Poor, 5 = Excellent) – Categorical
- **Study Load** (1 = Very Light, 5 = Very Heavy) – Categorical
- **Extracurricular Activities** (Number of times per week) – Continuous
- **Stress Levels** (1 = Very Low, 5 = Very High) – Categorical

---

## 🔎 **Exploratory Data Analysis (EDA)**
Through EDA, we analyzed the relationships between stress levels and various factors:
- **Useful Variables:** Sleep quality and study load were identified as key indicators of stress.
- **Outliers:** Only one outlier was found in the academic performance variable.
- **Assumptions:** We assumed linear relationships and normal distribution of residuals. Scatter plots and component plots were used to check these assumptions.
- **Interaction Terms:** We explored the interaction between study load and sleep quality, which showed a significant effect on stress levels.

---

## 🧠 **Key Findings**
- **Sleep Quality** and **Study Load** are strong predictors of stress.
- **Headaches** and **Extracurricular Activities** also play a significant role in stress levels, especially when considering interactions between variables.
- Our regression models with interaction terms showed that combining **headaches** and **extracurricular activities** has a strong impact on stress.

---

## 🛠 **Technologies Used**
- **Languages:** R
- **Libraries/Packages:** `ggplot2`, `dplyr`, `lm`
- **Tools:** GitHub, Googledoc


---

## 💼 **Team Members**
- **Alexandra Ramlogan Salgado** – 50% of the work
- **Munchootsorn Wangsriviroj** – 50% of the work

---

## 📚 **Work Cited**
- Bhansali, Samyak. “Student Stress Factors.” Kaggle, 2024, [Link to Dataset](https://www.kaggle.com/datasets/samyakb/student-stress-factors/data). Accessed 24 October 2024.

---

## 📬 **Let's Connect**
- [LinkedIn - Munchootsorn Wangsriviroj](https://www.linkedin.com/in/munchootsorn/)
