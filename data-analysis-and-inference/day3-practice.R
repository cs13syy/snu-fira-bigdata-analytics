#기술통계


# ----------------------------
#이산형(categorical, 카테고리로 값이 나눠진 경우)
?VADeaths
VADeaths # 1940년 버지니아 주 1000명 당 사망률
summary(VADeaths)
#summary : 데이터의 요약 통계치를 확인할 수 있다


# ----------------------------
#막대그래프
barplot(VADeaths, beside = TRUE, col = c("lightblue", "mistyrose", "lightcyan","lavender", "cornsilk"), legend = rownames(VADeaths), ylim = c(0, 100))
title(main = "Death Rates in Virginia", font.main = 4)
#axis 활용하면 다양하게 설정할 수 있다
#beside = TRUE : 각각의 값마다 막대그래프를 그림


# ----------------------------
#원그래프
pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
names(pie.sales) <- c("Blueberry", "Cherry", "Apple", "Boston Cream", "Other", "Vanilla Cream")
pie.sales #이름과 값이 매칭된 pie.sales 벡터

#기본
pie(pie.sales) # 원그래프 그리기
title(main = "Sales", font.main = 4)

#원그래프 크기, 방향 설정
#clockwise=T : 반시계 방향, radius=1 : 반지름이 1  
pie(pie.sales, radius=1, clockwise=T)
title(main = "Sales", font.main = 4)

#원그래프에 숫자 표시
piepercent<- round(100*pie.sales/sum(pie.sales), 1) #소수 첫째자리에서 반올림
piepercent
pie(pie.sales, labels=piepercent, col=rainbow(length(pie.sales)))
#labels=piepercent : 원그래프에 숫자 표시
title(main = "Sales", font.main = 4)
legend('topright', names(pie.sales), cex = 0.7, fill=rainbow(length(pie.sales)))
#원그래프를 색상으로 나타낼 때 col아닌 fill 사용해야 한다
       

# ----------------------------
#연속형
#히스토그램
?faithful #미국 옐로우스톤 국립공원 간헐천의 분화 시간과 분화 간 시간 (단위: 분)
data("faithful") #데이터 셋 호출하기, 그냥 faithful가 무슨 차이?
faithful
head(faithful)
summary(faithful)

x<-faithful$eruptions
hist(x)
hist(x, breaks=20) #정수를 넣으면 그 개수만큼 바가 생기고
#break에 벡터를 입력하면 구간이 됨 (65, 66행 참조)
hist(x, breaks=20, freq=FALSE) #면적의 합 1
#freq=FALSE : y축에 density 표현, 이것이 상대도수?

#hist 그릴 때는 x축을 어떻게 나누느냐(계급구간의 길이)가 중요
par(mfrow=c(1,2)) #par은 layout 창 옵션, 비교 목적, 1행 2열의 레이아웃 잡기
edge1<-seq(from=1,to=6,by=0.4) #x축 나누기, 0.4 간격으로
edge2<-seq(from=1,to=6,by=1) #x축 나누기, 1 간격으로
hist(x,breaks=edge1,freq=F,xlim=c(0,6),ylim=c(0,0.6),main="h=0.4")
hist(x,breaks=edge2,freq=F,xlim=c(0,6),ylim=c(0,0.6),main="h=1")
#너무 잘게 자르면 데이터가 비는 경우 있어서 적당한 점 찾아야

#줄기-잎 그림 (왼쪽으로 90도 돌리면 hist)
stem(faithful$eruptions)
stem(faithful$waiting)


# ----------------------------
#산점도(x와 y의 관계를 보자)
#type='n' : nothing 많이 사용되는 기술
par(mfrow=c(1,1))
plot(iris$Petal.Length,iris$Petal.Width,xlab='Sepal.Length',
    ylab='Sepal.Width',cex.lab=1,cex.axis=1,type='n',cex=2)
#cex.axis? y축에 출력되는 수치형 라벨의 문자 크기
points(iris$Petal.Length[iris$Species=='setosa'],
    iris$Petal.Width[iris$Species=='setosa'],col='red',lwd=2)
#lwd? 선의 두께. points 함수와는 상관 없는 것 같다
points(iris$Petal.Length[iris$Species=='versicolor'],
    iris$Petal.Width[iris$Species=='versicolor'],col='blue',lwd=2)
points(iris$Petal.Length[iris$Species=='virginica'],
    iris$Petal.Width[iris$Species=='virginica'],col='green',lwd=2)
       

# ----------------------------
#평균 & 분산
n=length(faithful$eruptions)
n # 272개의 데이터
sum((faithful$eruptions-mean(faithful$eruptions))^{2})/(n-1)
#표본분산, 각각의 데이터에서 평균 뺀 것의 제곱을 자유도 n-1로 나눈다
var(faithful$eruptions) #위와 같음, 표본분산 r 내장함수
sqrt(var(faithful$eruptions)) #표본분산에 스퀘어 루트 씌운 것
sd(faithful$eruptions) #위와 같음, 표본표준편차 r 내장함수


# ----------------------------
#분위수 : mean, variance만으로 설명 안되는 부분 설명해줌
pquant = quantile(faithful$eruptions,probs=c(0.25,0.5,0.75))
#probs : 몇 분위수 볼 것인지 주로 위와 같음
pquant
pquant[3] - pquant[1] #Q(3)-Q(1)=IQR
IQR(faithful$eruptions) #위와 같음, IQR r 내장함수
#outlier 찾을 때 유용

max(faithful$eruptions)-min(faithful$eruptions) #전체 길이
rfaithful = range(faithful$eruptions) #range 함수 : (min, max)
rfaithful
rfaithful[2]-rfaithful[1] #위와 같음, 전체 길이
       

# ----------------------------
#outlier detection
iqr.val=IQR(faithful$eruptions) #IQR 값을 iqr.val 변수로 지정
c(pquant[1]-1.5*iqr.val, pquant[3] +1.5*iqr.val)
#여기 밖에 있는 데이터들을 outlier라고 한다
       
faithful$eruptions[faithful$eruptions > pquant[3] +1.5*iqr.val] #큰쪽의 outlier
faithful$eruptions[faithful$eruptions < pquant[1] -1.5*iqr.val] #작은쪽의 outlier
summary(faithful$eruptions) #min, max를 보면 outlier 없는 것 확인할 수 있다
apply(faithful, 2, summary) #이 데이터 셋에 대해 summary 해보아라
#apply 함수? 계산 쉽게 도와주는 함수. 위에서는 (데이터, column, 기능)


# ----------------------------
#Boxplot
par(mfrow=c(1,2))
boxplot(faithful$eruptions,main='Eruptions')
boxplot(faithful$waiting,main='Waiting')
#median, q[3], q[1], outlier, iqr


# ----------------------------
#왜도와 첨도
#왜도: z(표준화)의 세제곱은 0, 양쪽이 완벽하게 대칭이라, 세제곱하면 바깥쪽 애들에게 가중치를 주겠다
#왼쪽으로 쏠려있는지, 오른쪽으로 쏠려있는지에 관한 통계치

#이론적인 베타 분포 그리기
xvec=seq(0.01,0.99,0.01) #x 범위 정하기
par(mfrow=c(1,2))
plot(xvec,dbeta(xvec,2,5),type='l',lwd=2,xlab='',ylab='')
plot(xvec,dbeta(xvec,7,2),type='l',lwd=2,xlab='',ylab='')
#dbeta: 한쪽으로 쏠린 분포, 여기서의 밀도함수 값을 읽어내, 그게 y값
#type='l' 이것 때문에 선으로 나옴

#실제 베타분포를 이용해서 왜도 구하기
x1= rbeta(1000, 2, 5) #rbeta 베타 분포 shape을 결정하기 위한 두 값
x2= rbeta(1000, 7, 2)
#슬라이드에 왜도 구하는 식 참고
(sum((x1-mean(x1))^3)/length(x1))/(var(x1))^{3/2} #x1의 왜도
(sum((x2-mean(x2))^3)/length(x2))/(var(x2))^{3/2} #x2의 왜도
install.packages("fBasics")
library(fBasics)
skewness(x1) #x1의 왜도
skewness(x2) #x2의 왜도


# ----------------------------
#첨도, tail의 두꺼운 정도(네 제곱)
#outlier 많은지 적은지 알려줌
par(mfrow=c(1,1))
xvec=seq(-4,4,0.01)
plot(xvec,dnorm(xvec,0,1),type='l',lwd=2,xlab='',ylab='',main="Normal and t-distribution")
lines(xvec,dt(xvec,2),type='l',lwd=2,lty=2,col='red')
#dt(x,df) : T~t(df)일때 P(T=x)=?
#rt(n,df) : T~t(df)일때 랜덤으로 n개 추출
x1 = rt(1000, 2) #자유도가 2인 t분포 랜덤하게 생성
(sum((x1-mean(x1))^4)/length(x1))/(var(x1))^{2} -3 #3은 표준정규분포의 첨도


# ----------------------------
#이변량
#선형관계인지 확인
x= faithful$eruptions; y= faithful$waiting
cov(x,y)/(sd(x)*sd(y))
cor(x,y) #위와 같음, 상관계수 내장함수 
plot(x,y,xlab='',ylab='',pch=18)
