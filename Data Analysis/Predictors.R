library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(car) 

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
model1 <- glm(AI_Generated~brightness+contrast+edge+saturation+num_rels, data=df, family="binomial")
summary(model1)

model2 <- glm(classification~brightness+contrast+edge+saturation+num_rels, data=df, family="binomial")
summary(model2)

model3 <- glm(accuracy_prediction~brightness+contrast+edge+saturation+num_rels, data=df, family="binomial")
summary(model3)


ggplot(df.plot, aes(score, AI_Generated, col=feature)) +
  geom_point(alpha=0.01, col="black") +
  geom_smooth(method="glm", method.args = list(family = "binomial")) +
  facet_grid(.~feature) +
  theme(
    strip.text.x = element_text(size=12, color='#414141', margin=margin(b=8)),
    strip.background = element_rect(fill=NA),
    axis.title.x = element_text(size=12, color='#414141', margin=margin(t=8)),
    axis.title.y = element_text(size=12, color='#414141', margin=margin(r=8)),
    axis.ticks = element_line(color='#414141'),
    panel.border = element_rect(color='#414141', fill=NA),
    panel.background = element_rect(fill=NA),
    legend.position = "none",
    axis.text=element_text(size=9, color='#414141')
  )

ggplot(df.plot, aes(score, classification, col=feature)) +
  geom_point(alpha=0.01, col="black") +
  geom_smooth(method="glm", method.args = list(family = "binomial")) +
  facet_grid(.~feature)  +
  theme(
    strip.text.x = element_text(size=12, color='#414141', margin=margin(b=8)),
    strip.background = element_rect(fill=NA),
    axis.title.x = element_text(size=12, color='#414141', margin=margin(t=8)),
    axis.title.y = element_text(size=12, color='#414141', margin=margin(r=8)),
    axis.ticks = element_line(color='#414141'),
    panel.border = element_rect(color='#414141', fill=NA),
    panel.background = element_rect(fill=NA),
    legend.position = "none",
    axis.text=element_text(size=9, color='#414141')
  )


ggplot(df.plot, aes(score, accuracy_prediction, col=feature)) +
  geom_point(alpha=0.01, col="black") +
  geom_smooth(method="glm", method.args = list(family = "binomial")) +
  facet_grid(.~feature)  +
  theme(
    strip.text.x = element_text(size=12, color='#414141', margin=margin(b=8)),
    strip.background = element_rect(fill=NA),
    axis.title.x = element_text(size=12, color='#414141', margin=margin(t=8)),
    axis.title.y = element_text(size=12, color='#414141', margin=margin(r=8)),
    axis.ticks = element_line(color='#414141'),
    panel.border = element_rect(color='#414141', fill=NA),
    panel.background = element_rect(fill=NA),
    legend.position = "none",
    axis.text=element_text(size=9, color='#414141')
  )

#ggplot(df, aes(edge, accuracy_prediction)) +
#  geom_point(alpha=0.01) +
#  geom_smooth(method="glm", method.args = list(family = "binomial"))


ggplot(df.plot, aes(score)) +
  geom_histogram() +
  facet_grid(feature~AI_Generated) +
  theme(
    strip.text.x = element_text(size=12, color='#414141', margin=margin(b=8)),
    strip.background = element_rect(fill=NA),
    axis.title.x = element_text(size=12, color='#414141', margin=margin(t=8)),
    axis.title.y = element_text(size=12, color='#414141', margin=margin(r=8)),
    axis.ticks = element_line(color='#414141'),
    panel.border = element_rect(color='#414141', fill=NA),
    panel.background = element_rect(fill=NA),
    legend.position = "top",
    axis.text=element_text(size=9, color='#414141')
  )


ggplot(df.plot, aes(feature, score, fill=feature)) +
  geom_boxplot() +
  facet_grid(.~as.factor(AI_Generated))  +
  theme(
    strip.text.x = element_text(size=12, color='#414141', margin=margin(b=8)),
    strip.background = element_rect(fill=NA),
    axis.title.x = element_text(size=12, color='#414141', margin=margin(t=8)),
    axis.title.y = element_text(size=12, color='#414141', margin=margin(r=8)),
    axis.ticks = element_line(color='#414141'),
    panel.border = element_rect(color='#414141', fill=NA),
    panel.background = element_rect(fill=NA),
    legend.position = "top",
    axis.text=element_text(size=9, color='#414141')
  )


t.test(df.fake$saturation, df.real$saturation)


vif(model)

corrplot(cor(df))



