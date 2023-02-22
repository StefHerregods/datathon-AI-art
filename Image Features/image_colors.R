library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(purrr)


fake.cols <- list.files(pattern = "fakeimg_*", recursive = TRUE) %>% 
  map_df(~read_csv(.)) %>%
  gather(key, value, -id)
fake.cols$key <- factor(fake.cols$key, levels=c("red", "green", "blue"))

real.cols <- list.files(pattern = "realimg_*", recursive = TRUE) %>% 
  map_df(~read_csv(.)) %>%
  gather(key, value, -id)
real.cols$key <- factor(real.cols$key, levels=c("red", "green", "blue"))


ggplot(fake.cols, aes(x=value, col=key, group_by=id)) +
  geom_freqpoly(stat="bin", position="identity", bins=1024, alpha = 0.6) +
  geom_freqpoly(aes(group=key),col="black", bins=257, lwd=0.2) +
  xlim(0, 256) +
  coord_cartesian(ylim=c(0, 5000)) +
  labs(
    x = "Pixel Intensity",
    y = "Count"
  ) +
  facet_grid(.~id) +
  theme(
    strip.text.x = element_text(size=12, color='#414141', margin=margin(b=8)),
    strip.text.y = element_blank(),
    strip.background = element_rect(fill=NA),
    axis.title.x = element_text(size=12, color='#414141', margin=margin(t=8)),
    axis.title.y = element_blank(),
    axis.ticks = element_line(color='#414141'),
    axis.ticks.y = element_blank(),
    axis.text.y = element_blank(),
    panel.border = element_rect(color='black', fill=NA),
    panel.background = element_rect(fill=NA),
    panel.spacing.y = unit(1, "lines"),
    legend.title = element_blank(),
    legend.position = "none",
    axis.text=element_text(size=9, color='#414141')
  )

ggplot(real.cols, aes(x=value, col=key, group_by=id)) +
  geom_freqpoly(stat="bin", position="identity", bins=1024, alpha = 0.6) +
  geom_freqpoly(aes(group=key),col="black", bins=257, lwd=0.2) +
  xlim(0, 256) +
  coord_cartesian(ylim=c(0, 5000)) +
  labs(
    x = "Pixel Intensity",
    y = "Count"
  ) +
  facet_grid(.~id) +
  theme(
    strip.text.x = element_text(size=12, color='#414141', margin=margin(b=8)),
    strip.text.y = element_blank(),
    strip.background = element_rect(fill=NA),
    axis.title.x = element_text(size=12, color='#414141', margin=margin(t=8)),
    axis.title.y = element_blank(),
    axis.ticks = element_line(color='#414141'),
    axis.ticks.y = element_blank(),
    axis.text.y = element_blank(),
    panel.border = element_rect(color='black', fill=NA),
    panel.background = element_rect(fill=NA),
    panel.spacing.y = unit(1, "lines"),
    legend.title = element_blank(),
    legend.position = "none",
    axis.text=element_text(size=9, color='#414141')
  )
