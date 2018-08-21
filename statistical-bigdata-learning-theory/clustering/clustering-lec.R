# kmeans clustering
# k=2
set.seed(2)
x=matrix(rnorm(50*2), ncol=2)
x[1:25,1]=x[1:25,1]+3 # change [1:25,1]
x[1:25,2]=x[1:25,2]-4 # change [1:25,2]
plot(x)
km.out=kmeans(x,2,nstart=20)
plot(x, col=(km.out$cluster+1), main="K-Means Clustering 
     Results with K=2", xlab="", ylab="", pch=20,
     cex=2) # km.out$cluster
km.out
km.out$withinss
# k=3
set.seed(4)
km.out=kmeans(x,3,nstart=20)
km.out
plot(x, col=(km.out$cluster+1), main="K-Means Clustering 
     Results with K=3", xlab="", ylab="", pch=20,
     cex=2)
# nstart=1 vs nstart=20
set.seed(3)
km.out=kmeans(x,3,nstart=1)
km.out$withinss # withinss 내부제곱합
km.out$tot.withinss # tot.withinss 내부제곱합의 합
km.out=kmeans(x,3,nstart=20)
km.out$tot.withinss # nstart=20보다 작다


# hierarchical clustering
hc.complete=hclust(dist(x), method="complete")
hc.average=hclust(dist(x), method="average")
hc.single=hclust(dist(x), method="single")
# dist(x) <- 거리라는 객체, n*n 거리 행렬, euclidian dist
# dist.x = as.dist(1-cor(x)) <- cor은 유사도라서 비유사도인 dist는 1-cor
dist(x[1:4,])
par(mfrow=c(1,3))
plot(hc.complete, main="Complete Linkage", xlab="", ylab="", cex=.9)
plot(hc.average, main="Average Linkage", xlab="", ylab="", cex=.9)
plot(hc.single, main="Single Linkage", xlab="", ylab="", cex=.9)
cutree(hc.complete, 2) # 군집 개수 2개
cutree(hc.average, 2)
cutree(hc.single, 2)
cutree(hc.single, 4)
xsc=scale(x) # scale() 표준화
par(mfrow=c(1,1))
plot(hclust(dist(xsc), method="complete"),
     main="Hierarchical Clustering with Scaled Features")
# x=matrix(rmorm(30*3), ncol=3)
# dd=as.dist(1-cor(t(x)))
