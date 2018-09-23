####
#### ch3. target marketing
####

setwd('C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/8_고급빅데이터분석(김용대교수님)/chapter-3')
buytest <- read.table('buytest.txt', header=TRUE)
dim(buytest)
dim(buytest[complete.cases(buytest),])
buytest(!complete.cases(buytest),)
