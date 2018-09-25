####
#### ch3. target marketing
####

# load data
setwd('C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/8_고급빅데이터분석(김용대교수님)/chapter-3')
buytest <- read.table('buytest.txt', header=TRUE)
dim(buytest)
names(buytest)

# data preprocessing
buytest[buytest$sex == "", 'SEX'] = NA
levels(buytest$sex)[1] = NA
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
test <- as.data.frame(buydata[,1])
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
logit <- glm(RESPOND~., as.data.frame(buytest), family='binomial')
# summary(logit)

# logistic regression (train)
logit.train <- glm(RESPOND~., data=train, family='binomial')
prob <- predict(logit.train, test, type='response')
prob[1:10]

# cutoff
cutoff <- 0.5
ifelse(prob[1:10]>cutoff,1,0)
cutoff < 1/6
ifelse(prob[1:10]>cutoff,1,0)

# classification function
classification = function(model, newdata, cutoff){
  prob = predict(model, newdata, 'response')
  ifelse(prob>cutoff,1,0)
}

# classification table
table(test$RESPOND, classification(logit.train, test, 0.5))

crosstable <- function(model, newdata, cutoff){
  table(test$RESPOND, classification(model, newdata, cutoff))
}

crosstable(logit.train, test, 1/4)
