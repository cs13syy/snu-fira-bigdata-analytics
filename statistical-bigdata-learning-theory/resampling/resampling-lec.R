# load package
library("ISLR")
library(boot) # to use cv.glm
library(class)


# load data
data(Auto)
dim(Auto)
head(Auto)


# leave-one-out cross validation (LOOCV)
glm.fit = glm(mpg~horsepower, data=Auto) # glm fit
cv.err = cv.glm(Auto, glm.fit) # apply cv to glm model, default of k : leave-one-out cv
cv.err$delta # test MSE, (raw cv estimate, adjusted cv estimate)
cv.error = rep(0,5)
for (i in 1:5){
  glm.fit = glm(mpg~poly(horsepower, i), data=Auto) # i : degree of polynomial
  cv.error[i] = cv.glm(Auto, glm.fit)$delta[1] # each i's test MSE
}
cv.error
plot((1:5),cv.error,type="b") # smallest error when i=5

     
# find knn's k using cv
dim(Caravan)
head(Caravan)
attach(Caravan)
summary(Purchase)
?scale # standard normalized
allX = scale(Caravan[,-86])
allY = Purchase # resonse variable
n = length(allY)

# 6 fold cross validation
misclass = matrix(0,20,6) # content, nrow(l:knn k), ncol(m:k fold)
for (l in (1:20)){
  for (m in (1:6)){
    start = (m-1)*1000+1 # 1, 1001, 2001, 3001, 4001, 5001
    end=m*1000 # 1000, 2000, 3000, 4000, 5000, 6000
    if (m==6){end=n} # k fold = 6 fold
    test.X = allX[start:end,] # ncol = 85
    test.Y = allY[start:end] # ncol = 1
    train.X = allX[-(start:end),]
    train.Y = allY[-(start:end)]
    set.seed(1)
    knn.pred = knn(train.X, test.X, train.Y, k=l) # results of knn prediction
    misclass[l,m]=sum(test.Y!=knn.pred) 
  }
  cat("\n") # apply "\n"
  cat(l) # function is same with print
}
misclass[1,1] # num of different results (when knn k is 1, 1 fold cv)
err = apply(misclass, 1, sum)/n # 1: row, 2: column, misprediction rate
err # mean of misprediction rate of each row(for 1:20 knn's k)
plot(1:20, err, type="o") # 9, 10, 11 fits knn's k

# bootstrap
str(Portfolio)
dim(Portfolio)
head(Portfolio)
alpha.fn = function(data, index){ 
  X = data$X[index] # what does index mean?
  Y = data$Y[index]
  return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
} 
boot(Portfolio, alpha.fn, R=1000) # R : the number of bootstrap replicates

# bootstrap in regression : confidence band
head(Auto)
dim(Auto)
summary(Auto)
attach(Auto)
mpg.fit = lm(mpg~poly(horsepower,5)) # 5th polynomial, x=poly, y=mpg
pred.x = data.frame(horsepower=seq(46,230,1)) # newdata, 46~230 dataframe
mpg.pred = predict.lm(mpg.fit, newdata=pred.x, se.fit=TRUE) # mpg prediction
plot(seq(46,230,1), mpg.pred$fit, type='l', xlab='horsepower', ylab='mpg')
# residual bootstrap
oresid = mpg.fit$resid # difference btw real and estimate
ofit = mpg.fit$fitted # estimate
betaest = mpg.fit$coefficients # beta estimates
n = length(oresid)

# sampling and fitting
B = 1000 # number of sampling
d = length(seq(46,230,1)) # 185
bootfit = matrix(0,B,d) # nrow=1000, ncol=185
bootsamp = bootresid = rep(0,n) # n=392
for (b in (1:B)){ # use for loop for sampling
  sampid = sample(n, n, replace=T) # replacement allowed
  bmpg = ofit+oresid[sampid] # estimate + residual, num=392  
  bmpg.fit = lm(bmpg~poly(horsepower, 5)) # lm fit
  bmpg.pred = predict.lm(bmpg.fit, newdata=pred.x, se.fit=T) # newdata fit
  bootfit[b,] = as.numeric(bmpg.pred$fit) # newdata estimate
  cat("\n")
  cat(b)
}
bse.fit = sqrt(apply(bootfit,2,var)) # bootstrap standard error
ose.fit = mpg.pred$se.fit
r = ose.fit/bse.fit
plot(seq(46,230,1), r, type="l", ylim=c(0.5, 2))
abline(h=1, col="blue") # bse.fit is nearly same with ose.fit
title("ratio of standard errors: theory to bootstrap")

# bootstrap confidence band
upper = mpg.pred$fit + 1.96*bse.fit
lower = mpg.pred$fit - 1.96*bse.fit
plot(seq(46,230,1), mpg.pred$fit, type="l", xlab="horsepower", ylab="mpg", ylim=c(5,40))
lines(seq(46,230,1),upper,col="blue")
lines(seq(46,230,1),lower,col="blue")
title("bootstrap confidence band (pointwise)")
