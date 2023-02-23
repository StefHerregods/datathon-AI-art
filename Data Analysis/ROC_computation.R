library(pROC)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

## Load full df
df_raw <- read.csv(".\\DataProcessing\\new_final_df.csv")

## Processing pipeline
df <- df_raw %>%
  select(c("id", "AI_Generated", "logit", "num_rels", "classification", "accuracy_prediction", "brightness_score", "contrast_score", "edge_score", "saturation_score")) %>%
  rename("logit"="logit", 
         "brightness"="brightness_score", 
         "contrast"="contrast_score", 
         "edge"="edge_score", 
         "saturation"="saturation_score") %>%
  drop_na(logit) %>%
  group_by(id) %>%
  filter(n()>1)

# Find the ids that appear more than once in the data frame
dup_ids <- names(table(df$id))[table(df$id) > 1]

# Keep only the rows with ids that appear more than once
df_subset <- df[df$id %in% dup_ids,]


# Split data into training and testing sets
set.seed(0)
train_idx <- sample(nrow(df), nrow(df)/2)
train_data <- df[train_idx, ]
test_data <- df[-train_idx, ]

# Model 1: Using the 'logit' column as predictor
pred1 <- test_data$logit
roc1 <- roc(test_data$AI_Generated, pred1, n=10000)

# Model 2: Using glm1
glm1 <- glm(AI_Generated~brightness*contrast*edge*saturation+num_rels, data=train_data, family="binomial")
pred2 <- predict(glm1, newdata = test_data, type = "response")
roc2 <- roc(test_data$AI_Generated, pred2, n=10000)

# Model 3: Using glm2
glm2 <- glm(AI_Generated~logit+brightness*contrast*edge*saturation+num_rels, data=train_data, family="binomial")
pred3 <- predict(glm2, newdata = test_data, type = "response")
roc3 <- roc(test_data$AI_Generated, pred3, n=10000)


# Plot ROC curves for each model
plot(roc1, col = "#e28743", lwd = 3, print.auc = FALSE, grid = TRUE,
     grid.col = "lightgray", xlab = "False Positive Rate", ylab = "True Positive Rate",
     main = "ROC Curve", legacy.axes = TRUE)
lines(roc2, col = "#21130d", lwd = 3)
lines(roc3, col = "#1e81b0", lwd = 3)

# legend
legend("bottomright", legend = c("Model 1 (logit)", "Model 2 (glm1)", "Model 3 (glm2)"), 
       col = c("red", "blue", "green"), lwd = 2)

# AUC
auc(roc1)
auc(roc2)
auc(roc3)



# Find cutoff index
cutoff_idx <- coords(roc1, "best", best.method = "closest.topleft")$thresholds

# Add vertical line at cutoff point
abline(v = cutoff_idx, col = "red", lty = 2, lwd = 2)




