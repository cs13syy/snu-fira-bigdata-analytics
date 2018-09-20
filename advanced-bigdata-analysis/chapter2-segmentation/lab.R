rm(list=ls());gc()

## Cereals data
setwd("C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/8_고급빅데이터분석(김용대교수님)/chapter-2/ch2_lab")
cereals = read.csv("cereals.csv",header=T)
dim(cereals)
names(cereals)

################################################

# 변수 설명
# name: 시리얼 이름
# mfr: 시리얼 제조사
# type: cold or hot
# calories: 1회 제공량 당 칼로리
# protein: 단백질 함량 (g)
# fat: 지방 함량 (g)
# sodium: 소금 함량 (mg)
# fiber: 식이섬유 함량 (g)
# carbo: 복합 탄수화물 함량 (g)
# sugars: 설탕 함량 (g)
# potass: 칼륨 함량 (mg)
# vitamins: FDA 기춘치 대비 비타민, 미네랄 함량 (%)
# shelf: 진열대 위치 (바닥부터 1,2,3층)
# weight: 1회 제공량 당 무게 (oz)
# cups: 1회 제공량 당 컵 단위 (eg. 1.5컵)
# rating: 소비자 조사에 의한 시리얼 평점

################################################


## 필요한 자료 선택
# 사용할 변수: 칼로리, 단백질, 지방, 소금, 식이섬유, 복합탄수화물, 설탕, 칼륨, 비타민 (9개)

cereals = cereals[, c("name","calories","protein","fat","sodium","fiber","carbo","sugars","potass","vitamins")]
dim(cereals)

## missing value가 있는 자료 삭제
cereals[!complete.cases(cereals),]
cereals <- cereals[complete.cases(cereals),]
dim(cereals)
sum(is.na(cereals)) # length(which(is.na(cereals)))

head(cereals)
rownames(cereals)=cereals[,"name"]
cereals=cereals[,-1] # name col 삭제


#---- 2-2. 계층적 군집분석(p.60)

## 산포도 확인
plot(cereals)
# linear tendency: potass&fiber
attach(cereals)
plot(potass, fiber)
cor(potass, fiber) 


## 계층적 군집분석(hieratchical clustering)

# 거리 측도 : euclidean, Minkowski, Maximum
# Linkage : single, complete, centroid, average

# k1=3
dist.E=dist(cereals)

# (1) Euclidean dist., complete <- default option
cluster.EC = hclust(dist.E) 
plot(cluster.EC, main="Euclidean, complete", cex=.7)

# (2) Euclidean dist., single linkage
cluster.ES = hclust(dist.E, method="single")
plot(cluster.ES, main="Euclidean, single", cex=.7)

# (3) Euclidean dist., average linkage
cluster.EA = hclust(dist.E, method="average")
plot(cluster.EA, main="Euclidean, average", cex=.7)


## 군집 분할(할당)
clusters = cutree(cluster.EC, k=2:6) # 1. 군집 수 조절
head(clusters,10)
clusters = cutree(cluster.EC, h=100) # 2. 덴드로그램의 높이 조절
clusters[1:10]


# 덴드로그램에서 할당, 시각화
plot(cluster.EC, main="Euclidean, complete")
groups = cutree(cluster.EC, h=100) # k=16
head(groups,20)
rect.hclust(cluster.EC, h=100, border="red")

plot(cluster.EC, main="Euclidean, complete")
groups = cutree(cluster.EC, k=4) 
head(groups,20)
rect.hclust(cluster.EC, k=4, border="red") 
# draw denrogram with red borders around the k1 clusters


## 군집 내 비교 (k=4) using Euclidean dist. and complete linkage

for (i in 1:4){
  cat(i,'- th cluster \n')
  tmp = rbind(round(colMeans(cereals[which(groups==i),]),3),
              round(diag(cov(cereals[which(groups==i),])),3)); rownames(tmp)=c("Mean","Var")
  print(tmp)
}
table(groups)
# tmp 1st row <- "i번째 group에 배정된 데이터들의 열별 평균"을 넷째자리에서 반올림
# tmp 2nd row <- "i번째 group에 배정된 데이터들의 covariate 행렬에서 대각원소(열별 분산)를 추출한 것"을 넷째자리에서 반올림



# linkage 에 따른 군집할당 결과 비교

Clu.Ave = cutree(cluster.EA, k=4)
Clu.Sig = cutree(cluster.ES, k=4)
Clu.Com = cutree(cluster.EC, k=4)

table(Clu.Ave, Clu.Sig)
table(Clu.Ave, Clu.Com)
table(Clu.Sig, Clu.Com)
# 군집 number는 다르지만 비슷하게 분류된 경향을 찾을 수 있음


#--- 2-3. K-means 군집분석(p.73)


# K-means 결과
library(cluster)
cluster.K4 = kmeans(cereals, centers=4) # 군집 수 4개
cluster.K4

plot(cereals, col=cluster.K4$cluster) #k-means


# 초기값에 따른 군집분석의 차이
set.seed(1)
cluster1= kmeans(cereals, centers=4)
set.seed(2)
cluster2= kmeans(cereals, centers=4)

# 초기값이 다르면 결과 꽤 다른 편이다
table(cluster1$cluster, cluster2$cluster)
cluster1$centers
cluster2$centers


## 군집 수 K 정하기
wss <- vector(length=15)
for (i in 1:15) wss[i] = kmeans(cereals,centers=i,nstart=10)$tot.withinss
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares",
     main = "Total within SS for varying K") 
# 원소개수 15개인 벡터 wss를 만들어서 군집개수에 따른 내부제곱합을 저장
# 원소 값이 급격히 작아지는 i가 적합한 클러스터의 개수, 이 경우 5,6이 적합해보임



#--- 2-1. 다차원 척도분석(p.10)

cmds = cmdscale(dist.E, k=2) # k는 차원 수, 고유값 분해
head(cmds)
plot(cmds, xlab="coord 1", ylab="coord 2", main="MDS", type="n")
text(cmds, labels = rownames(cmds), cex=.8)



#--- 다차원 척도법을 이용한 군집분석 시각화(p.81)
k1 = 4
par(mfrow=c(2,2))

# linkage에 따른 군집 분석 시각화
groups = cutree(cluster.EC, k=k1) # linkage=complete
plot(cmds, xlab = "coord 1", ylab = "coord 2", main = "complete/MDS", type = "n")
text(cmds, labels = rownames(cmds), cex=.8, col=groups)

groups = cutree(cluster.ES, k=k1) # linkage=single
plot(cmds, xlab = "coord 1", ylab = "coord 2", main = "single/MDS", type = "n")
text(cmds, labels = rownames(cmds), cex=.8, col=groups)

groups = cutree(cluster.EA, k=k1)  # linkage=average
plot(cmds, xlab = "coord 1", ylab = "coord 2", main = "average/MDS", type = "n")
text(cmds, labels = rownames(cmds), cex=.8, col=groups)

#k-means
plot(cmds, xlab = "coord 1", ylab = "coord 2", main = "kmeans/MDS", type = "n")
text(cmds, labels = rownames(cmds), cex=.8, col=cluster.K4$cluster)



#--- PCA 를 이용한 군집분석 시각화(p.78)
# PCA : 차원 축소 방법중 하나. 자료의 분산을 고유값 분해.
# 차원 줄인 것 pca$scores에 저장되어 있음
pca <- princomp(cereals, cor=T)

groups = cutree(cluster.EC, k=k1) # linkage=complete
plot(pca$scores[,1:2], xlab = "coord 1", ylab = "coord 2", main = "PCA", type = "n")
text(pca$scores[,1:2], labels = rownames(pca$scores), cex=.8, col=groups)

groups = cutree(cluster.ES, k=k1) # linkage=single
plot(pca$scores[,1:2], xlab = "coord 1", ylab = "coord 2", main = "PCA", type = "n")
text(pca$scores[,1:2], labels = rownames(pca$scores), cex=.8, col=groups)

groups = cutree(cluster.EA, k=k1) # linkage=average
plot(pca$scores[,1:2], xlab = "coord 1", ylab = "coord 2", main = "PCA", type = "n")
text(pca$scores[,1:2], labels = rownames(pca$scores), cex=.8, col=groups)

# kmeans
plot(pca$scores[,1:2], xlab = "coord 1", ylab = "coord 2", main = "PCA", type = "n")
text(pca$scores[,1:2], labels = rownames(pca$scores), cex=.8, col=cluster.K4$cluster)

