# ============================================================
# Statistical analysis and predictive modeling of advertising sales using R and multiple linear regression
# Project: Advertising Sales Prediction
# ============================================================

# 1. Install/load packages -------------------------------------
required_packages <- c("ISLR2", "ggplot2", "dplyr", "caret")

new_packages <- required_packages[
  !(required_packages %in% installed.packages()[, "Package"])
]

if (length(new_packages) > 0) {
  install.packages(new_packages, repos = "https://cloud.r-project.org")
}

library(ISLR2)
library(ggplot2)
library(dplyr)
library(caret)

# 2. Load publicly available dataset --------------------------
data("Advertising")
df <- Advertising

cat("Dataset dimensions:", dim(df)[1], "rows and", dim(df)[2], "columns\n")
print(head(df))
print(str(df))

# 3. Basic data checks -----------------------------------------
cat("\nMissing values:\n")
print(colSums(is.na(df)))

cat("\nSummary statistics:\n")
print(summary(df))

# 4. Exploratory statistical analysis --------------------------
# Histograms
png("sales_distribution.png", width = 900, height = 600)
print(
  ggplot(df, aes(x = Sales)) +
    geom_histogram(bins = 20, color = "black") +
    labs(title = "Distribution of Sales",
         x = "Sales", y = "Frequency") +
    theme_minimal()
)
dev.off()

# Scatter plots
png("sales_vs_tv.png", width = 900, height = 600)
print(
  ggplot(df, aes(x = TV, y = Sales)) +
    geom_point() +
    geom_smooth(method = "lm", se = TRUE) +
    labs(title = "Sales vs TV Advertising",
         x = "TV Advertising", y = "Sales") +
    theme_minimal()
)
dev.off()

png("sales_vs_radio.png", width = 900, height = 600)
print(
  ggplot(df, aes(x = Radio, y = Sales)) +
    geom_point() +
    geom_smooth(method = "lm", se = TRUE) +
    labs(title = "Sales vs Radio Advertising",
         x = "Radio Advertising", y = "Sales") +
    theme_minimal()
)
dev.off()

# 5. Correlation analysis -------------------------------------
cat("\nCorrelation matrix:\n")
correlation_matrix <- cor(df)
print(round(correlation_matrix, 3))

cat("\nCorrelation tests with Sales:\n")
print(cor.test(df$TV, df$Sales))
print(cor.test(df$Radio, df$Sales))
print(cor.test(df$Newspaper, df$Sales))

# 6. Normality test -------------------------------------------
# Shapiro-Wilk is applied to the response variable.
cat("\nShapiro-Wilk normality test for Sales:\n")
print(shapiro.test(df$Sales))

# 7. Hypothesis test ------------------------------------------
# H0: TV advertising coefficient = 0
# H1: TV advertising coefficient != 0
tv_model <- lm(Sales ~ TV, data = df)

cat("\nSimple regression: Sales ~ TV\n")
print(summary(tv_model))

cat("\n95% confidence interval for TV coefficient:\n")
print(confint(tv_model, "TV"))

# 8. Multiple linear regression -------------------------------
model <- lm(Sales ~ TV + Radio + Newspaper, data = df)

cat("\nMultiple Linear Regression Results:\n")
print(summary(model))

cat("\n95% confidence intervals:\n")
print(confint(model))

# 9. 5-fold cross-validation ---------------------------------
set.seed(123)

train_control <- trainControl(
  method = "cv",
  number = 5
)

cv_model <- train(
  Sales ~ TV + Radio + Newspaper,
  data = df,
  method = "lm",
  trControl = train_control
)

cat("\n5-fold Cross-Validation Results:\n")
print(cv_model)

cat("\nCross-validation RMSE and R-squared:\n")
print(cv_model$results[, c("RMSE", "Rsquared", "MAE")])

# 10. Train/test evaluation ----------------------------------
set.seed(123)
train_index <- createDataPartition(df$Sales, p = 0.80, list = FALSE)

train_data <- df[train_index, ]
test_data <- df[-train_index, ]

final_model <- lm(
  Sales ~ TV + Radio + Newspaper,
  data = train_data
)

predictions <- predict(final_model, newdata = test_data)

rmse <- sqrt(mean((test_data$Sales - predictions)^2))
mae <- mean(abs(test_data$Sales - predictions))
r2 <- 1 - sum((test_data$Sales - predictions)^2) /
  sum((test_data$Sales - mean(test_data$Sales))^2)

cat("\nTest Set Performance:\n")
cat("RMSE:", round(rmse, 3), "\n")
cat("MAE :", round(mae, 3), "\n")
cat("R-squared:", round(r2, 3), "\n")

# 11. Actual vs predicted plot -------------------------------
results <- data.frame(
  Actual = test_data$Sales,
  Predicted = predictions
)

png("actual_vs_predicted.png", width = 900, height = 600)
print(
  ggplot(results, aes(x = Actual, y = Predicted)) +
    geom_point() +
    geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
    labs(title = "Actual vs Predicted Sales",
         x = "Actual Sales", y = "Predicted Sales") +
    theme_minimal()
)
dev.off()

# 12. Diagnostic plots ----------------------------------------
png("model_diagnostics.png", width = 1200, height = 900)
par(mfrow = c(2, 2))
plot(final_model)
dev.off()

# 13. Multicollinearity check ---------------------------------
# VIF is calculated manually to avoid another package dependency.
predictors <- c("TV", "Radio", "Newspaper")

vif_values <- sapply(predictors, function(variable) {
  other_vars <- predictors[predictors != variable]
  formula_text <- paste(variable, "~", paste(other_vars, collapse = " + "))
  aux_model <- lm(as.formula(formula_text), data = train_data)
  1 / (1 - summary(aux_model)$r.squared)
})

cat("\nApproximate VIF values:\n")
print(round(vif_values, 3))

# 14. Save important outputs ---------------------------------
write.csv(results, "test_predictions.csv", row.names = FALSE)

sink("model_summary.txt")
cat("Multiple Linear Regression\n\n")
print(summary(model))
cat("\n5-fold Cross-Validation\n\n")
print(cv_model$results[, c("RMSE", "Rsquared", "MAE")])
cat("\nTest Set Metrics\n")
cat("RMSE:", round(rmse, 3), "\n")
cat("MAE:", round(mae, 3), "\n")
cat("R-squared:", round(r2, 3), "\n")
sink()

cat("\nAnalysis completed successfully. Check the generated PNG, CSV and TXT files.\n")
