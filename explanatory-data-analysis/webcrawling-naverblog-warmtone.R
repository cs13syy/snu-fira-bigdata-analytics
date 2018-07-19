# 라이브러리 
library(rvest)
library(dplyr)
library(KoNLP)

# header 설정 : api 승인을 위한 과정
client_id = 'XXXXXXXXXXXXXXXXXXXXXX';
client_secret = 'XXXXXXXXXXX';
header = httr::add_headers(
  'X-Naver-Client-Id' = client_id,
  'X-Naver-Client-Secret' = client_secret)

# 키워드 쿼리 변경
query = '웜톤'
# iconv(query, to = "UTF-8", toRaw = F)
query = iconv(query, to = 'UTF-8', toRaw = T)
query = paste0('%', paste(unlist(query), collapse = '%'))
query = toupper(query) # 대문자화
query

end_num = 1000 # 1000개까지 보겠다
display_num = 100 # display 제한에 따라 100개씩 끊어서 가져와야
start_point = seq(1,end_num,display_num) # 시작 포인트는 1, 101, 201...
i = 1 # 초기값 설정
url = paste0('https://openapi.naver.com/v1/search/blog.xml?query=',
             query,'&display=',display_num,'&start=',
             start_point[i],'&sort=sim')
url_body = read_xml(GET(url, header)) # header 없으면 권한이 없어서 출력 안하니 유의

# title, name, date, link, description 정보 각각 가져옴
GET(url, header)
as.character(url_body)
title = url_body %>% xml_nodes('item title') %>%
  xml_text()
bloggername = url_body %>% 
  xml_nodes('item bloggername') %>% xml_text()
postdate = url_body %>% xml_nodes('postdate') %>%
  xml_text()
link = url_body %>% xml_nodes('item link') %>%
  xml_text()
description = url_body %>% xml_nodes('item description') %>%
  html_text()

i = 1
final_dat = NULL # 초기값 설정
for(i in 1:length(start_point))
{
  # request xml format
  url = paste0('https://openapi.naver.com/v1/search/blog.xml?query=',query,
               '&display=',display_num,'&start=',start_point[i],'&sort=sim')
  #option header
  url_body = read_xml(GET(url, header), encoding = "UTF-8")
  title = url_body %>% xml_nodes('item title') %>% xml_text()
  bloggername = url_body %>% xml_nodes('item bloggername') %>% xml_text()
  postdate = url_body %>% xml_nodes('postdate') %>% xml_text()
  link = url_body %>% xml_nodes('item link') %>% xml_text()
  description = url_body %>% xml_nodes('item description') %>% html_text()
  temp_dat = cbind(title, bloggername, postdate, link, description)
  final_dat = rbind(final_dat, temp_dat)
  cat(i, '\n')
}
final_dat # matrix
final_dat[1,1] # title
final_dat[1,2] # name
final_dat[1,3] # date
final_dat[1,4] # link
final_dat[1,5] # description

# 전처리
final_dat = data.frame(final_dat, stringsAsFactors = F)
final_dat$description = gsub('\n|\t|<.*?>|&quot;',' ',final_dat$description)
final_dat$description = gsub('[^가-힣a-zA-Z]',' ',final_dat$description)
final_dat$description = gsub(' +',' ',final_dat$description)

# 빈도 분석
library(KoNLP)
nouns=KoNLP::extractNoun(final_dat$description)
nouns[1:20]
ewdic=data.frame(V1=c("트렌디","립스틱","발색","이글립스","색조","완성","베이스","톤업","선크림"),"ncn")
KoNLP::mergeUserDic(newdic)
nouns_unlist <- unlist(nouns)
nouns_unlist <- Filter(function(x){nchar(x)>=2}, nouns_unlist)
wordcount <- table(nouns_unlist)
head(wordcount)
wordcount_top <-head(sort(wordcount, decreasing = T),100)
head(wordcount_top, n=10)
