# 1. explore the data
library(ISLR)
names(Hitters)
dim(Hitters)
str(Hitters)
sum(is.na(Hitters))
sum(is.na(Hitters$Salary))
Hitters = na.omit(Hitters)
dim(Hitters)
sum(is.na(Hitters))


# 2. best subset selection
library(leaps)
regfit.full = regsubsets(Salary~., Hitters)
summary(regfit.full)
# force-in, force-out은 반드시 모형에서 들어가거나 빠져야 하는 변수들의 인덱스를 지정
# 모형의 크기가 커진 것도 보고 싶으면 nvmax 옵션 사용
regfit.full = regsubsets(Salary~., Hitters, nvmax=19)
reg.summary = summary(regfit.full)
names(reg.summary)
reg.summary$rsq
# r-squared는 변수 개수가 많아질수록 커지는 경향이 있어서, 자주 쓰지는 않음
reg.summary$rsq[1] # 변수 개수 1개일 때 최적의 r-squared 값
# make a plot
par(mfrow=c(2,2))
plot(reg.summary$rss, xlab="Number of Variables", ylab="RSS", type='l') # residual sum of squares, sse
plot(reg.summary$adjr2, xlab="Number of Variables", ylab="Adjusted RSq", type='l')
which.max(reg.summary$adjr2)
points(11, reg.summary$adjr2[11], col="red", cex=2, pch=20)
plot(reg.summary$cp, xlab="Number of Variables", ylab="Cp", type='l')
which.min(reg.summary$cp)
points(10, reg.summary$cp[10], col="red", cex=2, pch=20)
plot(reg.summary$bic, xlab="Number of Variables", ylab="BIC", type='l')
which.min(reg.summary$bic)
points(6, reg.summary$bic[6], col="red", cex=2, pch=20)
par(mfrow=c(1,1))
plot(regfit.full,scale="r2") # rsq랑 같아
plot(regfit.full,scale="adjr2") # aic랑 같아
plot(regfit.full,scale="Cp")
plot(regfit.full,scale="bic") # in-black, notin-white
coef(regfit.full,6) # bic가 가장 정확해서 bic가 default로 되어있는 듯


# 3. forward selection & backward selection
regfit.fwd=regsubsets(Salary~.,data=Hitters,nvmax=19,method="forward")
summary(regfit.fwd)
plot(regfit.fwd)
regfit.bwd=regsubsets(Salary~.,data=Hitters,nvmax=19,method="backward")
summary(regfit.bwd)
plot(regfit.bwd)
# comparison : 6개까지는 같고, 7개부터 달라진다
coef(regfit.full,7)
coef(regfit.fwd,7)
coef(regfit.bwd,7)


# 4. 검증 자료 방법을 이용한 변수 선택
set.seed(1)
nrow(Hitters)
train = sample(c(TRUE,FALSE), nrow(Hitters), rep=TRUE)
test=(!train)
regfit.best = regsubsets(Salary~., data=Hitters[train,], nvmax=19)
test.mat = model.matrix(Salary~., data=Hitters[test,]) # x의 디자인 매트릭스
# model.matrix -> 모형식을 이용해 design matrix를 반환하는 함수
val.errors = rep(NA,19) # 초기값 생성
for(i in 1:19){
  coefi=coef(regfit.best,id=i) # 변수 i개일 때 베타 추정값
  pred=test.mat[,names(coefi)]%*%coefi # test.mat[,names(coefi)]는 x, %*%는 매트리스 곱
  val.errors[i]=mean((Hitters$Salary[test]-pred)^2) # test error
}
val.errors
which.min(val.errors)
coef(regfit.best,10) # 최적의 회귀계수 추정값
# predict
predict.regsubsets=function(object,newdata,id,...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form,newdata)
  coefi=coef(object,id=id)
  xvars=names(coefi)
  mat[,xvars]%*%coefi
}
regfit.best = regsubsets(Salary~., data=Hitters, nvmax=19)
coef(regfit.best, 10)


# 5. k fold cross validation
k=10
set.seed(1)
folds = sample(1:k, nrow(Hitters), replace=TRUE)
cv.errors = matrix(NA,k,19, dimnames=list(NULL, paste(1:19))) # dimnames: 행과 열 이름
# 행은 겹 k, 열은 각 겹에서 변수의 개수
for(j in 1:k){
  best.fit=regsubsets(Salary~.,data=Hitters[folds!=j,],nvmax=19) # j겹이 아닌 데이터에 적합
  for(i in 1:19){
    pred=predict(best.fit, Hitters[folds==j,], id=i) # id는 변수 개수
    cv.errors[j,i] = mean((Hitters$Salary[folds==j]-pred)^2)  
  } # cv.errors[j,i]는 j fold, size i일 때 cv error
}
mean.cv.errors=apply(cv.errors,2,mean) # columnwise, 변수 개수별 평균
mean.cv.errors
plot(mean.cv.errors,type='b')
which.min(mean.cv.errors) # 11
reg.best = regsubsets(Salary~., data=Hitters, nvmax=19)
coef(reg.best, 11) # 최적 모델에서의 계수


# 6. Ridge Regression
x=model.matrix(Salary~., Hitters)[,-1]
# model.matrix -> 모형식을 이용해 design matrix를 반환하는 함수, 가변수 자동 생성
y=Hitters$Salary
# glmnet -> 벌점가능도 추정치 구하는 함수, 모형식이 아닌 설명변수와 반응변수를 행력과 벡터로 대입해야 
library(glmnet)
grid=10^seq(10,-2,length=100) # 10^seq의 뜻? 10에서 10^(-2)까지 100개의 random lambda
ridge.mod=glmnet(x,y,alpha=0,lambda=grid) # alpha=0이면 ridge, 변수 자동 표준화
dim(coef(ridge.mod)) # 100개 lambda 값에 따른 추정된 회귀계수 값, 20은 변수 개수
ridge.mod$lambda[50] # 50번째 lambda 값
coef(ridge.mod)[,50] # 50번째 lambda 값에 해당되는 추정된 회귀계수 값
sqrt(sum(coef(ridge.mod)[-1, 50]^2)) # L2 norm
ridge.mod$lambda[60]
coef(ridge.mod)[,60]
sqrt(sum(coef(ridge.mod)[-1, 60]^2)) # L2 norm
predict(ridge.mod, s=50, type="coefficients")[1:20,] # s는 lambda 값 지정 옵션
# type이 "response"이면 예측값(gaussian)이나 예측확률(binomial)을 준다
# type="coefficients"는 추정된 회귀계수 값

# train set, test set
set.seed(1)
train=sample(1:nrow(x), nrow(x)/2) # 후보, 개수
test=(-train)
y.test=y[test]
ridge.mod=glmnet(x[train,],y[train],alpha=0,lambda=grid,thresh=1e-12)
ridge.pred=predict(ridge.mod,s=4,newx=x[test,]) # lambda=4
mean((ridge.pred-y.test)^2) # 예측y-실제y
mean((mean(y[train])-y.test)^2) # 훈련y-실제y
ridge.pred=predict(ridge.mod,s=1e10,newx=x[test,]) # lambda=1e10
mean((ridge.pred-y.test)^2)
ridge.pred=predict(ridge.mod,s=0,newx=x[test,]) # lambda=0
mean((ridge.pred-y.test)^2)
# lm = (lambda=0)
lm(y~x,subset=train)
predict(ridge.mod,s=0,exact=T,type="coefficients")[1:20,] # exact?

# try k-fold cv & find best lambda
set.seed(1)
cv.out=cv.glmnet(x[train,],y[train],alpha=0)
# cv.glmnet은 k겹 교차검증 수행 함수, 옵션 nfold는 겹 수 k이고, 디폴트는 10
plot(cv.out)
bestlam=cv.out$lambda.min
bestlam
ridge.pred=predict(ridge.mod,s=bestlam,newx=x[test,])
mean((ridge.pred-y.test)^2)
out=glmnet(x,y,alpha=0) # ridge 적합
predict(out,type="coefficients",s=bestlam[1:20,])


# 7. the Lasso
lasso.mod=glmnet(x[train,], y[train], alpha=1, lambda=grid) # alpha=1, 라쏘
plot(lasso.mod)

set.seed(1)
cv.out=cv.glmnet(x[train,], y[train], alpha=1)
plot(cv.out)
bestlam=cv.out$lambda.min
lasso.pred=predict(lasso.mod, s=bestlam, newx=x[test,])
mean((lasso.pred-y.test)^2)
out=glmnet(x,y,alpha=1,lambda=grid)
lasso.coef=predict(out,type="coefficients",s=bestlam)[1:20,]
lasso.coef # lasso에서 변수로 선택된 것
lasso.coef[lasso.coef!=0] # lasso에서 변수로 선택되지 못한 것
