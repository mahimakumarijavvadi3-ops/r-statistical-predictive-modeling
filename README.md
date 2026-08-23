# Statistical Analysis and Predictive Modeling using R

## Project Title
**Advertising Sales Prediction using Statistical Analysis and Multiple Linear Regression**

## Objective
This project performs exploratory statistical analysis and builds a predictive model in R using the publicly available **Advertising** dataset. The aim is to understand how advertising expenditure on TV, radio, and newspaper is related to product sales and to build a model that can predict sales.

## Dataset
The dataset contains 200 observations with these variables:

- `TV` – advertising budget spent on TV
- `Radio` – advertising budget spent on radio
- `Newspaper` – advertising budget spent on newspaper
- `Sales` – product sales

The dataset is available through the `ISLR2` R package and is commonly used for learning regression and statistical analysis.

## Analysis Performed
1. Data inspection and summary statistics
2. Missing-value checking
3. Distribution analysis
4. Correlation analysis
5. Hypothesis testing
6. Multiple linear regression
7. 5-fold cross-validation
8. Model performance evaluation using RMSE and R-squared
9. Residual and diagnostic analysis
10. Interpretation and possible improvements

## Main Hypotheses
**H0:** Advertising expenditure has no statistically significant relationship with sales.

**H1:** At least one advertising channel has a statistically significant relationship with sales.

## How to Run
Open `analysis.R` in RStudio and run the script from top to bottom.

The script installs/loads the required packages and creates the plots and model results automatically.

## Repository Structure
```text
r-statistical-predictive-modeling/
├── README.md
├── analysis.R
├── report_notes.md
└── .gitignore
```

## Expected Outcome
The analysis identifies which advertising channels are useful predictors of sales and evaluates how well a multiple linear regression model performs on unseen data.

## Skills Demonstrated
R, descriptive statistics, hypothesis testing, correlation, linear regression, cross-validation, model evaluation, data visualization, and model diagnostics.
