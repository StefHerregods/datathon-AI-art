#### RESULTS ####
out_fake <- read.csv("output_fake.csv")
out_real <- read.csv("output_real.csv")
out_real_nowm <- read.csv("output_real_nowm.csv")

length(out_fake[out_fake$logit>0,]$logit)/length(out_fake$logit)
length(out_real[out_real$logit>0,]$logit)/length(out_real$logit)
length(out_real_nowm[out_real_nowm$logit>0,]$logit)/length(out_real_nowm$logit)


mean(out_fake$logit)
mean(out_real$logit)

head(out_fake)
head(out_real)

boxplot(out_fake$logit, out_real$logit)

