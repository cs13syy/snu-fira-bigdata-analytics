####
#### ch3. target marketing
####


#### logistic regression analysis


rm(list=ls())

# load data
setwd('C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/8_고급빅데이터분석(김용대교수님)/chapter-3')
buytest <- read.table('buytest.txt', header=TRUE)
dim(buytest)
names(buytest)


# data preprocessing
buytest[buytest$SEX == "", 'SEX'] = NA
levels(buytest$SEX)[1] = NA
buytest[buytest$ORGSRC == "", 'ORGSRC'] = NA
levels(buytest$ORGSRC)[1] = NA
colnames(buytest)
buydata <- buytest[,-c(1,10,19:26)]
buydata <- buydata[complete.cases(buydata),]
buydata <- model.matrix(~., buydata)[,-1]
head(buydata)
head(buytest)


# train and test set
set.seed(123)
train_ind <- sample(1:nrow(buydata), size=floor((nrow(buydata))*0.7), replace=F)
train <- as.data.frame(buydata[train_ind,])
test <- as.data.frame(buydata[-train_ind,])
train.X <- buydata[train_ind,-1]
train.Y <- buydata[train_ind,1]
test.X <- buydata[-train_ind,-1]
test.Y <- buydata[-train_ind,1]
dim(train.X)
dim(test.X)
# distribution of RESPOND
par(mfrow=c(1,2))
barplot(table(train.Y), main='the distribution of RESPOND in train set')
barplot(table(test.Y), main='the distribution of RESPOND in test set')


# logistic regression
logit <- glm(RESPOND~., data=as.data.frame(buytest), family='binomial')
# summary(logit)

# logistic regression (train)
logit.train <- glm(RESPOND~., data=train, family='binomial')
prob <- predict(logit.train, data=test, type='response')
prob[1:10]

# cutoff
cutoff <- 0.5
ifelse(prob[1:10]>cutoff,1,0)
cutoff <- 1/6
ifelse(prob[1:10]>cutoff,1,0)

# classification function
classification = function(model, newdata, cutoff){
  prob = predict(model, newdata, 'response')
  ifelse(prob>cutoff,1,0)
}

# classification table
table(test$RESPOND, classification(model=logit.train, newdata=test, cutoff=0.5))

crosstable <- function(model, newdata, cutoff){
  table(test$RESPOND, classification(model, newdata, cutoff))
}

crosstable(logit.train, test, 1/4)

# analysis of crosstable
cutoff_res = function(beta_hat = NULL, newx, response, cutoff, pred_prob = NULL){
  if (!is.null(beta_hat)) {
    X = cbind(1,as.matrix(newx)) # 회귀 계수 매트릭스
    pred_prob = 1/(1+exp(-X%*%beta_hat))}
  pred = ifelse(pred_prob> cutoff, 1, 0)
  error_rate = mean(response != pred)
  sensitivity = sum(response == 1 & pred == 1)/sum(response == 1)
  specificity = sum(response == 0 & pred == 0)/sum(response == 0)
  precision = sum(response == 1 & pred == 1)/sum(pred == 1)
  recall = sensitivity
  if (sum(response == 1 & pred == 1) == 0) {f1 = 0}
  else {f1 = 2*(precision*recall)/(precision+recall)} # f-1 score 공식, 정확도와 재현율의 조화평균
  cross_table = table(response, pred)
  return(list(res = c(cutoff, round(error_rate,4), 
                      round(sensitivity,4), round(specificity,4), round(f1, 4)),
              cross_table = cross_table))
} # res: 절단값, 오차율, 민감도, 특이도, f1값 그리고 교차표 출력
cutoff_res(logit.train$coefficients, test.X, test.Y, 1/4)


# ROC curve: x축 1-특이도, y축 민감도
# 민감도는 클수록, 1-특이도는 작을수록 좋다
# 좌상단에 치우칠수록 좋다
prob = predict(logit.train, train, type='response')
# AUC
library(ROCR)
AUC = performance(prediction(prob, train.Y), "auc")
AUC@y.values # area under the curve
ROC = performance(prediction(prob, train.Y), "tpr", "fpr")
plot(ROC, main=paste('ROC curve for train data/n AUC:', round(as.numeric(AUC@y.values),4)),
     col='blue', lwd=2.5)
abline(c(0,0), c(1,1), lty=2, lwd=2)

# select cutoff
cutoff_can <- seq(0.01, 0.99, by=0.01)
cutoff_out = t(sapply(1:length(cutoff_can),
                      function(i) cutoff_res(logit.train$coefficients, train.X,
                                             train.Y, cutoff_can[i])[[1]])) # 1:표, 2:테이블
colnames(cutoff_out) = c("cutoff","error rate","sensitivity","specificity","f1 score")
cutoff_out

# train set 오분류율을 최소화 하는 절단값 선택
cutoff_out[which.min(cutoff_out[,2]),] 
mean(train.Y==1) # train set에서 1인 것의 비율
# 1의 비율 = 오분류율 (1을 다 0으로 봐서 + 1하나 맞추고 1하나 틀림)
cutoff_res(logit.train$coefficients, train.X, train.Y, 
           cutoff_out[which.min(cutoff_out[,2]), 1])[[2]] #0.42로 절단했을 때 교차표

# train set 민감도 0.5이상으로 하는 절단값 선택
cutoff_out[tail(which(cutoff_out[,3] >= 0.5)),]
cutoff_out[tail(which(cutoff_out[,3] >= 0.5), n=1),]
cutoff_sel = cutoff_out[tail(which(cutoff_out[,3] >= 0.5), n=1), 1]
cutoff_res(logit.train$coefficients, train.X, train.Y, cutoff_sel)[[2]]

# train set F1 스코어 최대화하는 절단값 선택
cutoff_out[which.max(cutoff_out[,5]),]
colnames(cutoff_out)
cutoff_res(logit.train$coefficients, train.X, train.Y,
           cutoff_out[which.max(cutoff_out[,5]), 1])[[2]]

# 예측자료에서의 비교
cutoff = c()
cutoff[1] = cutoff_out[which.min(cutoff_out[,2]), 1] # error rate
cutoff[2] = cutoff_out[tail(which(cutoff_out[,3] >= 0.5), n = 1), 1] # sensitivity
cutoff[3] = cutoff_out[which.max(cutoff_out[,5]), 1] # F1 score
as.data.frame(sapply(cutoff, function(cut) cutoff_res(logit.train$coefficients, 
                                                      test.X, test.Y, cut)[[1]]),
              row.names = colnames(cutoff_out))
# 오분류율의 best 기준 아니다
# Vi <- cutoff[i]
