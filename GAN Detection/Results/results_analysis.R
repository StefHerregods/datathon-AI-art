#### RESULTS ####
out_fake <- read.csv("output_fake.csv")
out_real <- read.csv("output_real.csv")

length(out_fake[out_fake$logit>0,]$logit)/length(out_fake$logit)
