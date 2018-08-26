# 0. load data
setwd("C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/4_고객관계관리(김병도교수님)")
mail <- read.csv("mailorder.csv", header=TRUE)
dim(mail)
attach(mail)


# 1. set the baseline
# 1.1 train set, test set
set.seed(3)
index=sample((1:4000),2000)
train <- mail[index,]
test <- mail[-index,]
# 1.2 check the baseline
base.pred <- sample(test$purchase,500)
mean(base.pred) # 0.084


# 2. create 8 segments and check the hit rate(k=2)
# 2.1 create new columns
mail$r2=cut(recency, breaks=c(0,median(recency),max(recency)), 
            include.lowest=FALSE,right=TRUE,labels=c('2','1'))
mail$f2=cut(frequency, breaks=c(0,median(frequency),max(frequency)), 
             include.lowest=FALSE,right=TRUE,labels=c('1','2'))
mail$m2=cut(monetary, breaks=c(0,median(monetary),max(monetary)), 
            include.lowest=FALSE,right=TRUE,labels=c('1','2'))
mail$rfm2=paste0(mail$r2,mail$f2,mail$m2)
mail$rfm2=factor(mail$rfm2)
attach(mail)
# 2.2 train set & test set
set.seed(3)
index=sample((1:4000),2000)
train <- mail[index,]
test <- mail[-index,]
# 2.3 find the segments whose purchase rate is high in train set
library(dplyr)
rfm2.pred <- aggregate(formula=purchase~rfm2,data=train,FUN=mean)
rfm2.pred <- arrange(rfm2.pred, desc(rfm2.pred$purchase)) # 222 > 212 > 221
# 2.4 apply to test set and final purchase rate
length(which(test$rfm2==222)) # 284
length(which(test$rfm2==212)) # 257
rfm2.index=sample((1:257),216)
test.222 <- subset(test, test$rfm2==222)
test.212 <- subset(test, test$rfm2==222)
test.212 <- test.212[rfm2.index,]
rfm2.500 <- rbind(test.222, test.212)
mean(rfm2.500$purchase) # 0.152 > 0.084


# 3. create 125 segments and check the hit rate(k=5)
# 3.1 create new columns
mail$r5=cut(recency, breaks=c(0,4,8,12,16,max(recency)), 
            include.lowest=FALSE,right=TRUE,labels=c('5','4','3','2','1'))
mail$f5=cut(frequency, breaks=c(0,1,2,5,9,max(frequency)), 
             include.lowest=FALSE,right=TRUE,labels=c('1','2','3','4','5'))
mail$m5=cut(monetary, breaks=c(0,113,181,242,299,max(monetary)), 
            include.lowest=FALSE,right=TRUE,labels=c('1','2','3','4','5'))
mail$rfm5=paste0(mail$r5,mail$f5,mail$m5)
mail$rfm5=factor(mail$rfm5)
attach(mail)
# 3.2 train set & test set
set.seed(3)
index=sample((1:4000),2000)
train <- mail[index,]
test <- mail[-index,]
# 3.3 find the segments and apply to the test set
rfm5.pred <- aggregate(formula=purchase~rfm5,data=train,FUN=mean)
rfm5.pred <- arrange(rfm5.pred, desc(rfm5.pred$purchase))
rfm5.pred$purchase.1 <- rfm5.pred$purchase
rfm5.pred.new <- rfm5.pred[,-3]
rfm5.500 <- merge(test, rfm5.pred.new, by=c('rfm5'), all.x=TRUE)
rfm5.500 <- arrange(rfm5.500, desc(rfm5.500$purchase.y)) # train set purchase 기준 정렬
rfm5.500$rfm5[480:490] # 490부터 521, select 11 among 521
rfm5.489 <- mean(rfm5.500$purchase.x[1:489])
length(rfm5.500$id[rfm5.500$rfm5=='521']) # 32
rfm5.11 <- sample(rfm5.500$purchase.x[490:521], 11)
rfm5.11 <- mean(rfm5.11)
((rfm5.489*489)+(rfm5.11*11))/500 # 0.128


# 4. multiple regression
# 4.1 train set & test set
set.seed(3)
index=sample((1:4000),2000)
train <- mail[index,]
test <- mail[-index,]
attach(mail)
# 4.2 regression
lm.fit <- lm(purchase~recency+frequency+monetary, data=train)
summary(lm.fit)
lm.pred <- predict(lm.fit, newdata=test)
mean(tail(sort(lm.pred),500)) # 0.1516754


# 5. best subset selection
# 5.1 manipulate categorical data
mail$gender1[mail$gender=="F"]=1
mail$gender1[mail$gender=="M"]=0
set.seed(3)
index=sample((1:4000),2000)
train <- mail[index,]
train <- train[,c(-1,-11,-15)]
test <- mail[-index,]
test <- test[,c(-1,-11,-15)]
# 5.2 train & test set 변수선택
library(leaps)
regfit.full <- regsubsets(purchase~recency+frequency+monetary+duration+r2+f2+m2+gender1,train)
summary(regfit.full)
reg.summary = summary(regfit.full)
reg.summary$bic
plot(reg.summary$bic,xlab="Number of Variables",ylab="BIC",type='l')
# lm after variable selection
lm.fit <- lm(purchase~recency+frequency+gender1, data=train)
summary(lm.fit)
lm.pred <- predict(lm.fit, newdata=test)
mean(tail(sort(lm.pred),500)) # 16.7%, 3 -> 15%
# glm after variable selection
glm.fit=glm(purchase~recency+frequency+gender1, data=train, 
            family=binomial)
summary(glm.fit)
train.x = train[,c(3,4,13)]
train.y = train[,6]
train.all = train[,c(3,4,6,13)]
test.x = test[,c(3,4,13)]
test.y = test[,6]
test.all = test[,c(3,4,6,13)]
glm.probs=predict(glm.fit,test.x,type="response")
test.new = cbind(test.y, glm.probs)
test.new = data.frame(test.new)
test.new <- arrange(test.new, desc(test.new$glm.probs))
test.new$test.y[1:500]
sum(test.new$test.y[1:500])/500 # 0.188
