# Report Notes

## 1. Introduction
The purpose of this project is to perform statistical analysis and predictive modeling using R. The Advertising dataset was selected because it contains numerical advertising expenditure variables and a measurable sales outcome, making it suitable for correlation analysis, hypothesis testing, and regression.

## 2. Dataset Selection
The dataset contains 200 observations. TV, Radio, and Newspaper represent advertising expenditure, while Sales represents the response variable.

## 3. Exploratory Analysis
The analysis begins with summary statistics, missing-value checks, distributions, and scatter plots. Correlation tests are used to measure the relationship between each advertising channel and sales.

## 4. Hypothesis Testing
The main hypothesis tests whether advertising expenditure is significantly associated with sales. A p-value below 0.05 is interpreted as evidence against the null hypothesis.

## 5. Model Building
A multiple linear regression model is built using Sales as the dependent variable and TV, Radio, and Newspaper as independent variables.

## 6. Cross-Validation
Five-fold cross-validation is used to estimate how the model is expected to perform on unseen observations. RMSE, MAE, and R-squared are reported.

## 7. Diagnostics
Residual plots and standard regression diagnostic plots are examined to identify possible non-linearity, unequal variance, influential observations, and other model issues.

## 8. Conclusion
The final conclusion should be written after running the R script. Report the actual significant predictors, p-values, R-squared, RMSE, and MAE produced by the run rather than inventing values.
