# 1. global options
# opts_chunk$set(eval=TRUE, cache=TRUE, fig.width=7, fig.height=4)


# 2. read data
library("ISLR")
data(Auto)
dim(Auto)
head(Auto)
Auto$horsepower = as.numeric(Auto$horsepower)
attach(Auto)


# 3. find k for k-th polynomial regression
random.seed(1)
train = sample(392,193)
lm.fit = lm(mpg~horsepower, data=Auto, subset=train)
mean((mpg-predict(lm.fit, Auto))[-train]^2) # MSE 
lm.fit2 = lm(mpg~poly(horsepower,2), data=Auto, subset=train)
mean((mpg-predict(lm.fit2, Auto))[-train]^2) # MSE
lm.fit3 = lm(mpg~poly(horsepower,3), data=Auto, subset=train)
mean((mpg-predict(lm.fit3, Auto))[-train]^2) # MSE
# change the num of random.seed
random.seed(2)
train = sample(392,193)
lm.fit = lm(mpg~horsepower, data=Auto, subset=train)
mean((mpg-predict(lm.fit, Auto))[-train]^2) # MSE 
lm.fit2 = lm(mpg~poly(horsepower,2), data=Auto, subset=train)
mean((mpg-predict(lm.fit2, Auto))[-train]^2) # MSE
lm.fit3 = lm(mpg~poly(horsepower,3), data=Auto, subset=train)
mean((mpg-predict(lm.fit3, Auto))[-train]^2) # MSE


# 4. leave-one-out cross validation
# (1) make glm fit
glm.fit = glm(mpg~horsepower, data=Auto) # family default is gaussian
coef(glm.fit)
lm.fit = lm(mpg~horsepower, data=Auto)
coef(lm.fit)
# (2) load boot and call cv.glm
library(boot)
cv.err = cv.glm(Auto, glm.fit) # K defult is leave-one-out
names(cv.err)
str(cv.err)
cv.err$delta # [1]leave-one-out sd
cv.err = rep(0,5)
for (i in 1:5){
  glm.fit = glm(mpg~poly(horsepower,i), data=Auto)
  cv.err[i] = cv.glm(Auto, glm.fit)$delta[1]
}
cv.err
plot((1:5), cv.err, ylim=c(15,50), xlab="num of polynomial",
     pch=20, col="blue")


# 5. k fold cross validation
set.seed(17)
cv.error.10 = rep(0, 10)
for (j in 1:10){
  glm.fit.10 = glm(mpg~poly(horsepower,j), data=Auto)
  cv.err.10 = cv.glm(glm.fit.10, data=Auto, K=10)
  cv.error.10[j] = cv.err.10$delta[1]
}
cv.error.10
plot((1:10), cv.error.10, xlab="num of k", pch=20, col="red")


# 6. bootstrap
alpha.fn=function(data,index){
X=data$X[index]
Y=data$Y[index]
return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
}

str(Portfolio)
dim(Portfolio)
head(Portfolio)
alpha.fn(Portfolio,1:100)

set.seed(1)
alpha.fn(Portfolio, sample(100,100,replace=T))
boot(Portfolio, alpha.fn, R=1000) # statistics is alpha.fn, R is num of sampling


# 7. estimating the accuracy of a linear regression model
boot.fn = function(data,index){
  return(coef(lm(mpg~horsepower,data=data,subset=index)))
}
boot.fn(Auto,1:392)
set.seed(1)
boot.fn(Auto,sample(392,392,replace=T))
boot(Auto,boot.fn,1000)
summary(lm(mpg~horsepower,data=Auto))$coef

boot.fn=function(data,index){
  coefficients(lm(mpg~horsepower+I(horsepower^2),data=data,subset=index)) 
}
set.seed(1)
boot(Auto,boot.fn,1000)
summary(lm(mpg~horsepower+I(horsepower^2),data=Auto))$coef
