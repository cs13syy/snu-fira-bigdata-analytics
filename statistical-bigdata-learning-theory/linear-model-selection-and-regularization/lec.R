# the lasso에서 유의성 검정 (bootstrap)
# the data
library(glmnet)
library(ISLR)
Hitters=na.omit(Hitters)
str(Hitters)
dim(Hitters)
attach(Hitters)

# set x and y
x=model.matrix(Salary~., Hitters)[,-1]
y=Hitters$Salary


# bootstrap (boot 함수 원리와 동일)
n=263
B=1000
best=matrix(0,B,20) # 내용0, 행개수B, 열개수20=설명변수19개+intercept
for (b in (1:B)){
  bid=sample(n,n,replace=T) # random matrix, 인덱스
  bx=x[bid,] # 설명변수 랜덤 뽑음, bootstrap resampling
  by=y[bid] # 그에 따른 반응변수
  grid=10^seq(4,-1,length=100)
  cv.out=cv.glmnet(bx,by,alpha=1,lambda=grid) 
  # cv.glmnet? cv를 가장 작게 하는 tuning parameter 결정하려고 쓰는 식, alpha=1이면 라쏘
  blamb=cv.out$lambda.min # cv를 가장 작게 하는 람다값
  lasso.mod=glmnet(bx,by,alpha=1,lambda=exp(blamb)) # 왜 exp? 그냥
  best[b,]=as.vector(coef(lasso.mod))
  
  cat("\t b=")
  cat(b)
}

lasso.mod=glmnet(x,y,alpha=1,lambda=exp(blamb)) # 최적의 lambda 넣어 lasso 적합
summary(lasso.mod)
est=as.vector(coef(lasso.mod)) # 계수 추정값
se=sqrt(apply(best,2,var)) # 표로 안보고 따로 계산하는 경우: 계산을 위해
tstat=est/se
tstat
pvalue=2*(1-pnorm(abs(tstat)))
pvalue

select=(best!=0) # 값이 0이 아닌 유의한 계수에게는 TRUE를 줌
stab=apply(select,2,sum)/B # 20개, 빈도수가 의미하는 것은? 1000번 중에 몇 번 나왔나, 많이 나온거면 유의한 것
numselect=apply(select,1,sum) # 1000개 랜덤 모델에서 변수 선택에서 선택된 계수의 숫자
hist(numselect) # 선택된 변수의 개수의 빈도에 대한 histogram
