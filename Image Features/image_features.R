library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

image_features <- read_csv('output/image_features.csv')

#df <- image_features %>% 
#  group_by(id) %>%  
#  summarize(m_edge = mean(edge_score),
#            m_contrast = mean(contrast_score),
#            m_brightness = mean(brightness_score),
#            m_saturation = mean(saturation_score))

#df$edges <- scale(df$m_edge)
#df$contrast <- scale(df$m_contrast)
#df$brightness <- scale(df$m_brightness)
#df$saturation <- scale(df$m_saturation)

df <- gather(image_features, key=feature, value = score, 
               c("contrast_score", "edge_score", "brightness_score", "saturation_score"))




ggplot(df, aes(x=alpha, y = score, group = feature, color = feature)) + 
  geom_smooth(lwd=1, method='gam') +
  ylim(c(-2.5, 2.5)) +
  #facet_grid(~feature, labeller = as_labeller(feature_names)) +
  labs(
    x = expression(paste(alpha, '-value')),
    y = "Standardized Score"
  ) +
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
