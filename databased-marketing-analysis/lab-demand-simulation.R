setwd("C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/9_데이터기반마케팅애널리틱스(송인성교수님)")

didmarket = read.csv('didmarket.csv')
View(didmarket)

# brand
#	1. Dove
#	2. Palmolive
#	3. Dawn
#	4. Joy
#	5. Cascade
#	6. Ivory
#	7. Dominicks


# check demand with log-log model
# variables are arranged by brand in ascending order
v = matrix(didmarket$volume,ncol=7)
pr = matrix(didmarket$price,ncol=7)
pm = matrix(didmarket$promo,ncol=7)
w = matrix(didmarket$wpr,ncol=7)

b = matrix(0,nrow=7,ncol=9) # 9=intercept+7brands+pm
for (k in 1:7){ # for each brand
  tempb = lm(log(v[,k])~log(pr)+pm[,k]) # all price data
  b[k,]=tempb$coefficients # b's each row have 9 coefs
  print(summary(tempb)) # lm summary for each brand
}


# fit the model logS(k) = logPr(1,..,7)+logLaggedS(k) with 1 year data (11~62 weeks)
b1= matrix(0, nrow=7, ncol=9) # row=brand
for (k in 1:7){
  tempb = lm(log(v[11:62,k])~log(pr[11:62,])+log(v[10:61,k])) # lagged sales
  b1[k,]=tempb$coefficients
  print(summary(tempb))
}
# b1의 대각원소 = 자기탄력성(except intercept)


# expected profit at average price and average wholesale price
avgpr = colMeans(pr[11:62,]) # average price for each brand
avgwp = colMeans(w[11:62,]) # average wholesale price for each brand
avgv = colMeans(v[11:62,]) # average volume for each brand
avgvlag = colMeans(v[10:61,]) # average lagged volume for each brand

# 평균 가격에서 우리가 predict하는 이익
predictor = cbind(rep(1,7),t(matrix(rep(log(avgpr),7),nrow=7)),log(avgvlag))
# rep(1,7) -> c(1, 1, 1, 1, 1, 1, 1)
# t(matrix(rep(log(avgpr),7),nrow=7)) -> each column has 7 same avgpr
# log(avgvlag) -> 7 avgvlag for each brand 
predictedv = exp(rowSums(predictor*b1))
# 판매량, b1=회귀계수, predictor=x값
# log에 exp 취해 실제 volume 계산
predictedprofit = sum(predictedv*(avgpr-avgwp))
# predictedv*(avgpr-avgwp) -> 브랜드 별 이익
# avgpr-avgwp = 평균가격-평균원가 = 이익

weightedprice = sum(predictedv*avgpr)/sum(predictedv)

bound = weightedprice*0.05

profit = function(newprice){
  
  if (max(abs((newprice-avgpr)/avgpr))>0.05) npredictedprofit = max(abs((newprice-avgpr)/avgpr))*(-10000) # 제약 위반시
  else {
    npredictor = cbind(rep(1,7),t(matrix(rep(log(newprice),7),nrow=7)),log(avgvlag))
    npredictedv = exp(rowSums(npredictor*b1)) # predicted volume
    nweightedprice = sum(npredictedv*newprice)/sum(npredictedv)
    
    if (abs(nweightedprice-weightedprice)>bound) npredictedprofit = abs(nweightedprice-weightedprice)*(-10000)
    else npredictedprofit = sum(npredictedv*(newprice-avgwp)) # 판매량*(가격-마진)
  }
  return(-npredictedprofit) # optim은 minimize니까 - 붙임

}


optprice = optim(avgpr,profit,control=list(maxit=5000)) # 리스트 형식
# $value : -npredictedprofit
# $convergence : 0이면 잘 한 것
print(cbind(avgpr,optprice$par,optprice$par/avgpr-1))
