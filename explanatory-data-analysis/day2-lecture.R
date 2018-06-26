#slicing vector
x = 5:8
x1 = x[1:3]
x1
x[2]=4
x
y=c(1.2, 3.9, 0.4, 0.12)
y[2:3]
y[c(1,1,2)]
y[-c(1,2)] #- in index: except
y[-length(y)] #length(y)=4, y[-4]

#length of vector
x=3:6
length(x)
1:length(x)

#operating on vector (defined elemetnwisely)
x1=c(5,0,-4)
x2=c(1,2,2)
x1+x2 
x1*x2
x1/x2
x1/3 #short vector one is to be recycled
x1*2
x1=c(5,0,-4,2)
x2=c(2,1)#short vector one is to be recycled (2,1,2,1)
x1/x2

#practice
x1=c(5,0,-4,2)
x2=c(2,1,1)
x1/x2 #error


#order of operations
y=1:10-1 #10자리 벡터 먼저 실행 그 다음 전체 -1
y
y=1:(10-1) #먼저 계산하고 싶으면 괄호
y

#useful operation
x=11
x^2
x%/%5 #qout
x%%5 #remain
x = 1:4 #x=1 2 3 4
y = 1:2 #y=1 2
x^y #반드시 주의할 것!
x=1:4
y=2
x^y
x%%c(2,1,1,1)


#logical operation (elementwise)
#출력값이 true, false, na 등으로 정해져 있음
1:10 <= rep(5,10) #less than or equal to
1:10 <= 5
z=c(5,2,-3,8)
z^2
z^2 > 8

#filtering using index
z[z>0]
z[z^2>8]

#practice
set.seed(1) #set the same seed
x=runif(100) #난수는 반드시 소수점으로 나오나요?
x[x>0.5]
length(x[x>0.5])

set.seed(1) #좀 더 공부해보자! -> 1번으로 정하면 반복해도 동일한 난수 생성
n=100
x=runif(n) #random in the same condition
x[1] #x의 첫번째 인덱스 반환
length(x[x>0.5])/n #relative frequency, 랜덤한 값으로 만든 어떤 함수도 랜덤하다
#x 중에서 0.5보다 큰 x의 비율

#대수의 법칙 : 분산이 엄청 작아진다, 특정 확률 주변에서 나올 확률이 크다 
#실행 수가 커지면서 랜덤한 것이 무의미해진다, 전부 0.5에 가까워짐
set.seed(1)
n=100000000
x=runif(n)
length(x[x>0.5])/n 

#slicing vector (filtering)
x=c(3,1,4,1)
x[x>5] #참조할 대상이 없음, 변수 타입은 numeric
x[x>2]
x=c("a", "b")
y = x[x=="c"] # y 등록은 되고 변수 타입도 지정되었지만 값은 없는, 변수 타입은 character
print(y)
y[1] #result: NA, NA는 모든 연산 NA로 반환
length(y) #result: 0
length(y)==0 #result: TRUE
x=c(3,1,4,1)
which(x>5) #which 함수 공부해보자! which 함수는 true의 위치 반환
which(x>2) #1, 3
x[which(x>5)] #x의 데이터타입이 numeric이므로
x[which(x>2)] #3, 4

#practice
x=c(1:4, NA, 5:8)
x<=4
which(x<=4) #TRUE인 것만 반환, WHICH는 NA 빼고
x[x<=4] #NA가 반환됨
#NA 값이 있을 때 항상 조심해야 함

#%in% function 매칭이 되냐? #match()랑 뭐가 다른가?
1 %in% c(2,1,4) #input개수=output개수, TRUE 반환
c(1,5) %in% c(2,1,5) #원소 대 원소
c(1,5,3) %in% c(2,1,5)
x=c(3,1,4,1)
x %in% c(2,1,4)

#practice
x=c(3,1,4,1) # x를 검사
x %in% c(2,1,4)
x[x %in% c(2,1,4)] #x중에 [] 조건에 맞는 요소만 뽑아라

#match() -> (찾고 싶은 것, 찾을 곳)
match(1, c(2,1,4)) #result: 2, 2번째 있다는 뜻
match(c(2,1), c(2,1,4)) #result: 1 2, 1번째 2번째 있다는 뜻
#B가 unique element여야 함. id 같은 역할.
#중복 여부 확인은 unique()
rep(1,4)
unique(rep(1,4))
length(rep(1,4)) == length(unique(rep(1,4))) #false면 중복
x <- c(3,1,4,1) 
match(x, c(2,1,4)) #result: NA 2 3 0
#해당사항 없음 보통 false지만 match에서는 NA 반환

#NA에 대해 알아보자
#숫자도, 문자도 아닌 그냥 값
#분석 시 missing data(실측값) 때문에 고안하게 됨
NA + 1 #NA 관련된 모든 연산은 NA를 출력
NA * 3
NA == NA #심지어 이것도 NA
is.na(NA) #NA가 NA인지 알아보는 방법
1:4 > NA
c(1:4, NA)
sum(c(1:4, NA)) #결과는 NA
sum(c(1:4, NA), na.rm=T) #na.rm=T NA가 있으면 지워라
Inf > 10 #Inf 이란 무한대, 모든 real value에 대해서는 TRUE
Inf > Inf
Inf == Inf
Inf + Inf
Inf - Inf #무한대-무한대 정의가 안 됨, NaN(정의안됨)을 반환
1/0

#NaN
0/0
#NaN 등장 시, 값을 빼거나 나누는 부분이나 무한대값 나오는 부분 살펴보기
is.nan #NaN 확인 방법
is.nan(0/0)

#matrix
#벡터랑 동일하다. 특별한 기능을 가지고 있는 벡터.
#행렬과 T/F로 참조 사용할 수 있는 벡터
y=matrix(c(1,2,3,4), nrow=2, ncol=2)
y
#매트리스 구성 순서: 열부터 채움(columnwisely)
#채워넣은 순서가 매트리스(벡터)의 인덱싱? 열부터 세서 인덱싱
y=matrix(c(1,2,3,4), nrow=2, ncol=2, byrow=T) #byrow=T 행 단위로 원소가 채워짐
y
matrix(1:4,2,2)
matrix(1:4,2,2)[3]
matrix(1:4,2,2, byrow=TRUE)
matrix(1:4,2,2, byrow=TRUE)[3]

#create matrix
y=matrix(c(1,3,4,5,1,3,4,1),4,2) #행이 4개, 열이 2개
y
y[1,1] #1행 1열 요소 보자
y[,1] #1열 전체를 보자, 출력할 때는 벡터로
y[-2,] #2행 뺀 나머지 행들 전체를 보자
y[1:2,] #1,2번째 행을 보자, 부분행렬 submatrix

#matrix function
y
class(y) #y의 클래스는?
class(y) == "matrix" #TRUE면 matrix가 맞다
class(y[,1]) #r에서의 자동 객체 변환, 1개 행 또는 열일 때 매트릭스 해체
class(y[,1, drop=FALSE]) #매트릭스 구조 유지하고 싶다, 계산 시 꼬일 때 유용(drop=FALSE)
y[,1]
#벡터는 기본적으로 열 벡터로 관리
dim(y) #y의 dimention, 행숫자 열숫자 순서대로 반환
ncol(y) #column의 개수, matrix에서만 작동
nrow(y) #row의 개수, matrix에서만 작동
y[,1, drop=FALSE]
ncol(y[,1, drop=FALSE])
ncol(y[,1]) #result: NULL, 반복문 안에서 작동 멈춤 오류 발생(debug)

#오류
#1. 필터링 인덱스했는데 length가 0인 경우
#2. for문 안에서 NULL값이 반환될 때(매트릭스가 벡터로 자동변환 되어서)

#column bind
one=rep(1,4)
one
z=matrix(c(5:8, rep(-1,4), rep(0,4)), 4, 3)
z
cbind(one, z) #cbind, 첫 열에 합침
cbind(2, z) #2와 같은 "숫자"여도 상관 없다, z는 안 바뀜

one=c(1,2) #짧아서 원소 재사용 가능
one
z=matrix(c(5:8, rep(-1,4), rep(0,4)), 4, 3)
cbind(one, z) #cbind

#row bind
z=matrix(c(5:8, rep(-1,4), rep(0,4)), 4, 3)
z
z=rbind(2,z)
z

a = c() #빈 껍데기로 이미 선언되어 있어야 나중에 참조됨
a = c(a, "init") #result: "init"
a
a = c(a, "init") #result: "init" "init"
a

a = 0
a[10] <- 22 #10번째에 숫자 22 넣어라
a #나머지는 NA

a = NULL #이렇게 initialize(초기값 선언)가 되어야 한다
a
a = rbind(a, 1:3) #그래야 오류가 안나
a

#dataframe
#왜 필요한가? 
#벡터는 one kind만 용납, 1가지 데이터 형만 관리, auto-casting 기능(matrix->vector)
#하나가 캐릭터면 전부다 캐릭터여야 왜냐면 구조적 모형 때문, 숫자와 문자 동시 관리 불가
x=1:10 # x는 벡터
typeof(x[1]) #integer
x[1] = "a" #리스트의 한 원소를 character로 선언
x[2] 
typeof(x[2]) #interger가 character가 되었다

#vector 모든 크기 똑같이 해놓아서 빨리 찾아갈 수 있게 함
#matrix도 마찬가지, 다양한 형태의 데이터형 한 번에 다루기에 부적합
x=matrix(1:4, 2, 2)
x
typeof(x) #integer
x[2,2]='b'
typeof(x) #character (매트릭스는 벡터다)

#create dataframe
#다양한 형태의 데이터형 다루기에 적합
#argument는 길이가 똑같은 벡터(아니면 재사용 하겠지만)
kids = c("Jack", "Jill") #character
kids
ages = c(12,10) #integer
ages
d = data.frame(kids, ages, stringsAsFactors = F)
d
str(d) #structure, objects가 어떻게 구성되어 있는가, obs는 행
d = data.frame(x1=kids, x2=ages, stringsAsFactors = F)
d

#select the elements
d[1,1] #matrix처럼 다룰 수 있다
d[,2]
d[1,]
class(d[,1]) #result: "character"
class(d[,2]) #result: "numeric"
class(d[1,]) #result: "data.frame" 서로 다른 데이터 타입 관리해야 하기 때문에
#data importing 시 중요
#벡터만 뽑아내고 싶지만 여러 타입 사용하는 dataframe에서 벡터 요구하는 연산이 안 됨에 주의
