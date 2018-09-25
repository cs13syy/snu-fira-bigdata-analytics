####
#### ch3. target marketing
####

#### variable selection and penalty method

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



#---- logistic regression (train)
logit.train <- glm(RESPOND~., data=train, family='binomial')


#---- Forward selection (AIC 기준)
null <- glm(RESPOND~1, data=train)
full <- glm(RESPOND~., data=train)
forward <- step(null, scope=list(lower=null, upper=full),
                data=train, direction='forward')
summary(forward)
# AIC를 최소화하는 변수들 select, 총 10개 선택
# 수정했다고 해서 변수들이 다 유의한 것은 아님 (단지 AIC 기준으로 선택했을 뿐)


# linear regression의 과대적합 및 다중공선성 해결
# 회귀계수에 벌점함수를 줌 -> ridge & lasso
#---- logistic + ridge
library(glmnet)
ridge.fit <- glmnet(train.X, as.factor(train.Y), alpha=0, family='binomial')
ridge.fit$lambda[c(1,10,100)] # alpha=0 이면 ridge
ridge.fit$beta[,c(1,10,100)] # lambda에 따라 회귀계수 달라짐


#---- logistic + ridge with 10-fold cv
set.seed(1)
cv.ridge = cv.glmnet(train.X, as.factor(train.Y), alpha=0,
                     family='binomial')
names(cv.ridge)
bestlam = cv.ridge$lambda.min
ridge.fit <- glmnet(train.X, as.factor(train.Y), alpha=0, 
                 lambda=bestlam, family='binomial')
ridge.fit$beta # 회귀계수 크기가 다중회귀에 비해 축소(벌점 함수)


#---- logistic + lasso
lasso.fit <- glmnet(train.X, as.factor(train.Y), alpha=0,
                    family='binomial')
lasso.fit$lambda[c(1,5,10)]
lasso.fit$beta[,c(1,5,10)]


#---- logistic + lasso with 10-fold cv
set.seed(1)
cv.lasso <- cv.glmnet(train.X, as.factor(train.Y), alpha=1,
                      family='binomial')
bestlam = cv.lasso$lambda.min
lasso.fit <- glmnet(train.X, as.factor(train.Y), alpha=1,
                    lambda=bestlam, family='binomial')
lasso.fit$beta



#----모형별 회귀계수 저장
beta_hat = logit.train$coefficients

#----forward selection
tmp = forward$coefficients
beta_forward = c()
for (i in 1:length(beta_hat)){
  if (names(beta_hat)[i] %in% names(tmp)) beta_forward[i] = tmp[names(beta_hat)[i]]
  else beta_forward[i] = 0
}
beta_hat = cbind(beta_hat, beta_forward)

#----ridge & lasso
beta_hat <- cbind(beta_hat, c(ridge.fit$a0, as.vector(ridge.fit$beta)),
                  c(lasso.fit$a0, as.vector(lasso.fit$beta))) # a0 = intercept
colnames(beta_hat)[3:4] <- c("beta_ridge", "beta_lasso")
head(beta_hat)



#---- model evaluation(모형별 AUC 값 비교)
library(ROCR)

# 각 모형에 대해 예측값 구해서 AUC 계산하는 함수
auc_res = function(beta = NULL, newx, newy, pred_prob = NULL){ 
  if (!is.null(beta)){
    X = cbind(1,as.matrix(newx))
    pred_prob = 1/(1+exp(-X%*%beta))    }
  AUC = performance(prediction(pred_prob , newy) , "auc")
  return(AUC@y.values[[1]])
}
auc_table = rbind(sapply(1:4, function(i) auc_res(beta_hat[,i], train.X, train.Y)),
                  sapply(1:4, function(i) auc_res(beta_hat[,i], test.X, test.Y)))
rownames(auc_table) = c('Training set', 'Test set')
colnames(auc_table) = model_names = c('Logistic','Logistic+AIC', 'Ridge', 'LASSO')
auc_table # 모형 4개 * train set & test set의 AUC



# 학습자료에서의 각 기준에 따른 절단값 찾기
cut_sel = matrix(0, nrow = 4, ncol = 3)
cutoff_can = seq(0.01, 0.99, by=0.01)
for (i in 1:4){
  cutoff_out =  t(sapply(1:length(cutoff_can),
                         function(j) cutoff_res(beta_hat[,i], train.X,
                                                train.Y, cutoff_can[j])[[1]]))
  cut_sel[i, 1] = cutoff_out[which.min(cutoff_out[,2]), 1] # 오분류율 최소화
  cut_sel[i, 2] = cutoff_out[tail(which(cutoff_out[,3] >= 0.5), n = 1), 1] # 민감도 0.5 이상
  cut_sel[i, 3] = cutoff_out[which.max(cutoff_out[,5]), 1] # f1값 최대화
}
# cut_sel 열 <- 오분류율 최소화, 민감도 0.5 이상, f1 최대화
# cut_sel 행 <- 모형 4개
# 각 절단값에 따라 test set 의 결과 출력



# 오분류율 최소화
matrix(t(sapply(1:4, function(i) cutoff_res(beta_hat[,i], test.X, 
                                            test.Y, cut_sel[i, 1])[[1]])), nrow = 4,
       dimnames =list(model_names, c("cutoff","error rate","sensitivity","specificity","f1 score")))

# 민감도 0.5이상
matrix(t(sapply(1:4, function(i) cutoff_res(beta_hat[,i], test.X, 
                                            test.Y, cut_sel[i, 2])[[1]])), nrow = 4,
       dimnames =list(model_names, c("cutoff","error rate","sensitivity","specificity","f1 score")))

# f1값 최대화
matrix(t(sapply(1:4, function(i) cutoff_res(beta_hat[,i], test.X, 
                                            test.Y, cut_sel[i, 3])[[1]])), nrow = 4,
       dimnames =list(model_names, c("cutoff","error rate","sensitivity","specificity","f1 score")))
