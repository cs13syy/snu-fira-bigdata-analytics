# k-means clustering lab
# 1. load data and make a scatterplot
library(datasets)
library(ggplot2)
head(iris)
colnames(iris)
ggplot(iris, aes(Petal.Length, Petal.Width, color=Species)) + geom_point(size=3)
# 2. k-means clustering
set.seed(20)
irisCluster<-kmeans(iris[, 3:4], centers=3, nstart=20)
irisCluster
irisCluster$cluster


# hierarchical clustering lab
# 1. hierarchical clustering
x=iris[,3:4]
hc.complete=hclust(dist(x), method='complete')
hc.average=hclust(dist(x), method='average')
hc.single=hclust(dist(x), method='single')
# 2. make a plot
plot(hc.complete, main="complete linkage", xlab="", sub="", cex=0.7)
cutree(hc.complete, 2)
cutree(hc.complete, 3)
out.c<-cutree(hc.complete, 3)
table(iris$Species,out.c)
