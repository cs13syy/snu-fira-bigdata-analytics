wsdata0 = read.csv('C:/Users/yuniv/OneDrive/바탕 화면/SNU FIRA/9_데이터기반마케팅애널리틱스(송인성교수님)/clusterexample/Wholesale.csv')
head(wsdata0)
# channel, region -> categorical
wsdata1 = wsdata0[,3:8] # 6 variables
mydata = scale(wsdata1) # divide by standard deviation



######################
# K-means : kmeans   #
######################

# Determine number of clusters
wss = (nrow(mydata)-1)*sum(apply(mydata,2,var))   # total SS
bigK = 20
for (i in 2:bigK) wss[i] = sum(kmeans(mydata, centers=i)$withinss)   # for k=2:K, compute within SS
plot(1:bigK, wss, type="b", xlab="Number of Clusters (k)",   ylab="Within-Group Sum of Squares")
title("Looking for elbow....")

# let us fix elbow as k=?
fit = kmeans(mydata, 5) # 5 cluster solution
fit$centers
fit$size

fit = kmeans(mydata, 4) # 4 cluster solution
fit$centers
fit$size

fit = kmeans(mydata, 3) # 3 cluster solution
fit$centers
fit$size

# ok. fix k at 3

aggregate(mydata,by=list(fit$cluster),FUN=mean)  # get cluster means 
kmclust.output = data.frame(mydata, fit$cluster)  # append cluster assignment

# Cluster Plot against 1st 2 principal components
library(cluster) 
clusplot(mydata, fit$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)



##################################
# Hierarchical cluster: hclust   #
##################################

d <- dist(mydata, method = "euclidean") # distance matrix
fit <- hclust(d, method="complete") 
plot(fit) # display dendogram
# draw dendogram with red borders around the 3 clusters 
rect.hclust(fit, k=3, border="red")
groups <- cutree(fit, k=3) # cut tree into 3 clusters
table(groups)

# looks weird. then let us use ward method

fit <- hclust(d, method="ward") 
plot(fit) # display dendogram
# draw dendogram with red borders around the 3 clusters 
rect.hclust(fit, k=3, border="red")
groups <- cutree(fit, k=3) # cut tree into 3 clusters
table(groups)
clusplot(mydata, groups, color=TRUE, shade=TRUE, labels=2, lines=0) # not informative


#####################################
# Probabilistic  cluster: mclust    #
#####################################

library(mclust)
fit = Mclust(mydata)
plot(fit) # plot results 
summary(fit) # display the best model

clusplot(mydata, fit$classification, color=TRUE, shade=TRUE, labels=2, lines=0)

fit3 = Mclust(mydata, G=3)
summary(fit3) # display the 3-component model

clusplot(mydata, fit3$classification, color=TRUE, shade=TRUE, labels=2, lines=0)
