#### Pre-scraping ####
fake_urls <- read.csv("../../FilesCSVFormat/Generated.csv")
real_urls <- read.csv("../../FilesCSVFormat/Artwork.csv")

fake_urls <- fake_urls[order(fake_urls$source_artwork),]
real_urls.s <- subset(real_urls, select = c(id, image_url))

write.table(fake_urls, file="df_fake.csv", sep=",", row.names=F, col.names=F)
write.table(real_urls.s, file="df_real.csv", sep=",", row.names=F, col.names=F)
