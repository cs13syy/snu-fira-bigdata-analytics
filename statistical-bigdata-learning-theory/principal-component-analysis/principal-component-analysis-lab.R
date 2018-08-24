# principal component regression
library(pls)
library(ISLR)
str(Hitters)
head(Hitters)
set.seed(2)
pcr.fit=pcr(Salary~., data=Hitters, scale=TRUE, validation="CV")
summary(pcr.fit)
validationplot(pcr.fit, val.type="MSEP")


# train & test set
Hitters=na.omit(Hitters)
x=model.matrix(Salary~., Hitters)[,-1]
y=Hitters$Salary
set.seed(1)
train=sample(1:nrow(x), nrow(x)/2)
test=(-train)
y.test=y[test]
set.seed(1)
pcr.fit=pcr(Salary~., data=Hitters, subset=train, scale=TRUE, validation="CV")
validationplot(pcr.fit, val.type="MSEP")
pcr.pred=predict(pcr.fit, x[test,],ncomp=7)
mean((pcr.pred-y.test)^2)
pcr.fit=pcr(y~x, scale=TRUE, ncomp=7)
summary(pcr.fit)
