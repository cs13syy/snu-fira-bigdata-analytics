# 0. load data
setwd("C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/4_고객관계관리(김병도교수님)")
mail <- read.csv("mailorder.csv", header=TRUE)
dim(mail)
attach(mail)


# 1. set the baseline
# 1.1 train set, test set
set.seed(10)
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
set.seed(10)
index=sample((1:4000),2000)
train <- mail[index,]
test <- mail[-index,]
# 2.3 find the segments whose purchase rate is high in train set
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
set.seed(10)
index=sample((1:4000),2000)
train <- mail[index,]
test <- mail[-index,]
# 3.3 find the segments and apply to the test set
rfm5.pred <- aggregate(formula=purchase~rfm5,data=train,FUN=mean)
rfm5.pred <- arrange(rfm5.pred, desc(rfm5.pred$purchase))
rfm5.pred$purchase.1 <- rfm5.pred$purchase
rfm5.pred.new <- rfm5.pred[,-3]
rfm5.500 <- merge(test, rfm5.pred.new, by=c('rfm5'), all.x=TRUE)
rfm5.500 <- arrange(rfm5.500, desc(rfm5.500$purchase.y)) # train set purchase 기준으로 정렬
rfm5.500$rfm5[480:490] # 490부터 521, select 11 among 521
rfm5.489 <- mean(rfm5.500$purchase.x[1:489])
length(rfm5.500$id[rfm5.500$rfm5=='521']) # 32
rfm5.11 <- sample(rfm5.500$purchase.x[490:521], 11)
rfm5.11 <- mean(rfm5.11)
((rfm5.489*489)+(rfm5.11*11))/500 # 0.128


# 4. multiple regression
# 4.1 train set & test set
mail <- read.csv("mailorder.csv", header=TRUE)
set.seed(10)
index=sample((1:4000),2000)
train <- mail[index,]
test <- mail[-index,]
attach(mail)
# 4.2 regression
lm.fit <- lm(purchase~recency+frequency+monetary, data=train)
summary(lm.fit)
lm.pred <- predict(lm.fit, newdata=test)
mean(tail(sort(lm.pred),500)) # 0.1516754
