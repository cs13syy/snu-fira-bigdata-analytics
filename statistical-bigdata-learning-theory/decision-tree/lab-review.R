####
#### ch8. tree-based methods
####

## 8.3.1 fitting classification trees

library(tree)
library(ISLR)
attach(Carseats)
summary(Carseats)
High <- ifelse(Sales>8,"Yes","No")
Carseats <- data.frame(Carseats, High)
tree.carseats <- tree(High~.-Sales, Carseats)
summary(tree.carseats)
# see which variables are selected
# training error rate : 9%
# rmd is small -> the model is well fitted
plot(tree.carseats)
text(tree.carseats,cex=0.7)
text(tree.carseats,pretty=0,cex=0.7)
# pretty=0 -> show categorical names
tree.carseats

# train & test set
set.seed(2)
train <- sample(1:nrow(Carseats), 200)
Carseats.test <- Carseats[-train,]
High.test <- High[-train]
tree.carseats <- tree(High~.-Sales, Carseats, subset=train)
tree.pred <- predict(tree.carseats, Carseats.test, type='class')
table(tree.pred, High.test)
(86+57)/sum(table(tree.pred, High.test))

# cv.tree()
set.seed(3)
cv.carseats <- cv.tree(tree.carseats, FUN=prune.misclass)
# prune.misclass -> 디폴트인 이탈도 대신 분류오류율 기반으로 cv, pruning 설정
names(cv.carseats)
cv.carseats
# size <- number of terminal nodes
# dev <- cv error rate
par(mfrow=c(1,2))
plot(cv.carseats$size, cv.carseats$dev, type='b')
plot(cv.carseats$k, cv.carseats$dev, type='b')
par(mfrow=c(1,1))
# pruning
prune.carseats <- prune.misclass(tree.carseats, best=9)
plot(prune.carseats)
text(prune.carseats, pretty=0, cex=0.7)
# validate again
tree.pred <- predict(prune.carseats, Carseats.test, type='class')
table(tree.pred, High.test)
(94+60)/sum(table(tree.pred, High.test))
# when increase the best
prune.carseats <- prune.misclass(tree.carseats, best=15)
plot(prune.carseats)
text(prune.carseats, pretty=0, cex=0.7)
tree.pred <- predict(prune.carseats, Carseats.test, type='class')
table(tree.pred, High.test)
(86+62)/sum(table(tree.pred, High.test))


## 8.3.2 fitting regression trees
library(MASS)
set.seed(1)
train <- sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston <- tree(medv~., Boston, subset=train)
summary(tree.boston)
plot(tree.boston)
text(tree.boston, pretty=0, cex=0.7)
cv.boston <- cv.tree(tree.boston)
names(cv.boston)
plot(cv.boston$size, cv.boston$dev, type='b')
prune.boston <- prune.tree(tree.boston, best=5)
plot(prune.boston)
text(prune.boston, pretty=0)
yhat <- predict(tree.boston, newdata=Boston[-train,])
boston.test <- Boston$medv[-train]
plot(yhat, boston.test)
abline(0,1)
sqrt(mean((yhat-boston.test)^2)) # cv set MSE
# 모델의 예측값이 실제 메디안 주택가격의 $5 이내에 있음


# 8.3.3 bagging and random forests
library(randomForest)
set.seed(1)
length(names(Boston))
bag.boston <- randomForest(medv~., data=Boston, subset=train,
                           mtry=13, importance=TRUE)
bag.boston
# validate
yhat.bag <- predict(bag.boston, newdata=Boston[-train,])
plot(yhat.bag, boston.test)
abline(0,1)
mean((yhat.bag-boston.test)^2)
# set ntree
bag.boston <- randomForest(medv~., data=Boston, subset=train,
                           mtry=13, ntree=25)
yhat.bag <- predict(bag.boston, newdata=Boston[-train,])
mean((yhat.bag-boston.test)^2)
# random forest
set.seed(1)
rf.boston <- randomForest(medv~., data=Boston, subset=train,
                           mtry=6, importance=TRUE)
yhat.rf <- predict(rf.boston, newdata=Boston[-train,])
mean((yhat.rf-boston.test)^2)
importance(rf.boston)
varImpPlot(rf.boston)
# %IncMSE : 모델에서 제외될 때 예측 정확도의 평균 감소량
# IncNodePurity : 분할로 인한 impurity의 총 감소량을 모든 트리에 대해 평균한 것 
# 둘 다 클 수록 중요한 변수


## 8.3.4 boosting
library(gbm)
set.seed(1)
boost.boston <- gbm(medv~., data=Boston[-train,], distribution='gaussian',
                    n.trees=5000, interaction.depth=4)
# n.trees <- limit of number of trees
# interaction.depth <- limit the depth of trees
summary(boost.boston) # show relative importance
# partial dependence plot
plot(boost.boston, i='rm')
plot(boost.boston, i='lstat')
# validate
yhat.boost <- predict(boost.boston, newdata=Boston[-train,], n.trees=5000)
options("scipen" = 100)
mean((yhat.boost-boston.test)^2)
# change lambda
boost.boston <- gbm(medv~., data=Boston[-train,], distribution='gaussian',
                    n.trees=5000, interaction.depth=4, shrinkage=0.2, verbose=F)
yhat.boost <- predict(boost.boston, newdata=Boston[-train,], n.trees=5000)
options("scipen" = 100)
mean((yhat.boost-boston.test)^2)
