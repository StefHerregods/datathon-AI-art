library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

image_features <- read_csv('output/image_features.csv')

df_raw <- featues_df_final

df_fake <- df_raw %>%
  select(c("id", "fake_logit", "brightness_score_x", "contrast_score_x", "edge_score_x", "saturation_score_x")) %>%
  rename("logit"="fake_logit", 
         "brightness"="brightness_score_x", 
         "contrast"="contrast_score_x", 
         "edge"="edge_score_x", 
         "saturation"="saturation_score_x") %>%
  drop_na(logit) %>%
  arrange(id)

df_real <- df_raw %>%
  select(c("id", "real_logit", "brightness_score_y", "contrast_score_y", "edge_score_y", "saturation_score_y")) %>%
  rename("logit"="real_logit", 
         "brightness"="brightness_score_y", 
         "contrast"="contrast_score_y", 
         "edge"="edge_score_y", 
         "saturation"="saturation_score_y") %>%
  drop_na(logit) %>%
  arrange(id)


df_fake.g <- gather(df_fake, key=feature, value = score, 
               c("brightness","contrast", "edge", "saturation"))
df_real.g <- gather(df_real, key=feature, value = score, 
                    c("brightness","contrast", "edge", "saturation"))


ggplot(df_fake.g, aes(x=logit, y = score, group = feature, color = feature)) + 
  geom_smooth(lwd=1, method='loess') +
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



