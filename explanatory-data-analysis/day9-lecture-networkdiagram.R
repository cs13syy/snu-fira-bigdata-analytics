# ---------------------------
if(!require(networkD3)){install.packages("networkD3"); library(networkD3)}
if(!require(igraph)){install.packages("igraph"); library(igraph)}
if(!require(reshape2)){install.packages("reshape2"); library(reshape2)}


# ---------------------------
src <- c("A", "A", "A", "A",
         "B", "B", "C", "C", "D")
target <- c("B", "C", "D", "J",
            "E", "F", "G", "H", "I")
networkData <- data.frame(src, target)
head(networkData)


# ---------------------------
networkD3::simpleNetwork(networkData, fontSize = 15, zoom = T)
# HTML 형식


# ---------------------------
data(MisLinks)
head(MisLinks)

data(MisNodes)
head(MisNodes)


# ---------------------------
forceNetwork(Links = MisLinks, Nodes = MisNodes,
             Source = "source", Target = "target",
             Value = "value", NodeID = "name", arrows = T, 
             Group = "group", opacity = 0.8, zoom = TRUE)
# Links에 대한 df
# Nodes에 대한 df
# Source : MisLinks의 source 열
# Target : MisLinks의 target 열
# NodeID : MisNodes의 name 열
# Value : MisLinks의 value 열
# Group : MisNodes의 group 열
# Opacity : 투명도
# arrows = T : 방향성 화살표 표시
# MisNodes의 size는 영향력 의미미


# ---------------------------
sankeyNetwork(Links = MisLinks, Nodes = MisNodes,
              Source = "source", Target = "target",
              Value = "value", NodeID = "name",
              fontSize = 12, nodeWidth = 18)


# --------------------------- 
if(!require(data.table)){install.packages("data.table"); 
  library(data.table)}
if(!require(dplyr)){install.packages("dplyr"); library(dplyr)}

setwd("C:/Users/yuniv/OneDrive/문서/R/explanatory-data-analysis/data") # dataset이 존재하는 library지정
load("data_list.Rdata")


# ---------------------------
str(data_list)
attach(data_list)
summary(data_list)
head(n_gram) #원본과 유사, 각각 docu가 가지는 단어 집합
head(date) #원본과 유사, docu 게시된 날짜
head(data) #년도별 docu에 나타난 단어의 빈도(word, count, date)
head(data$word[data$date==2014]) #현재 정렬이 count 기준
head(data$count[data$date==2014])
head(data$word[data$date==2015])
head(data$count[data$date==2015])
head(conf_data)
#단어, 년도 별 confident 데이터
barplot(table(data_list$date))


# ---------------------------
#word.df 새로 생성
word.df=as.data.frame(data)
word.df=dcast(word.df,word~date,value.var='count')
# dcast로 연도 열 생성, 포뮬라 앞이 항목, 포뮬라 뒤가 열, 값에 해당하는 것이 value.var
word.df=cbind(word.df,sum=rowSums(word.df[-1])) # except sum
word_order=order(word.df[6],decreasing=T) # sum = 6th col, sum을 내림차순으로 정렬
head(word.df[word_order,],10) # 열 개 까지만 출력하라


# ---------------------------
doc_list = n_gram # copy data of n_gram, n_gram 캐릭터 벡터의 리스트
uniq_words = unique(do.call('c', doc_list)) # unique 함수 : 중복되는 것 발라냄
head(uniq_words)
length(uniq_words)

# 각각의 벡터들을 하나의 긴 벡터로 만들겠다, doc_list를 하나의 벡터로 만들자
# count_doc 함수 생성, word와 year을 넣으면 거기에 입력 word가 있는지 t/f로 반환
count_doc <- function(word,year){
  return(
    sum(sapply(n_gram[date==year], function(x) word %in% x))
    #true인것들의 sum, 1인 애들 sum 즉 개수 반환
    #%in% : 앞에가 뒤의 벡터의 원소인가? 출력 t/f
  )
}
word_count_2016 <-
  sapply(uniq_words, function(word) count_doc(word,2016))
#word_count_2016 : 2016년에 유니크 단어들이 몇 번 출력되었는지 알려줌
count_doc("compass", 2015) # 결과 출력됨, 1번


# ---------------------------
#mean_conf = apply(conf_result[,2:4],1,mean) 
#conf_result$increasing_rate = conf_result[,5] / mean_conf
#attach(conf_result)
#text_conf = conf_result[c(which(is.finite(increasing_rate) & increasing_rate > 20), which(mean_conf > 0.3)),]
#loc_conf = mean_conf[c(which(is.finite(increasing_rate) & increasing_rate > 20), which(mean_conf > 0.3))]


# ---------------------------
# confidence : 2016년 문서 수 중에 특정 문자를 포함하고 있는 문서 수
# conf가 높으면 머신러닝과의 연관성 높음
# x축 : 2017년의 conf, y축 : 2017년의 conf / 2014년부터 2017년의 conf 평균
conf_result = conf_data
head(conf_result)
mean_conf = apply(conf_result[,2:4],1,mean) 
#2014~2016 행들을 다 더해 평균 내겠다
#?apply : margin = c(1, 2) : 1 is row, 2 is column
conf_result$increasing_rate = conf_result[,5] / mean_conf
#increasing_rate 열 추가, 2017년 conf를 mean_conf로 나눈 것
attach(conf_result)
text_conf = conf_result[c(which(is.finite(increasing_rate) & increasing_rate > 20), 
                          which(mean_conf > 0.3)),] 
# 순서대로 윗 부분, 아래 부분
# 윗 부분 : which는 인덱스, increasing_rate가 숫자 20 넘고 inf 아닌 것
# mean_conf 값 0인 데이터 102개, 그래서 inf 검사
# 아래 부분 : 평균 conf가 0.3보다 큰 것
# x축 : mean_conf, y축 : increasing_rate
loc_conf = mean_conf[c(which(is.finite(increasing_rate) & increasing_rate > 20), 
                       which(mean_conf > 0.3))]
# 각종 이상값들은 mean_conf 어차피 그림 그릴 때 생략되어 나오므로 상관 없음


# ---------------------------
plot(mean_conf, increasing_rate, ylim = c(-0.5, 27),
     xlim = c(-0.005, 0.5)) # mean_conf : 전반적 인기, increasing_rate : 현재 인기
text(loc_conf + 0.03, text_conf$increasing_rate,
     labels = text_conf$word, cex = 1, pos = 3)
abline(h = 1, col = 'red')
# 선 위는 2017 이후 인기 있어진 단어
# 선 아래, 비교적 그 전에 유명했던 단어, 인기 상대적으로 적어진 단어
# 오른쪽에 있을수록 전반적으로 중요한 단어
# 데이터가 0에 몰려있으면 log scale(변환)로 그리면 자세히 볼 수 있음
# 단 0인게 많으면 안 그려짐, 그래서 작은 상수 더해서 그림
plot(mean_conf + 1e-4, 
     conf_result$increasing_rate + 1e-2,
     ylim = c(1e-2, 27), log = "xy",
     xlim = c(1e-4, 2))
text(loc_conf *exp(0.03), text_conf$increasing_rate,
     labels = text_conf$word, cex = 1, pos = 3 )
abline(h=1, col = 'red')


# --------------------------- 
# 매트릭스 생성 -> 행 : word, 열 : document
# 포함되면 1, 아니면 0으로
doc_list = n_gram # 각각 docu가 가지는 단어 집합
uniq_words = unique(do.call('c', doc_list))
head(uniq_words)
length(uniq_words)
occur_vec_list = lapply(doc_list, function(x) uniq_words %in% x) # 리스트 apply, t/f 반환
occur_vec_list[[1]] # 기본 body는 uniq_words
dtm_mat = do.call('rbind', occur_vec_list) # 0, 1로만 이루어진 매트릭스로 합쳐줌
ncol(dtm_mat)
# rbind, 행으로 붙여주는 것 (행 길이 : 1134, unique_words의 length)
colnames(dtm_mat) = uniq_words
dtm_mat[1:3,1:3] # media : docu 1에 있고


# ---------------------------
refined_dtm_mat = dtm_mat[, colSums(dtm_mat) != 0]
# 특정 단어가 들어간 document의 수가 0인 열은 뺀다 / 한 번도 안 나온 단어는 뺀다
refined_dtm_mat = refined_dtm_mat[rowSums(refined_dtm_mat) != 0,]
# 어떤 년도에도 나오지 않은 단어 행은 빼겠다 / 한 번도 안 나온 다큐먼트는 뺀다
head(refined_dtm_mat)


# ---------------------------
cooccur_mat = t(refined_dtm_mat) %*% refined_dtm_mat
# t() 전치행렬
# 대각원소는 단어의 빈도를 의미
cooccur_mat[1:4, 1:4]


# ---------------------------
# 매트릭스의 크기가 너무 크다. 단어에 기준을 주어 크기를 줄여서 그리자.
# 방법 1 : 단어의 빈도수, 많이 나온 단어 순서대로 자르겠다
inx = diag(cooccur_mat) >= 150
# diag : 대각원소들만 뽑아서 벡터 형태로 출력
# 150번 이상 나온 단어만 뽑자
cooccur_plot_mat1 = cooccur_mat[inx, inx]
# 방법 2 : 2017년에 인기가 높아진, 최근에 중요해진 단어 순서대로 자르겠다
idx = which(conf_result$increasing_rate[
  which(is.finite(conf_result$increasing_rate))] >= 5)
# increasing_rate 값이 inf 아니고 5 이상인 주소, 인덱스
cooccur_plot_mat2 = cooccur_mat[idx, idx]


# ---------------------------
g = graph.adjacency(cooccur_plot_mat1, weighted = T, mode = 'undirected')
# weighted = T : 수치 명시, mode = 'undirected' : 방향성 없음
g = simplify(g) # 대각원소를 0으로, 자기자신과의 연결 반영하지 않겠다
wc = cluster_walktrap(g) # 노드들끼리 그룹을 만들어줌
members = membership(wc) # 각 단어에 대한 그룹의 인덱스 지정
network_list = igraph_to_networkD3(g, group = as.character(members)) # sankey에 맞게 변형
# 그룹을 줄 때는 숫자가 아닌 character로 줘야 함
network_list$links # source, target, value
network_list$nodes # name, group


# ---------------------------
sankeyNetwork(Links = network_list$links, Nodes = network_list$nodes,
              Source = "source", Target = "target", 
              Value = "value", NodeID = "name",
              units = "TWh", fontSize = 18, nodeWidth = 30)


# ---------------------------
# 연결선에 같은 색깔 칠해준 버젼
network_list = igraph_to_networkD3(g, group = as.character(members)) # sankey에 맞게 변형
network_list$links$group=
network_list$nodes$group[network_list$links$source+1]
sankeyNetwork(Links = network_list$links, 
              Nodes = network_list$nodes,
              Source = "source", Target = "target", 
              Value = "value", NodeID = "name",
              NodeGroup="group", LinkGroup="group",
              units = "TWh", fontSize = 18, nodeWidth = 30)
                             
                             
# ---------------------------
if(!require(circlize)){install.packages("circlize"); library(circlize)}
name=c(3,10,10,3,6,7,8,3,6,1,2,2,6,10,2,3,3,10,4,5,9,10)
feature=paste("feature ", c(1,1,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5),
              sep="")
dat <- data.frame(name,feature)
dat <- table(name, feature)
head(dat,4)


# ---------------------------
chordDiagram(as.data.frame(dat), transparency = 0.5)
# 연결 관계에 더해, 어떤 특성으로 연결 되었는지 확인 가능


# ---------------------------
if(!require(chorddiag)){devtools::install_github("mattflor/chorddiag"); library(chorddiag)}
if(!require(RColorBrewer)){install.packages("RColorBrewer"); library(RColorBrewer)}
# devtools::install_github("mattflor/chorddiag", build_vignettes = TRUE)

doc_list = data_list$n_gram # 각각 docu가 가지는 단어 집합
table_list = lapply(doc_list, table)[1:3] # docu 1~3번까지만 table 함수로 빈도 수 확인
table_name = unique(unlist(do.call("c", doc_list[1:3] ))) # docu 1~3번까지 단어 중 unique만 뽑음
names(table_list) = paste0("doc_", 1:3) # "doc_1" "doc_2" "doc_3"

table_list = lapply(table_list, function(x){ # table_list 재할당
    word_table = rep(0, length = length(uniq_words)) # 빈 칸 만들기
    word_table = ifelse(uniq_words %in% names(x), x, 0)
    #안 나온 단어에는 0을 채워서 크기를 맞춰줌
}
)

table_list = do.call("rbind", table_list)
ncol(table_list)
# 행으로 붙임, doc_1 ~ doc_3이 하나로 합쳐짐
# 열 개수는 uniq_words, 1134

refined_table_list = t(table_list[, apply(table_list, 2, sum) != 0])
# 각 docu에 등장한 횟수의 sum이 0일 경우는 제외
# 전치행렬로 바꾸면 행이 단어, 열이 doc
rownames(refined_table_list) = table_name
groupColors <- brewer.pal(3, "Set3")

chorddiag(refined_table_list
          , groupColors = groupColors,  type = "bipartite", tickInterval = 3
          ,groupnameFontsize = 15)
# image classification 때문에 연관이 있다
