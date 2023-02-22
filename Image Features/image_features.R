library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

df_raw <- read.csv("../DataProcessing/new_final_df.csv")

df <- df_raw %>%
  select(c("id", "AI_Generated", "logit", "classification", "accuracy_prediction", "brightness_score", "contrast_score", "edge_score", "saturation_score")) %>%
  rename("logit"="logit", 
         "brightness"="brightness_score", 
         "contrast"="contrast_score", 
         "edge"="edge_score", 
         "saturation"="saturation_score") %>%
  drop_na(logit) %>%
  arrange(id)


df_fake <- df %>%
  filter(AI_Generated==1)

df_real <- df_raw %>%
  select(c("id", "real_logit", "brightness_score_y", "contrast_score_y", "edge_score_y", "saturation_score_y")) %>%
  rename("logit"="real_logit", 
         "brightness"="brightness_score_y", 
         "contrast"="contrast_score_y", 
         "edge"="edge_score_y", 
         "saturation"="saturation_score_y") %>%
  drop_na(logit) %>%
  arrange(id)

df.g <- gather(df_new, key=feature, value = score, 
               c("brightness","contrast", "edge", "saturation"))

df_fake.g <- gather(df_fake, key=feature, value = score, 
               c("brightness","contrast", "edge", "saturation"))

df_real.g <- gather(df_real, key=feature, value = score, 
                    c("brightness","contrast", "edge", "saturation"))

ggplot(df.g, aes(x=logit, y = score, group = feature, color = feature)) + 
  geom_smooth(lwd=1, method='gam') +
  ylim(c(0, 200)) +
  #facet_grid(~feature, labeller = as_labeller(feature_names)) +
  labs(
    x = "logit",
    y = "Estimated Pixel Value"
  ) +
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


ggplot(df_fake.g, aes(x=logit, y = score, group = feature, color = feature)) + 
  geom_smooth(lwd=1, method='gam') +
  ylim(c(0, 200)) +
  #facet_grid(~feature, labeller = as_labeller(feature_names)) +
  labs(
    x = "logit",
    y = "Estimated Pixel Value"
  ) +
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

ggplot(df_real.g, aes(x=logit, y = score, group = feature, color = feature)) + 
  geom_smooth(lwd=1, method='gam') +
  ylim(c(0, 200)) +
  #facet_grid(~feature, labeller = as_labeller(feature_names)) +
  labs(
    x = "logit",
    y = "Estimated Pixel Value"
  ) +
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



