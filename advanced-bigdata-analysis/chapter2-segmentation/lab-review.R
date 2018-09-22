####
#### MDS lab - RockHard
####

# load the data
library(smacof)
data(RockHard)
head(RockHard)
dim(RockHard)
RockHard.raw <- RockHard

# data without NA
RockHard.nona <- RockHard
RockHard.nona[!complete.cases(RockHard.nona),]
# except columns with NA
RockHard.nona <- RockHard.nona[,-c(12,13,14,15,16,17,18)]
sum(is.na(RockHard.nona))
head(RockHard.nona)
# except character columns
rownames(RockHard.nona)=RockHard.nona[,"Band"]
RockHard.nona <- RockHard.nona[,-c(1,2,3,4)]

# cmdscale
library(stats)
dist.E <- dist(RockHard.nona)
cmds = cmdscale(dist.E, k=2) # k는 차원 수, 고유값 분해
head(cmds)
plot(cmds, xlab="coord 1", ylab="coord 2", main="MDS: cmdscale", type="n")
text(cmds, labels = rownames(cmds), cex=.5)

# mds
head(RockHard.raw)
rownames(RockHard.raw) <- RockHard.raw[,"Band"]
RockHard.raw <- RockHard.raw[,-c(1,2,3,4)]
dist.M <- dist(RockHard.raw)
mds = mds(dist.M)
names(mds)
mds.conf <- mds$conf
plot(mds.conf, xlab="coord 1", ylab="coord 2", main="MDS: mds", type="n")
text(mds.conf, labels = rownames(RockHard.raw), cex=.5)
