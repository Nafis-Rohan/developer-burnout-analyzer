# 🔥 Developer Burnout Analyzer

A data analysis project exploring burnout patterns among developers
using Stack Overflow Survey data, PostgreSQL, and Metabase.

## 📊 Dashboard Preview
[Add screenshot of your Metabase dashboard here]

## 🛠️ Tools Used
- **Python (Pandas, NumPy)** — data cleaning and preprocessing
- **PostgreSQL** — data storage and SQL analysis
- **Metabase** — dashboard and visualization
- **Stack Overflow Survey 2024** — dataset

## 🧹 Data Cleaning Process
Raw Stack Overflow survey data required significant preprocessing before analysis:

1. **Column Selection** — filtered down to 22 relevant columns from 300+
2. **Target Metric Cleaning** — dropped rows with null `JobSat` (our core metric)
3. **Type Fixing** — converted messy text-numbers like `"Less than 1 year"` → `0.5` and `"More than 50 years"` → `51` in `WorkExp`, `YearsCode`, `ToolCountWork`, `ToolCountPersonal`
4. **Missing Value Imputation**:
   - Numeric columns → filled with **median** (safe against outliers)
   - Categorical columns → filled with **"Not Specified"** (preserves rows)
5. **Outlier Removal** — capped `ConvertedCompYearly` at 98th percentile to remove troll salaries like $99M

**Result:** Clean, analysis-ready dataset saved as `master_burnout_data.csv`

## 🧠 Burnout Score Formula
A composite burnout score was engineered from 5 signals:

| Signal | Logic |
|---|---|
| Job Satisfaction | `10 - jobsat` (low sat = high burnout) |
| AI Frustration | Count of frustrations mentioned |
| AI Threat | Yes=2, Not sure=1, No=0 |
| AI Sentiment | Very unfavorable=3, Unfavorable=2, Indifferent=1 |
| AI Complexity | Very poor=3, Bad=2, Neither=1 |

## 🔍 Key Findings

### 1. Remote Work
- Hybrid (in-person leaning) workers burn out most **(6.73)**
- Fully remote workers burn out least **(6.55)**
- Insight: It's about **control over where you work**, not remote itself

### 2. Org Size
- Large companies (10k+) have highest burnout **(6.87)**
- Freelancers have lowest burnout **(6.00)**
- Insight: Bigger bureaucracy = more burnout

### 3. IC vs Manager
- Individual Contributors burn out more **(6.72)** than Managers **(5.88)**
- Insight: Developers feel more AI threat to their roles than managers

### 4. Salary
- Mid-range earners ($30K–$70K) burn out most **(6.87)**
- Insight: Money helps but doesn't eliminate burnout

### 5. Country
- Slovenia **(7.48)** and Germany **(7.29)** top the burnout chart
- Western European developers show higher burnout despite better conditions

### 6. Industry
- Media & Advertising **(7.09)** and Insurance **(6.89)** most burned out
- Energy **(6.30)** and Computer Systems Design **(6.24)** least burned out

### 7. Work Experience
- Early career (1–3 years) burns out most — AI anxiety and imposter syndrome
- Burnout steadily increases after 35+ years experience

## 📁 Project Structure
burnout-analyzer/
├── burnout.ipynb
├── sql/
│   ├── create_view.sql
│   └── analysis_queries.sql
└── README.md

## 🗄️ SQL Files
All queries are in the `/sql` folder including:
- Burnout score view creation
- Analysis queries for all 7 dimensions
