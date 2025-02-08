stress_data <- read.csv("Student Stress Factors.csv")
# Rename the columns
colnames(stress_data) <- c("SleepQuality", "Headaches", "AcademicPerformance", 
                           "StudyLoad", "ExtracurricularActivities", "StressLevels")

# Verify the change
str(stress_data)

# Load libraries
library(ggplot2)
library(dplyr)

# Summary of dataset
summary(stress_data)

# Sleep Quality Distribution
ggplot(stress_data, aes(x = SleepQuality)) + 
  geom_bar(fill = "lightblue") + 
  labs(title = "Distribution of Sleep Quality", x = "Sleep Quality", y = "Count")

# Headaches Distribution
ggplot(stress_data, aes(x = Headaches)) + 
  geom_histogram(fill = "lightcoral", bins = 5) + 
  labs(title = "Frequency of Headaches", x = "Headaches (per week)", y = "Count")

# Stress Levels Distribution
ggplot(stress_data, aes(x = StressLevels)) + 
  geom_bar(fill = "lightgreen") + 
  labs(title = "Distribution of Stress Levels", x = "Stress Levels", y = "Count")

# Study Load vs Stress Levels
ggplot(stress_data, aes(x = StudyLoad, y = StressLevels)) +
  geom_jitter(color = "blue", alpha = 0.5) +
  labs(title = "Study Load vs. Stress Levels", x = "Study Load", y = "Stress Levels")

# Sleep Quality vs Stress Levels
ggplot(stress_data, aes(x = SleepQuality, y = StressLevels)) +
  geom_jitter(color = "purple", alpha = 0.5) +
  labs(title = "Sleep Quality vs. Stress Levels", x = "Sleep Quality", y = "Stress Levels")

# Correlation matrix
cor_matrix <- stress_data %>% 
  select(SleepQuality, Headaches, AcademicPerformance, StudyLoad, ExtracurricularActivities, StressLevels) %>%
  cor()

# Display correlation matrix
print(cor_matrix)

#3.Outliers
boxplot(stress_data)

//New one 
# Load necessary libraries
library(ggplot2)
library(ggcorrplot)  # For correlation heatmap

# 1. Summary of the dataset
summary(stress_data)

# 2. Exploratory Data Analysis (EDA)

# a. Boxplot to identify outliers
boxplot(stress_data, main = "Boxplot of Stress Data", las = 2)

# b. Correlation matrix
cor_matrix <- cor(stress_data)
print(cor_matrix)

# c. Visualizing correlations using a heatmap
ggcorrplot(cor_matrix, method = "circle", type = "lower", 
           title = "Correlation Matrix Heatmap", 
           lab = TRUE)

# 3. Checking distributions for normality
# a. Histogram of Sleep Quality
ggplot(stress_data, aes(x = SleepQuality)) + 
  geom_histogram(bins = 5, fill = "blue", alpha = 0.7) +
  labs(title = "Distribution of Sleep Quality", x = "Sleep Quality (1-5)", y = "Frequency")

# b. Q-Q plot for Sleep Quality
qqnorm(stress_data$SleepQuality)
qqline(stress_data$SleepQuality)

# 4. Training / Testing split
set.seed(123)  # For reproducibility
sample_index <- sample(1:nrow(stress_data), size = 0.7 * nrow(stress_data))
train_data <- stress_data[sample_index, ]
test_data <- stress_data[-sample_index, ]

# 5. Save the training and testing datasets
write.csv(train_data, "train_data.csv", row.names = FALSE)
write.csv(test_data, "test_data.csv", row.names = FALSE)

# 6. Linear regression example (once the EDA is done)
# Fit a linear regression model to predict Stress Levels using Sleep Quality, Study Load, and Academic Performance
lm_model <- lm(StressLevels ~ SleepQuality + StudyLoad + AcademicPerformance, data = train_data)

# Check the summary of the linear regression model
summary(lm_model)

# 7. Diagnostic plots for the linear regression model
par(mfrow = c(2, 2))
plot(lm_model)

# 8. Predictions on the testing set
predictions <- predict(lm_model, newdata = test_data)

# 9. Comparing predictions with actual values
comparison <- data.frame(Actual = test_data$StressLevels, Predicted = predictions)
print(comparison)

#new one
#1.Useful variables 
summary(stress_data)

#2.High-order Terms or Transformations

# Adding squared terms for non-linear effects
stress_data$SleepQuality_sq <- stress_data$SleepQuality^2
stress_data$StudyLoad_sq <- stress_data$StudyLoad^2

# Model with high-order terms
model_with_high_order <- lm(StressLevels ~ SleepQuality + SleepQuality_sq + StudyLoad + StudyLoad_sq, data=stress_data)
summary(model_with_high_order)

#3.Outliers
boxplot(stress_data)

#4.Assumptions
# Check for Linearity: Plot predictors against the response variable
plot(stress_data$SleepQuality, stress_data$StressLevels, main="Sleep Quality vs Stress Levels")
plot(stress_data$StudyLoad, stress_data$StressLevels, main="Study Load vs Stress Levels")

# Check for Normality of Residuals after fitting a model
model <- lm(StressLevels ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities, data=stress_data)
residuals <- model$residuals

# Histogram of residuals
hist(residuals, main="Histogram of Residuals", xlab="Residuals", col="lightblue")

# Q-Q plot to check normality
qqnorm(residuals)
qqline(residuals, col = "red")

#5.Collinearity

# Calculate the correlation matrix
cor(stress_data)
# Pairs plot to visualize relationships
pairs(stress_data)

#6.Interaction term
# Model with multiple interaction terms
model_multiple_interactions <- lm(StressLevels ~ StudyLoad * SleepQuality + Headaches * ExtracurricularActivities, data=stress_data)

# Summary of the model
summary(model_multiple_interactions)

#7.Training / Testing split 
set.seed(123)
train_index <- sample(1:nrow(stress_data), 0.7 * nrow(stress_data))
train_data <- stress_data[train_index, ]
test_data <- stress_data[-train_index, ]

full_model <- lm(StressLevels ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = stress_data)
# Shapiro-Wilk Normality Test
shapiro.test(full_model$residuals)
plot(full_model, which = 4, main = "Residuals vs Leverage")

# Calculate leverage values
leverage_values <- hatvalues(full_model)

# Find the top 21 leverage values
top_leverage <- tail(sort(leverage_values), n = 21)
print(top_leverage)
# Code to identify top leverage values
top_leverage <- tail(sort(hatvalues(full_model)), n = 10)
print(top_leverage)
# Close any previous graphics window that may be causing the issue
dev.off()

# Full model with Academic Performance included
full_model <- lm(StressLevels ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = train_data)

# Log transformation
train_data$StressLevels_log <- log(train_data$StressLevels)

# Square root transformation
train_data$StressLevels_sqrt <- sqrt(train_data$StressLevels)

# Inverse transformation
train_data$StressLevels_inv <- 1 / train_data$StressLevels

# Fit models using transformed variables
model_log <- lm(StressLevels_log ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = train_data)
model_sqrt <- lm(StressLevels_sqrt ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = train_data)
model_inv <- lm(StressLevels_inv ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = train_data)

# Shapiro-Wilk test for normality of residuals
shapiro_log <- shapiro.test(model_log$residuals)
shapiro_sqrt <- shapiro.test(model_sqrt$residuals)
shapiro_inv <- shapiro.test(model_inv$residuals)

# Print results of the Shapiro-Wilk test
print(shapiro_log)
print(shapiro_sqrt)
print(shapiro_inv)

# Apply Y^2/3 transformation
train_data$StressLevels_23 <- train_data$StressLevels^(2/3)

# Fit the model using the transformed StressLevels
model_23 <- lm(StressLevels_23 ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = train_data)

# Shapiro-Wilk test for normality of residuals after Y^2/3 transformation
shapiro_23 <- shapiro.test(model_23$residuals)

# Print the results of the Shapiro-Wilk test for Y^2/3 transformation
print(shapiro_23)

# Apply log transformation to the response variable
train_data$StressLevels_log <- log(train_data$StressLevels)

# Fit the model using the log-transformed response
model_log <- lm(StressLevels_log ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities, data = train_data)

# Perform Shapiro-Wilk test on residuals
shapiro_log <- shapiro.test(residuals(model_log))

# Print the result of the Shapiro-Wilk test
print(shapiro_log)

# Apply square root transformation to the response variable
train_data$StressLevels_sqrt <- sqrt(train_data$StressLevels)

# Fit the model using the square root-transformed response
model_sqrt <- lm(StressLevels_sqrt ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities, data = train_data)

# Perform Shapiro-Wilk test on residuals
shapiro_sqrt <- shapiro.test(residuals(model_sqrt))

# Print the result of the Shapiro-Wilk test
print(shapiro_sqrt)



# Cubic Root Transformation on StressLevels
stress_data$StressLevels_cbrt <- stress_data$StressLevels^(1/3)

# Fit the model with the cubic root-transformed dependent variable
cbrt_model <- lm(StressLevels_cbrt ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities, data = stress_data)

# Check residuals
shapiro_test_cbrt <- shapiro.test(residuals(cbrt_model))
cat("Shapiro-Wilk p-value for Cubic Root-transformed model:", shapiro_test_cbrt$p.value, "\n")


# Fit a robust regression model (use the same predictors as in your previous model)
robust_model <- rlm(StressLevels ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities, data = stress_data)

# View the summary of the model
summary(robust_model)
# Residuals vs Fitted plot
plot(robust_model$fitted.values, robust_model$residuals, main = "Residuals vs Fitted (Robust Model)",
     xlab = "Fitted Values", ylab = "Residuals")

# Q-Q plot for residuals
qqnorm(robust_model$residuals)
qqline(robust_model$residuals, col = "red")


# Full Model with Academic Performance
full_model <- lm(StressLevels ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = train_data)

# Log Transformation
train_data$StressLevels_log <- log(train_data$StressLevels)
model_log <- lm(StressLevels_log ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = train_data)

# Square Root Transformation
train_data$StressLevels_sqrt <- sqrt(train_data$StressLevels)
model_sqrt <- lm(StressLevels_sqrt ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = train_data)

# Box-Cox Transformation
library(MASS)
boxcox_model <- lm(StressLevels ~ SleepQuality + StudyLoad + Headaches + ExtracurricularActivities + AcademicPerformance, data = train_data)
boxcox(boxcox_model, lambda = seq(-2, 2, by = 0.1))
