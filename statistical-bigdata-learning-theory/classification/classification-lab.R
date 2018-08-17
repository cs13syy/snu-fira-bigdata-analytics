# set directory ====================
getwd()
setwd("C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/5_통계적빅데이터학습이론(임요한교수님)/classification/data")


# insurance ========================
library(ggplot2)
ins <- read.csv("insurance.csv", header = TRUE)
dim(ins) # dependent variables 10, data 65535
colnames(ins)
ins=ins[,-c(3,4)] # numclaims, claimcst0 제거
ins$clm=as.factor(ins$clm)
head(ins)
ggplot(data=ins, aes(x=exposure, y=veh_value)) + geom_point(alpha=0.1, aes(color=clm))
ggplot(data=ins, aes(x=clm, y=exposure)) + geom_boxplot()


# alzheimer ========================
load("AlzheimerDisease.RData")
dim(predictors)
head(predictors, n=1)
# knn r code
library(class)
train.X = predictors[1:250, 1:129] # train data 250개
test.X = predictors[251:333, 1:129] # test data 83개
train.Y = as.numeric(diagnosis[1:250]) # 반응변수 = diagnosis 팩터값
test.Y = as.numeric(diagnosis[251:333]) # 반응변수 = diagnosis 팩터값
set.seed(1)
knn.pred.1=knn(train=train.X, test=test.X, cl=train.Y, k=1, prob=TRUE)
knn.pred.3=knn(train=train.X, test=test.X, cl=train.Y, k=3, prob=TRUE)
knn.pred.5=knn(train=train.X, test=test.X, cl=train.Y, k=5, prob=TRUE)
# results of knn
A <-table(test.Y, knn.pred.1)
sum(A)
p1 = sum(diag(A))/sum(A) # k=1, 맞출 확률
B <-table(test.Y, knn.pred.3)
sum(B)
p3 = sum(diag(B))/sum(B) # k=3, 맞출 확률
C <-table(test.Y, knn.pred.5)
sum(C)
p5 = sum(diag(C))/sum(C) # k=5, 맞출 확률
p1; p3; p5


# credit default ===================
creditdefault = read.csv("creditdefault.csv", header=T)
dim(creditdefault) # 데이터 30000개, 변수 24개
str(creditdefault)
creditdefault[,3]=as.factor(creditdefault[,3]) # sex, edu, marriage의 팩터변환
train.X=creditdefault[1:25000,1:23] # train data 25000개
test.X=creditdefault[25001:30000,1:23] # test data 5000개
train.Y=creditdefault[1:25000,24] # 반응변수 = 24번째 변수
test.Y=creditdefault[25001:30000,24] # 반응변수 = 24번째 변수
test=creditdefault[25001:30000,] 
X=train.X # 반응변수 없이 설명변수만 있는 25000개 데이터
head(X,n=1)

# knn exercise (y = 1, 2, 4, 5)
colnames(creditdefault)
train.X=creditdefault[1:25000,c("LIMIT_BAL", "SEX", "MARRIAGE", "AGE")]
test.X=creditdefault[25001:30000,c("LIMIT_BAL", "SEX", "MARRIAGE", "AGE")] 
train.Y=creditdefault[1:25000,24] # 반응변수 = 24번째 변수
test.Y=creditdefault[25001:30000,24] # 반응변수 = 24번째 변수
set.seed(2)
knn.pred.17=knn(train=train.X, test=test.X, cl=train.Y, k=17, prob=TRUE)
knn.pred.27=knn(train=train.X, test=test.X, cl=train.Y, k=27, prob=TRUE)
knn.pred.37=knn(train=train.X, test=test.X, cl=train.Y, k=37, prob=TRUE)
knn.pred.47=knn(train=train.X, test=test.X, cl=train.Y, k=47, prob=TRUE)
knn.pred.57=knn(train=train.X, test=test.X, cl=train.Y, k=57, prob=TRUE)
# evaluate results of knn - 1
igroup <- c()
pgroup <- c()
for (i in 1:50) {
  knn.pred = knn(train=train.X, test=test.X, cl=train.Y, k=i, prob=TRUE)
  A <- table(test.Y, knn.pred)
  sum(A)
  p <- sum(diag(A))/sum(A)
  pgroup <- c(pgroup, p)
}
max(pgroup)
which.max(pgroup) # index : 33, 분류율 가장 높은
# evaluate results of knn - 2
result <- numeric()
k = 30:40
for(i in k){
  knn.pred <- knn(train.X, test.X, train.Y, k=i)
  t <- table(test.Y, knn.pred)
  result[i-29] <- (t[1,1]+t[2,2])/sum(t)
}
sort(result, decreasing = T)
max(result)
which(result==max(result)) # index = 30 + 4 - 1 = 33 


# S&P 500 ==========================
library(ISLR)
dim(Smarket)
str(Smarket)
names(Smarket)
summary(Smarket)
summary(Smarket[,c(1, 7, 8, 9)])
pairs(Smarket)
cor(Smarket[,-9]) # volume&year=0.54

# train and test set
train = (Smarket$Year<2005)
Smarket.2005 = Smarket[!train,] # test set
dim(Smarket.2005)
Direction.2005 = Smarket$Direction[!train] # test set의 반응변수값
train.X = cbind(Smarket$Lag1,Smarket$Lag2)[train,] # lag1, lag2로 direction 예측
test.X = cbind(Smarket$Lag1,Smarket$Lag2)[!train,]
train.Direction = Smarket$Direction[train] # 반응변수는 direction
# k = 1
knn.pred.1 = knn(train.X, test.X, train.Direction, k=1, prob=TRUE)
table.1 <- table(knn.pred.1, Direction.2005)                
p.1 <- sum(diag(table.1))/sum(table.1)             
# k = 3      
knn.pred = knn(train.X, test.X, train.Direction, k=3, prob=TRUE)
table <- table(knn.pred, Direction.2005)                
p <- sum(diag(table))/sum(table)        
# Finding how many % of them are correctly predicted
mean(knn.pred==Direction.2005) # 맞출 확률

# logistic regression preview
glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial)
summary(glm.fit)
coef(glm.fit) # 로지스틱 적합 결과 회귀 계수
summary(glm.fit)$coef # 회귀 계수 관련 데이터
summary(glm.fit)$coef[,4] # 회귀 계수의 p-value
glm.probs = predict(glm.fit, type="response") # newdata 없음, 적합한 자료의 예측값 반환
class(glm.probs) # numeric
glm.probs[1:10] # type='link', type='response'

# 반응변수 y 값을 0.5 기준으로 팩터 변환
glm.pred = rep("Down",1250) # "Down" 1250개
glm.pred[glm.probs >.5] = "Up"
table(glm.pred,Smarket$Direction)
mean(glm.pred==Smarket$Direction) # 맞춘 확률의 평균

# logistic regression
# train
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,
            family=binomial,subset=train) # glm 적합
glm.probs=predict(glm.fit,Smarket.2005,type="response") # 예측값 저장
dim(Smarket.2005) # 252개 행
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Smarket$Direction) # 맞출 확률의 평균
mean(glm.pred!=Smarket$Direction) # 틀린 확률의 평균
# test set
glm.fit=glm(Direction~Lag1+Lag2,data=Smarket,
            family=binomial,subset=train) # train = (Smarket$Year<2005)
class(train)
head(train)
glm.probs=predict(glm.fit,Smarket.2005,type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
106/(106+76)
predict(glm.fit,newdata=data.frame(Lag1=c(1.2,1.5),Lag2=c(1.1,-0.8)),type="response") # predict new data


# linear discriminant analysis =====
library(MASS)
lda.fit = lda(Direction~Lag1+Lag2, data=Smarket, subset=train) # lda 적합
lda.fit
plot(lda.fit)
lda.pred = predict(lda.fit, Smarket.2005) # test set
names(lda.pred)
lda.class=lda.pred$class # up and down
table(lda.class,Direction.2005)
mean(lda.class==Direction.2005) # 맞출 확률
(35+106)/sum(table(lda.class,Direction.2005)) # 맞출 확률
sum(lda.pred$posterior[,1]>=.5) # posterior?
sum(lda.pred$posterior[,1]<.5)
lda.pred$posterior[1:20,1]
lda.class[1:20]


# quadratic discriminant analysis ==


# knn x=(lag1, lag2)================
library(class)
train = (Smarket$Year<2005)
train.X = cbind(lag1,lag2)[train,]
test.X = cbind(lag1,lag2)[!train,]
train.Direction = Direction[train] # Direction is column
set.seed(1)
knn.pred.1 = knn(train.X, test.X, train.Direction, k=1)
knn.table.1 = table(knn.pred.1,Direction.2005)
knn.table.1
(43+83)/sum(knn.table.1) # 0.5
knn.pred.3 = knn(train.X, test.X, train.Direction, k=3)
knn.table.3 = table(knn.pred.3,Direction.2005)
knn.table.3
(48+85)/sum(knn.table.3) # 0.5277778
knn.pred.5 = knn(train.X, test.X, train.Direction, k=3)
knn.table.5 = table(knn.pred.5,Direction.2005)
knn.table.5
(48+87)/sum(knn.table.5) # 0.5357143


# exercise : caravan ===============
dim(Caravan) # 5822, 86
str(Caravan) # response variable : purchase
# standardize
standardized.X = scale(Caravan[,-86]) # scale 표준화
var(Caravan[,1])
var(Caravan[,2])
var(standardized.X[,1]) # variance : 1
var(standardized.X[,2]) # variance : 1
# knn
test=1:1000
train.X = standardized.X[-test,] # several columns, need comma
test.X = standardized.X[test,]
train.Y = Caravan$Purchase[-test] # one column, no comma
test.Y = Caravan$Purchase[test]
set.seed(1)
knn.pred.1 = knn(train.X, test.X, train.Y, k=1)
mean(test.Y!=knn.pred.1) # 틀릴 확률
mean(test.Y!="No") # "Yes"인 확률
knn.table.1 = table(knn.pred.c, test.Y)
knn.table.1
(873+9)/sum(table.c) # 맞출 확률
knn.pred.3=knn(train.X,test.X,train.Y,k=3)
table(knn.pred.3,test.Y)
knn.pred.5=knn(train.X,test.X,train.Y,k=5)
table(knn.pred.5,test.Y)
# glm
glm.fit=glm(Purchase~., data=Caravan, family=binomial, subset=-test)
glm.probs=predict(glm.fit, Caravan[test,], type="response")
glm.pred=rep("No",1000)
glm.pred[glm.probs>.5]="Yes"
table(glm.pred,test.Y)
glm.pred=rep("No",1000)
glm.pred[glm.probs>.25]="Yes"
table(glm.pred,test.Y)
11/(22+11)
