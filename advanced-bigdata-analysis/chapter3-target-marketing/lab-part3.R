####
#### ch3. target marketing
####

#### case-control sampling

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


# train and test set
set.seed(123)
train_ind <- sample(1:nrow(buydata), size=floor((nrow(buydata))*0.7), replace=F)
train <- as.data.frame(buydata[train_ind,])
test <- as.data.frame(buydata[-train_ind,])
train.X <- buydata[train_ind,-1]
train.Y <- buydata[train_ind,1]
test.X <- buydata[-train_ind,-1]
test.Y <- buydata[-train_ind,1]


# auc calculating function
auc_res = function(beta = NULL, newx, newy, pred_prob = NULL){ 
  if (!is.null(beta)){
    X = cbind(1,as.matrix(newx))
    pred_prob = 1/(1+exp(-X%*%beta))    }
  AUC = performance(prediction(pred_prob , newy) , "auc")
  return(AUC@y.values[[1]])
}


# sampling
n1 = sum(train.Y == 1)
set.seed(6)
cc_ind = sample(1:sum(train.Y==0),
                size=2*n1, replace=F)
cc_data = rbind(train[train.Y==1,],
                train[train.Y==0,][cc_ind,])
cc_data = cc_data[sample(1:nrow(cc_data), nrow(cc_data), replace=F),]
table(cc_data$RESPOND)
dim(cc_data)

tol_iter = 50
beta_list = list()
set.seed(6)
for (iter in 1:tol_iter){
  cc_ind = sample(1:sum(train.Y==0),
                  size=2*n1, replace=F)
  cc_data = rbind(train[train.Y == 1,],
                  train[train.Y == 0,][cc_ind,])
  beta_list[[iter]] = coef(glm(RESPOND~., data=cc_data, family='binomial'))
}

train_pred_probs = sapply(1:tol_iter, function(iter) 1/(1+exp(-cbind(1, train.X)%*%beta_list[[iter]])))
train_pred_probs = rowMeans(train_pred_probs)
test_pred_probs = sapply(1:tol_iter, function(iter) 1/(1+exp(-cbind(1, test.X)%*%beta_list[[iter]])))
test_pred_probs = rowMeans(test_pred_probs)

auc_res(newx=train.X, newy=train.Y, pred_prob=train_pred_probs)
auc_res(newx=test.X, newy=test.Y, pred_prob=test_pred_probs)
