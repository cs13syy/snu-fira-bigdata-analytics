# 지난 시간 복습 ===============================================
# if문 : true일 경우 실행한다
# if else문 : true일 때 statement-1, false일 때 statement-2 실행
# 끝나는 문장을 만들어 오류를 내지 않기 위해 else의 위치가 중요
# for문 : index argument가 variable in vector인 것 중요
# loop : outer에게는 inner loop가 하나의 statement다
# loop 통제 : stop 모든 루프 스탑, break 포함한 가장 작은 루프만 스탑



# function : 코드를 줄이고 가독성을 높이기 위해 사용
# argument와 statement 값으로 구분, return을 써서 값을 출력
# return type : 숫자 뿐만 아니라 벡터, 리스트도 가능
# 아래는 굉장히 많이 쓰는 함수의 형태
testFunction = function(x)
{
  v1 = x^2
  v2 = matrix((1:5)^x,1,5)
  return(list(first = v1, second = v2))
}
testFunction(2)



# function 변수에 대해 중요한 점 : function 내부에서 정의한 변수는 내부에서만 사용
testFunction = function(x)
{
  v = x^2 + y
  return(v)
}
y = 1 # y는 바깥쪽에 있어요
testFunction(x)

y = 10 # y는 바깥쪽에 있어요
testFunction(x)

# function 안에 변수 값이 없으면 전체 namespace를 샅샅이 찾아 있으면 그것 씀
# 이것은 사실 치명적일 수 있음 : numerical error
# 불필요한 error를 만들지 않기 위해 function에서 사용하는 변수는 가능한 안에서 선언하라
# 왜 이렇게 위험한 구조로 만들었는가? 다음과 같은 r의 특성 때문
# 데이터는 하나 계속 두고, 다양한 툴 적용하도록(statistics,  model coefficients 등)
# 다양한 툴을 적용할 때마다 데이터를 새로 불러오는 노동을 줄이기 위해서
# 그리고 없는 값은 데이터에서 찾아쓰게 하기 위해서
# ============================================================



# path, file
View(CO2) # CO2 파일 보기 
str(CO2) # CO2 구조 확인하기
getwd() # 현재 위치(디렉토리) 확인하기
write.csv(CO2, "CO2.csv", row.names = F) # 현재 폴더에 csv 파일 만들기
write.table(CO2, "CO2.csv", row.names = F, sep=";") # 위와 동일, 단 ;으로 구분하겠다, row.names = F 행 이름(인덱스 열) 제거
# 위 두 개 같지만, 구분자를 명시하고 싶으면 아래 것을 쓴다
read.csv("CO2.csv") # ;까지 단어로 인식
read.table("CO2.csv", sep=";") # 다시 제대로 읽음
# 위 두 개 같지만, 구분자를 명시하고 싶으면 아래 것을 쓴다
help(read.table)
read.table(file, header = FALSE, sep = "", quote = "\"'",
           dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss"),
           row.names, col.names, as.is = !stringsAsFactors,
           na.strings = "NA", colClasses = NA, nrows = -1,
           skip = 0, check.names = TRUE, fill = !blank.lines.skip,
           strip.white = FALSE, blank.lines.skip = TRUE,
           comment.char = "#",
           allowEscapes = FALSE, flush = FALSE,
           stringsAsFactors = default.stringsAsFactors(),
           fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)
# header가 기본적으로 false로 되어있다 (header = true는 첫 행을 인정한다)
# nrows = -1 : 다 읽겠다
# nrows = 10 : 일부 10개만 보겠다
# skip : 맨 위 n개 행을 제거하고 읽겠다
# colClasses : 행의 형태를 미리 정해줄 수 있다, 결측치나 문자숫자 섞인 경우 용이하게 사용할 수 있다.
# stringsAsFactors = F로 건드리면, 숫자로 읽지 못하는 건 기본적으로 factor로 바꾸는데
# 그게 시간이 많이 걸리니 하지 말라고 하는 것이다. 이럴 경우 문자열을 있는 그대로 가져온다.
# numeric -> double (double : python에서 float)



# read.table practice
a = read.table("CO2.csv", sep=";",
               header = TRUE, 
               stringsAsFactors = FALSE,
               colClasses = 
               c("character", "character", 
                "factor", "integer", "numeric"),
               nrows = 5)
a



list.files() # 현재 작업 중인 working directory 안의 file명들 출력
a = list.files() # 이렇게 저장이 가능하다
a
a[3] # 저장 결과를 캐릭터로 받아올 수 있음
b = list.dirs(recursive = FALSE) # 하위 폴더 제외, 현재 디렉토리의 폴더명 읽기
b # 파일이 있는지 없는지, 어떤 파일이 있으면 작업을 해라 등의 명령 가능



install.packages('xlsx')
library(xlsx) # 엑셀 xlsx 파일 불러오는 라이브러리
A = read.xlsx("CO2(xlsx).xlsx", header = TRUE, sheetIndex = 1, 
              stringsAsFactors= FALSE)
head(A) # 테이블의 앞의 몇 개 행만 보겠다
class(A$Plant) # character
# ============================================================



# plot
# mpg : 연비, 1갤런으로 얼마나 갈 수 있냐
# cyl : 실린더, 몇 기통
# disp : 배기량
# hp : 마력
# rownames : 차종
View(mtcars) # mtcars 데이터 보기
str(mtcars) # 구조를 트리 형식으로 전체 볼 수 있음
# 리스트란 체인! 꼭 기억하자
# cyl는 4, 6, 8, 10 등 하나의 범주형 변수의 레벨로 볼 수도 있음 (지금은 numeric)
# cyl를 팩터로 바꾸는 게 좋을 것 같다
mtcars$cyl <- factor(mtcars$cyl) # cyl를 팩터로 변경
str(mtcars)



names(mtcars) # 전체 변수를 출력
mpg # 이렇게 하면 몰라
mtcars$mpg # 이렇게 불러야 돼
attach(mtcars) # dataframe에 있는 chain의 이름을 global namespace에 등록
# $ 사용 없이 컬럼 네임만 콜하면 이제 바로 불러올 수 있음
# 편해보이는데 엄청 위험, 작업 중간에 쓰다보면 변수가 덮어씌워질 수 있음, 거의 쓰지 않는다
mpg # 바로 불러 온다
detach(mtcars) # 등록한 이름을 해제
head(mtcars, n=2) # 테이블 앞의 두 줄만 보여줌


# visualize tool : plot()
# 기능 : 데이터를 스캔하여 큰 그림을 하나 보여줌(x축, y축, 점들)
# 데이터프레임에서 주로 작업, 왜? 포뮬러를 쓰려면 데이터프레임을 사용해야 함
# plot(mpg ~ disp, data = mtcars) # 포뮬라 형태
# 포뮬라(mpg ~ disp)의 기능: 앞쪽은 y축(mpg), 뒤쪽은 x축(disp)
plot(mpg ~ disp, data = mtcars)
a = "mpg ~ disp" # a는 포뮬라
a
plot(a, data = mtcars) # error, 포뮬라가 캐릭터는 아니다
a_f = as.formula(a) # a의 데이터를 포뮬라의 데이터 타입으로 바꿔라
class(a_f) # formula
plot(a_f, data = mtcars)
?plot
# plot.formula가 실행된 것이라 일단 간단하게 알고 있으면 된다



# Draw a plot of which y-axis is hp (horse power) and x-axis is disp.
plot(hp ~ disp, data = mtcars)
# 점의 개수 = 데이터의 개수
# 수많은 속성 중에 차를 설명할 수 있는 변수를 선택, 두 가지 기준만 놓고 차를 살펴 봄
# hp와 disp는 강한 양의 상관관계를 가지고 있다고 할 수 있다
# disp가 커지면 hp의 산포도 커진다는 사실을 알 수 있다
# 통계학자가 데이터를 본다 : 관측이 됐는데 그건 관측값이고 그게 나오는 underline structure가 있을 것이다
# approach : 본래 어떤 모델이 있을 것이다. 그게 뭘까? 
# 논문 : probability 기반 모델링



# draw plot by vectors
x = rnorm(100) # 정규 분포 난수를 생성, x=0을 기준으로 가까운 100개 출력
x
y = 2+2*x + rnorm(100) # 점의 개수는 100개
plot(x,y, main = "plot (x-y)")
# plot은 다양한 그래픽 객체를 표현할 수 있다
# main은 plot의 title을 붙여준다
# type = 'p': point
# type = 'l': line
# type = 'b' : both point and line
# type = 's' : step
# type = 'n' : nothing
plot(x,y, main = "plot (x-y)", type = 'p')
x = seq(-2,2, length = 10) #seq 함수 : start, end, number(개수)
x
y = x^2
y
plot(x,y, type = 'p', main = "y = x^2")
plot(x,y, type = 'n', main = "y = x^2")
plot(x,y, type = 'l', main = "y = x^2")
plot(x,y, type = 'b', main = "y = x^2")
plot(x,y, type = 's', main = "y = x^2")
# lty 선의 라인 타입
plot(x,y, type = 'b', lty = 3, main = "y = x^2")
plot(x,y, type = 'b', lty = 2, main = "y = x^2")
plot(x,y, type = 'b', lty = 4, main = "y = x^2")
# pch 점의 타입 옵션
plot(x,y, type = 'b', lty = 3, pch = 2, main = "y = x^2")
plot(x,y, type = 'b', lty = 2, pch = 19, main = "y = x^2")
# pch가 데이터 개수보다 적으면, recycle
plot(x = 1:25,y = rep(0, 25), pch = 1:25)
plot(x = 1:25,y = rep(0, 25), pch = 1)



colors()[1:10] # 이름으로 정의된 컬러들의 리스트
plot(x,y, type = "b", lty = 3, pch = 2, 
     col = "aquamarine2", main = "y = x^2")



# plot의 outer space 살펴보기
# label
plot(x,y, type = "b", xlim = c(-1, 1))
# xlim = c(min,max) x축의 왼쪽과 오른쪽 
# ylim = c(min,max) y축의 왼쪽과 오른쪽
# lim을 강제로 맞추어주는 게 2개의 그래프를 비교할 때 중요
# x와 y의 label 달아주기
plot(x,y, type = "b", xlab = "xx", ylab = "yy", main = "y = x^2")



# 평균과 분산 왜 구해? for data summarization
# 평균은 자료의 중심, location의 대표값
# 두 변수 간의 관계를 나타내는 축도, visualiztion tool = 산점도
# 하나의 산점도는 2개의 산점도만 관심이 있다, 그 이상은 안돼서 아쉽다
# 한 번에 두 개씩 많이 보여주자 -> 산점도 매트릭스를 이용한다
plot(~mpg + disp + drat, data = mtcars, 
     main = "Simple Scatterplot Matrix")
# ~mpg+disp+drat : 이 포뮬라는 세 변수의 관계를 보고 싶다는 의미
# 다양한 옵션 추가 가능
plot(~mpg + disp + drat, data = mtcars,
     pch = 19, col = 'orange')



# 만들어진 함수 위에 선을 그리는 abline
# a는 y절편, b는 x 슬로프(기울기)
# x 축과 평행한 라인 horizontal line, h
# y 축과 평행한 라인 vertical line, v
x = rnorm(100) # 정규 분포 난수 생성
y = 2+2*x + rnorm(100)
plot(x,y, pch = 20, main = 'scatter plot')
abline(a = 1, b = 2, col = "red")
abline(v = 1, col = "blue") # x=1인 선
abline(h = 1, col = "green") # y=1인 선



# points 함수도 마찬가지
# point option : 선언한 원소 순서대로
plot(x = 1, y = 1, type = 'n', xlim = c(0,10), ylim = c(0,5),
     xlab = 'time', ylab = '# of visiting')
x = 10:0
set.seed(1)
y = rpois(length(x), lambda = 1)
points(x,y, col = "blue", type = "s") # 스텝
points(x,y, col = "red", type = "l") # 라인
x
y
points(x,y)
points(x,y,pch=1:11)



plot(x = 1,y = 1, type = 'n', xlim = c(0,10), ylim = c(0,5),
     xlab = 'time', ylab = '# of visiting')
set.seed(1)
x = 0:10
y = rpois(length(x), lambda = 1)
points(x,y,type = 's')
points(x,y,type = 'l', lty=3)





# exercise
View(mtcars)
str(mtcars)
plot(mpg ~ disp, data = mtcars, xlab = "displacement", ylab = "mile/gallon",
     main = "scatter plot", pch = 20, col = 'darkblue')






# lines
plot(0,0, type = 'n', xlim = c(-2,2), ylim = c(-2,2))
x = c(-2, 1, 0, 1, 0)
y = c(0, -1, 2, -2, 1)
lines(x,y)
points(x,y)





# line 순서대로 그리기 때문에 포인트 순서, 정렬이 중요하다
# 지도 그릴 때 (한국지도의 경우, 제주도는 NA 사용하면 돼)
plot(0,0, type = 'n', xlim = c(-2,2), ylim = c(-2,2))
x = c(-2, 1, NA, 1, 0)
y = c(0, -1, NA, -2, 1)
lines(x,y)






# 지도 그리는 경우 group 변수, order 변수 가지는 것이 일반적
# 1번 그룹, 2번 그룹 지정하면 서로 참조하지 않아
# order 변수에서는 순서를 지정





# recycle : elementwise operation
plot(0,0, type = 'n', xlim = c(1,5), ylim = c(0,2))
x = seq(1,5, by = 1) # 차이 1
x
abline(v = x, lty = 1:length(x))



# legend : 범례 그리기
z = sort(rnorm(100)) # rnorm이 random이라서 sort해줌
y1 = 2+ x + rnorm(100)
plot(z, y1, col = "blue", pch = 3)
points(z, y1/2, col = "red", pch = 19)
legend("topright", c("pch_3", "pch_19"), col = c("blue", "red"),
       pch = c(3,19))
# 위치, 텍스트, 컬러, pch - 요 순서


# exercise
z = sort(rnorm(100))
y1 = 2+ x + rnorm(100)
plot(z, y1, col = "blue", pch = 3)
points(z, y1/2, col = "red", pch = 19)
legend("bottomright", c("a", "b"), col = c("blue", "red"),
       pch = c(3,19))


# par function : 그래픽 func 조정
# 레이아웃 조정 : 한 번에 그림을 그리고 싶다
# 그림의 글자를 키우고 싶다
# par(mfrow = c(2,1)): 2×1 layout 만들어진 순서대로 넣겠다
# par(cex = 1.2): set the character expansion be 1.2 (1.2 times larger) 두께
# par(bg = 'gray90'): set the color of backgroupd by gray90
# par(las = 2): set the text on axis be orthogoal to the axis. 텍스트 세로로 쓰고 싶다
# par(mai = c(1,2,3,4)): from the bottom clockwisely, set the margin be 1,2,3,and 4. 띄우겠다

par(cex=1.2)
par(cex=3)
par(cex=1)
par(bg = 'white')



par (mfrow = c(1,1), bg = 'gray50', col = 'white',
     col.main = 'lightblue', col.axis = 'yellow', 
     col.lab = 'lightgreen')
x = rnorm(100)
y = 2+2*x + rnorm(100)
plot(x,y, main = "plot (x-y)-1", pch = 20)
y = 2+x + rnorm(100)
plot(x,y/2, main = "plot (x-y)-2")
y = 2+x + rnorm(100)
plot(x,y/3, main = "plot (x-y)-3", col.main = 'black')
y = 2+x + rnorm(100)
plot(x,y/4, main = "plot (x-y)-4", col.axis = 'white')



# ============================================================
#k-nearest
set.seed(1)
x <- sort(rnorm(100))
y<- 3+x^2 + rnorm(100)
plot(x, y, pch = 19)




#regression
set.seed(1)
x <- sort(rnorm(100))
y<- 3+x^2 + rnorm(100)
plot(x, y, pch = 19)
lm(y~x)
fit = lm(y~x)
str(fit) # 리스트의 체인? coefficients, residuals, effects 등의 객체 가져올 수 있음 $ 기호로)
fit$coefficients # 첫번쨰 intercept, 두번째 slope
coef = fit$coefficients
coef[1] # y절편 : 3.756537 
coef[2] # x기울기 : 0.1488341 
# 위 정보로 직선 찾을 수 있음. abline, 절편이 a, 슬로프가 b
abline(a=coef[1], b=coef[2], col="red") # lm의 라인





plot(x, y, pch=20)
abline(a=fit$coefficients[1], b=fit$coefficients[2], col='blue')
yTrueMean = 3+x^2 # 대충 잡아봄
lines(x, yTrueMean , lty=2, col='black')





install.packages("FNN")
library(FNN)
knnx.index(x, 0, k=10)
# 제일 가까운 애부터 k등까지 위치를 알려줌
# 찾고자 하는 점들의 위치
a = knnx.index(x, 0, k=10)
x[47]
x[46]
x
idx = a[1,] # 이 뜻이 뭔지?
# 점들을 그래프 위에 빨간색 점으로 표시할거야
points(x[idx], y[idx], pch=19, col="red")
# 기준점, x축을 세워주고 싶다
abline(v=0, lty=3) 
y[idx]
mean(y[idx]) # x=0, y^
abline(h=mean(y[idx]))







# 1 -> 0.5
library(FNN)
knnx.index(x, 0.5, k=10)
# 제일 가까운 애부터 k등까지 위치를 알려줌
# 찾고자 하는 점들의 위치
a = knnx.index(x, 0.5, k=10)
x[47]
x[46]
idx = a[1,]
# 점들을 그래프 위에 빨간색 점으로 표시할거야
points(x[idx], y[idx], pch=19, col="red")
# 기준점, x축을 세워주고 싶다
abline(v=0.5, lty=3) 
y[idx]
mean(y[idx]) # x=0, y^
abline(h=mean(y[idx]))
# ============================================================





#1. a와 같은 형태의 1000*1000 matrix
#2. 벡터를 넣으면 누적합을 계산하는 함수 my_csum
my_csum = function(x){
  n=length(x)
  xcsum=vector("numeric",n)
  xcsum[1]<-x[1]
  for (i in 2:n) {
  xcsum[i]=xcsum[i-1]+x[i]
  }
  return(xcsum)
}
my_scum(1:5)
#3. 균등분포(0,1)에서 난수 1000개를 뽑아 누적평균을 구하고 그래프 그리기
y=my_csum(runif(1000))/(1:1000)
plot(x=1:1000,y,type="1")
