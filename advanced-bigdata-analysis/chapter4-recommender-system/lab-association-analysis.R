####
#### ch4. recommender system
####

#### association analysis

#---- load data & preprocessing

rm(list=ls())
gc()

setwd('C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/8_고급빅데이터분석(김용대교수님)/chapter-4')
tot=read.csv("tot.csv", header = TRUE)
load("ref_data_ver2.RData")
tot <- tot[,-1] # ID
colnames(tot) <- unq.itm
rownames(tot) <- unq.usr
head(tot)

#---- model fitting

library(arules)
colnames(tot)=unq.itm.name
rules <- apriori(as.matrix(tot), parameter=list(supp=0.01, conf=0.5))
# supp: 지지도, conf: 신뢰도, smax: 최대 지지도
# minlen: 최소물품수(lhs+rhs), maxlen: 최대물품수(lhs+rhs)
# lhs: left hand side, rhs: right hand side
# count: 둘 다 산 개수, 조건에 해당하는 개수
print(rules)
rules.sorted <- sort(rules, by="lift") # 향상도 순서대로 출력
inspect(rules.sorted) # inspect() 함수로 규칙을 살펴볼 수 있음

#---- subset
library(dplyr)
rules.sub <- subset(rules, rhs %pin% c("크림"))
# 관심 있는 item 찾을 때 %in%, %pin%, %ain% 활용
# %pin%: 글자가 일부 매칭되어도 출력
inspect(rules.sub)

#---- appearance (instead of subset)
temp <- apriori(as.matrix(tot), parameter=list(supp=0.01, conf=0.5),
                appearance=list(lhs=c("기저귀/분유  분유  매일유업 "), default='rhs'))
inspect(temp)

#---- practice: shopping.csv
shop <- read.csv("shopping.csv", header=T)
dim(shop)
names(shop)
colnames(shop) <- c('customer', 'goods', 'times')
i <- shop$customer
j <- shop$goods
shop.m <- sparseMatrix(i, j, dims=c(max(i), max(j)), x=1)
image(shop.m[c(1:100),]) # 100명만 추출해서 그려
