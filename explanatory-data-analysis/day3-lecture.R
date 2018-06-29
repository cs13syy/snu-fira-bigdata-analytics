# create vector - c, :, seq, rep()
length(6) # 1
rep(1:3, 1:3) # 1 2 2 3 3 3 
# slice : []로 작업, -는 제외
# 파이썬은 연속된 슬라이싱 벡터만 사용하도록 되어 있음, r은 원소 반복해서 지정 가능
# length : 벡터의 속성인 길이, 파이썬(numpy)과 다르게 속성 따로 관리
# 파이썬은 객체 지향, r은 객체 지향이 아니다
# ex) x.length vs length(x)



# length : 벡터를 받고 정수를 출력한다
# slice(logical) : true 위치에 있는 원소 반환
# NA > 0 => NA : NA가 들어간 연산의 결과는 항상 na
# [] 안의 NA는 출력이 될까?
(1:3)[c(T, NA, F)] # 출력은 되는데 NA만 반환, result : 1 NA



# filtering : which는 True가 어디 있는지 알려줌, NA 반환 X
which(T,NA,F) # result : 1
(1:3)[which(c(T,NA,F))] # 1, NA
# %in% : x를 검증, 있는지 없는지
# match() : 위치 반환, 없으면 NA를 반환
# matrix : 컬럼부터 채워진다, 벡터와 같다, length를 잴 수 있다
# 2차원 인덱싱 기능이 있다
# 대각행렬 : diag() 함수로 만들기, 대각원소로 들어갈 원소가 element
diag(rep(1,10)) # 대각 원소가 1이 10개인 대각 행렬
# 벡터에 대해 ncol(), nrow() 쓰면 null 값 출력 (특히 매트릭스에서 자동 벡터 되는 경우 조심)



a = matrix(1:10, 5, 2)
a
v = ncol(a)
v # 2
b = a[,-1,drop=F] # drop 하지 마세요
# 프로그래머가 원하는대로 데이터 control하는 게 중요
ncol(b) # 1
class(b) # 매트릭스 유지, drop=F 때문에
b 



a = matrix(1:10, 5, 2)
b = a[,-1] # 자동 벡터화
ncol(b) # 벡터가 되어서 ncol(b) 결과로 null 출력
class(b) # 벡터 그러니까 integer
b # 가로로 한 줄로 출력



# dataframe : 매트릭스에서는 한 가지 타입의 데이터 사용, but df는 달라 (for memory 효율성)
# 열 정보 가져오기 : $ 또는 [[]]
# 매트리스와 똑같은 인덱싱, 열을 가져올 때는 클래스 유지, 행을 가져올 때는 df, 행은 여러 클래스를 갖기 때문에



# add component : name이 list 안에 없으면 chain 맨 뒤에 붙임
j <- list(names='Joe', salary=55000, union=TRUE)
j
j$history = 1:10
j[1:3] = 1:3
j
a = vector('list', length=4)
a[1:3] = 1:3
a # 4번째 결과로 null(아예 그런 칸 없다)
a[[1]] = 1:3 
a



# factor의 값은 사실은 숫자다 (char처럼 보이지만)
# table에서 (1) ? ,(2) 인덱싱 차 색깔을 다르게 칠하고 싶다 -> factor 사용



# object 타입의 전환에 대해 알아보자
# 1행짜리 df를 1열짜리 vector(어레이)로 만들고 싶다
a = matrix(1:10, 5, 2)
a
a[c(T,F,T,F,T),] # 1, 3, 5행만 출력
a[c(1,3,5),] # 1, 3, 5행만 출력
a[c(T,F,T),] # 불리언 할 때는 숫자 맞추지 않으면 에러 발생



# matrix를 c()에 넣으면 matrix 사라지고 vector 남음
a = matrix(1:10, 5, 2)
c(a)
a[,1,drop=F] # column matrix
drop(a[,1,drop=F]) # vector화



# 타입 변환 주로 as function 사용
a = c('tommy', 'jimmy', 'jane') # a는 캐릭터 벡터
b = as.factor(a) # as.factor() 대신 factor 함수도 사용 가능
b # levels 사전형 정렬, tommy는 숫자 3번째 레벨 
c(b) # factor -> integer vector, result : 3 2 1



# 매트릭스를 벡터로 변환
a = matrix(1:10, 5, 2)
c(a)
a
b = as.vector(a)
b
# c(a)와 b의 결과 같다



# df가 matrix로 변환 가능한 경우에는 변환해 줌
a = data.frame(1,2)
a # 1행 2열
b = as.matrix(a)
b
class(b)



a = data.frame(v1=1,v2='a')
a
b = as.matrix(a) 
b # 매트리스로 바뀌면서 1도 char로 캐스팅
class(b)
d = b[1,1] + 1 # 자동 캐스팅
# matrix는 똑같은 형태의 자료 저장, 가장 많은 공간을 차지하는 character 형태로 통일할 수밖에 없다
# type의 자동 변환으로 일어나는 오류 많다
a = data.frame(v1=1,v2='a',v3=F)
a
b = as.matrix(a) # false 문자화
b
class(b)
d = b[1,1] + 1 # 자동 캐스팅, 에러
# b[1,1]이 매트릭스로 들어가면서 character화 되어서 1임에도 숫자랑 연산 안 됨



# 코딩 효율 떨어지지만 에러 메시지를 바로 줘서 디버깅하기 어렵지 않음
# r은 자기가 알아서 변환, 효율성 높지만, but 에러메시지 안 떠서 디버깅이 힘듦



# colnames(), rownames()
a = matrix(1:10, 5, 2)
a
# head에 이름을 붙이고 싶어, col name 참조하는 함수 colnames(a)
colnames(a) = c("x1", "x2")
a
rownames(a) = c("r1", "r2", "r3", "r4", "r5")
a
paste0("r", 1) # "r1"
paste0("r", 1:5) # "r1" "r2" "r3" "r4" "r5"
paste("r", 1) "r 1"
paste("r", 1:5, sep="") # "r1" "r2" "r3" "r4" "r5"
paste("r", 1:5, sep="  ") # "r  1" "r  2" "r  3" "r  4" "r  5" 
paste("r", 1:5, sep="-") # "r-1" "r-2" "r-3" "r-4" "r-5"
print(rownames(a))



# dataframes의 col names -> names
a
class(a)
b = as.data.frame(a)
b 
names(b) # colnames(b)도 되긴 돼
names(b) = c("v1", "v2") # b가 가지고 있는 체인네임 메모에 있는 값을 print 해라
b



# dataframe -> list 데이터프레임은 리스트다
# s3 class를 많이 쓰는데, 거의 리스트랑 동일
a = matrix(1:10, 5, 2)
a
b = as.data.frame(a)
b # df
unclass(b) # df는 list로, matrix는 vector로
b # list






# programming이란 결국 flow 관리
# conditional statement - 입력값
# bitwise operation : &, |, !
# and (&) : 모두 참일 때 참 (입력값 2개, 직렬)
# or (|) : 둘 중 하나가 참이면 참 (입력값 2개, 병렬)
# not (!) : 반대를 출력 (입력값 1개)
!TRUE # FALSE
!FALSE # TRUE



# 모든 statement는 집합(벤다이어그램)으로 그릴 수 있고
# 반대로 집합은 bitwise operation 가능하다



# conditional statement - 1 (if)
# if (condition) {statement}
# condition이 T일 때만 statement 실행
a = 0
if (TRUE)
{
  a = 1
}
a # 1


a = 0
if (FALSE)
{
  a =1
}
a # 0



set.seed(1)
x = runif(1)
if (x>0.5)
{
  a=1
}
a # 0


 
a = 1
b = 0
if (a<2)
{
  b=b+1
}
b # 1



# conditional statement - 2 (if else)
# if (condition) {statement-1} else {statement-2}
# condition이 T일 때 statement-1 실행, F일 때는 statement-2 실행
# r은 인터프리터 언어라 한 줄이 문법적으로 완성되면 실행
# else의 위치 중요, 코드가 안 끝났음을 명시 해야한다
a = 0
set.seed(1)
x = runif(1)
x>0.5
if (x>0.5)
{
  a=1
} else { 
  a=1000
}
a # 1000



# 작성 시 오류에 대하여
1 + 3 # 벌써 완결 문장. 결과는 13이 아니라 4
* 4 # 무슨 말인지 모름
1 + 3* # *가 있기 때문에 완결 문장 아니라 다음 입력 기다림
  4 # result : 13



# conditional statement - 3 (loop)
# for (index argument) {statement}
# index argument -> variable in vector
# vector의 길이만큼 반복
# jth iteration에서는 variable 값으로 vector[j] 요소를 참조해서 쓴다
# 위 부분 다 중요, 반드시 기억해야
x = 0
for (i in 1:3)
{
  x = x + i
}
x # 6
i # 마지막이 3이었어서



x = 0
v = c(2,4,6,8)
for (i in v)
{
  x = x + i
}
x # 20
i # 마지막이 8이었어서



# 반복문은 여러 번 사용 가능
x = 0
for (i in 1:3) # 얘 입장에서 아래 for문이 statement
{
  for (j in 1:2)
  {
    x = x + i + j
  }
}
x # 21



# conditional statement - 3 (for loop control)
# next : current statement를 패쓰하고 다음 iteration으로 넘어가라, skip
# stop : 자기 포함 모든 반복문 스탑, 이너루프뿐만 아니라 전체 다 멈춤
# break: 명령을 포함하는 가장 작은 루프만 스탑



# while 문 - 무한 반복
# while (condition) : True면 실행
# 1. 컨디션 확인 2. 컨디션이 T면 실행하고 3. F면 실행하지 않고 While 종료
i = 1
while(TRUE)
{
  i = i + 1
}
i



# false 되는 문장 만들어서 무한 루프 stop 시키는 경우
i = 1
conv = TRUE
while(conv)
{
  i = i + 1
  if (i>=1000) conv = FALSE 
}
i # 1000



i = 1
while(TRUE)
{
  i = i + 1
  if (i>=1000) break
}
i # 1000
  


# create function
# 효율성 + 코드 줄이는 것 +  간결성
# function 객체
textfunction <- function(x1, x2)
{
  y = x1^ 2 + x2 
  return(y)
}
testFunction(4, 2)


# 내부에 선언된 변수가 있으면 외부 변수 신경쓰지 않아
x1 = 1
x2 = 2
testFunction(x1 = 3, x2 = 4)



# 내부에 선언된 변수가 없으면 외부 변수 끌어다 써
x1 = 4
x2 = 2
testFunction(x2, x1)
# function의 내부 이름이랑 밖에서 쓰는 이름(global variable)이 완전 달라도 됨
testFunction(x1 = x2, x2 = x1)



x = 3
testFunction(4,2)
testFunction(x1 = x, x2 = 4) # 이름 불러놓은게 달라서



testFunction <- function(x1, x2)
{
  v1 = x1^2 + x2
  v2 = x1^2 - x2
  return(c(v1,v2))
}
testFunction(2,2) # 6 2  



testFunction <- function(x1, x2)
{
  v1 = x1^2 + x2
  v2 = x1^2 - x2 + x
  return(c(v1,v2))
}
testFunction(4,2)
x = 0 # 밖에 있는 변수 가져다 쓰고 싶어서 global 선언 변수 가져다 쓰는 경우
testFunction(4,2)
x = 1
testFunction(4,2)
x = runif(1)
testFunction(4,2)
# 값이 계속 바뀌면 global 변수 참조되어 있는 것
# 가능한 local 변수, 선언되어 있는 것만 쓰자



# global 변수 사용 예시
testFunction <- function(x1, x2)
{
  v1 = x1^2 + x2
  v2 = x1^2 - x2 + x
  return(c(v1,v2))
}
x = runif(1)
testFunction(4,2)



# global 변수 y를 잘못 적었을 때 조심해야
# function can return the list, 리스트 나오는 경우 가장 많음



testFunction <- function(x1, x2)
{
  v1 = x1^2 + x2
  v2 = x1^2 - x2 + x
  return(c(v1,v2))
  v3 = 3
  return(v3)
}
x = runif(1)
testFunction(4,2)
# return(v3) 출력 x
# return이 2개 있으면 no, 1번이라도 return이 실행되면 끝나. 마치 break 처럼.
# return을 잘 쓰면 어떤 조건에 맞을 때 함수 종료하게 할 수 있음



# input type check : 
# 매트릭스가 아니면 실행을 안 하도록 설계
s_colMean = function(x)
  {
  if (class(x) != "matrix")
    stop("x is not matrix")
  v = rep(0, ncol(x)) # v가 matrix면, 저장 공간 미리 확보 
  for (i in 1:ncol(x))
  {
    v[i] = mean(x[,i]) # 열을 가져와서 평균 계산
  }
  return(v)
}  
# ctrl + alt + f : 함수 실행



x = matrix(1:10, 5, 2)
x
s_colMean(x)
s_colMean(matrix(1:10, 5, 2))



# alt + 방향키 : 맨 오른쪽, 맨 왼쪽
# 1. 조건문, 2. 반복문, 3. 코드 줄이기(function)
# 4. path name : r의 가장 강력한 기능



getwd() # 절대경로
setwd() # 상대경로
.. # 상위폴더
.... # 상위상위폴더

CO2
View(CO2)
save.image("") # 이미지처럼 그대로 저장
load("file name") # 워크스페이스로 가져오겠다
getwd()
write.csv(CO2, file = 'CO2.csv',
          row.names = FALSE) # csv 파일로 저장해라
head(CO2) # 데이터 앞에 몇 개 출력
str(CO2) # df 구조 알려줌
a = read.csv('CO2.csv', header = TRUE)
# 데이터 입출력이 굉장히 쉽다
