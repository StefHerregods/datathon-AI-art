library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

## Load full df
df_raw <- read.csv("../DataProcessing/new_final_df.csv")

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

## df for plots
df.plot <- df %>%
  gather(key=feature, value = score, c("brightness","contrast", "edge", "saturation"))


## Logistic regression
model <- glm(accuracy_prediction~brightness+contrast+edge+saturation+num_rels, data=df, family="binomial")
summary(model)


ggplot(df.plot, aes(score, accuracy_prediction)) +
  geom_point(alpha=0.01) +
  geom_smooth(method="glm", method.args = list(family = "binomial")) +
  facet_wrap(.~feature) 


#ggplot(df, aes(edge, accuracy_prediction)) +
#  geom_point(alpha=0.01) +
#  geom_smooth(method="glm", method.args = list(family = "binomial"))


ggplot(df.plot, aes(score)) +
  geom_histogram() +
  facet_grid(feature~AI_Generated)


ggplot(df.plot, aes(feature, score, fill=(feature))) +
  geom_violin() +
  facet_grid(.~as.factor(AI_Generated))


t.test(df.fake$saturation, df.real$saturation)
