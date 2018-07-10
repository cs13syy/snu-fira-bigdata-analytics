# ----------------------------
state.region
counts = table(state.region)
# table 함수 : 테이블로 만들어줌
counts
barplot(counts, main = "simple bar chart", 
        xlab = "region", ylab = "freq")

# ----------------------------
# 상대 빈도를 bar plot으로 표현하기
# bar의 높이가 상대빈도수
state.region
counts = table(state.region)
counts
counts/sum(counts) # 상대도수
barplot(counts/sum(counts), main = "simple bar chart", 
        xlab = "region", ylab = "freq")

# ----------------------------
# 아주 단순한 방법
mtcars$cyl
class(mtcars$cyl) # numeric
a = table(mtcars$cyl)
a # class table
barplot(a)
barplot(a/sum(a)) # 상대도수
        
# ----------------------------
# 정답
freq.cyl = table(mtcars$cyl)
barplot(freq.cyl, main = "simple bar chart", col ="orange")

# ----------------------------
# bar plot의 names.arg 옵션
cyl.name =  c("4 cyl", "6 cyl", "8 cyl")
barplot(freq.cyl, main = "simple bar chart", col ="orange",
        names.arg = cyl.name)

# ----------------------------
cyl.name =  c("4 cyl", "6 cyl", "8 cyl")
rel.cyl = freq.cyl/sum(freq.cyl)
rel.cyl = round(rel.cyl, 3)
class(rel.cyl) # class table
sum(rel.cyl)-1 # 합이 1이 아니야 1.001
# 합해놓고 모자라거나 넘치는 부분 보정
# 차이를 값이 가장 큰 항목에 반영함
# 1. 차이가 있는가? sum(rel.cyl)-1 이 값이 0인가?
if ((sum(rel.cyl)-1) != 0)
{
  d = sum(rel.cyl)-1 # d값이 얼마인가?
}
  rel.cyl[which.max(rel.cyl)] = 
  rel.cyl[which.max(rel.cyl)] - d 
# which max 가장 큰 값의 위치를 찾아내 그 값에 d 빼줌
barplot(freq.cyl, main = "simple bar chart", col ="orange",
        names.arg = cyl.name)

# ----------------------------
# 파이차트 만들기
# 아래 두개 거의 똑같다
pie(rel.cyl)
pie(freq.cyl)

# ----------------------------
# 파이차트 이름 만들기
cyl.name = names(freq.cyl)
cyl.name2 = paste0( cyl.name, "(", freq.cyl, "%)")
cyl.name3 = paste0( cyl.name, "(", rel.cyl*100, "%)")
pie(freq.cyl, labels = cyl.name2, 
    col = rainbow(length(freq.cyl)), main = "pie chart")
pie(freq.cyl, labels = cyl.name3, 
    col = rainbow(length(freq.cyl)), main = "pie chart")
# 합이 정확하게 1이 나오는 파이차트를 만들려면 위의 조정 작업해야함
# 소수점 정리하고 전처리 해야함

# ----------------------------
if(!require(plotrix)){install.packages("plotrix"); library(plotrix)}
pie3D(freq.cyl, labels = cyl.name2, explode = 0.1, main = "3d pie plot")

# ----------------------------
fan.plot(freq.cyl, labels = cyl.name2, main = "Fan plot")

# ----------------------------
if(!require(vcd)){install.packages("vcd"); library(vcd)}

head(Arthritis, n = 3)

# ----------------------------
my.table <- xtabs( ~ Treatment + Improved, data = Arthritis)
my.table # 포뮬라 : ~ Treatment + Improved

# ----------------------------
barplot( my.table,
         xlab = "Improved", ylab = "Frequency", legend.text = TRUE,
         col = c("green", "red"))
# 그래프 해석이 어려워 : 잘못 그렸어
# 알고 싶은 대상과 통제하는 대상을 고려해보자
# 통제 대상 treated, placebo가 설명 변수
# improved가 반응 변수
# treated, placebo에 따라 improved가 어떻게 다른가 : 이게 핵심

# ----------------------------
t(my.table) # transpose 함수, 전치행렬 만드는 연
barplot( t(my.table),
         xlab = "Improved", ylab = "Frequency", legend.text = TRUE,
         col = c("green", "red", "orange"))
# 해석 : 처치를 하니까 개선된 사람의 비율이 높아졌다
# 여기서 개선할 여지가 있는가? 이 경우 빈도수가 비슷한데, 많이 차이나는 경우는?

# ----------------------------
# relative freq 써서 한 눈에 보자
my.table <- xtabs( ~ Treatment + Improved, data = Arthritis)
my.table[,1]/43
my.table[,2]/41
#2
cbind(my.table[,1]/43, my.table[,2]/41)
#3
a <- colSums(my.table)
for (i in 1:length(a))
{
  my.table[,i] = my.table[,i]/a[i]
}
my.table
#4
my.table/rep(a, each=3) # 오류
#5
sweep(my.table, 2, a, FUN = '/')

barplot( t(my.table),
         xlab = "Improved", ylab = "Frequency", legend.text = TRUE,
         col = c("green", "red", "orange"))

# ----------------------------
# 범주형 변수 : association, 카이스퀘어 통계량
# random variable의 독립성 검정
tmp = c("buckled", "unbuckled")
belt <- matrix( c(58, 2, 8, 16), ncol = 2, 
                dimnames = list(parent = tmp, child = tmp))
belt

# ----------------------------
spine(belt, main="spine plot for child seat-belt usage",
      gp = gpar(fill = c("green", "red")))
# 그림 보니 독립이 아니다, 영향을 준다

# ----------------------------
x = rnorm(100)
boxplot(x, main = "boxplot", col ='lightblue')
# 진짜 mean = 0, var = 1
# 중심, 극단값, 대칭성, 퍼진 정도 다 알 수 있어

x = faithful$waiting
boxplot(x)
# 단점 :  봉이 두개라는 것 알아내지 못함 

# ----------------------------
x = faithful$waiting
hist(faithful$waiting, nclass = 8)
# 히스토그램이 box보다 더 많은 정보 가지고 있음
# nclass 계급구간 설정
# 높이를 확률로 표시 -> probability=T
# 종 모양 평균밀도함수
# 히스토그램은 추정량 for 확률밀도함수 

# ----------------------------
x = faithful$waiting
hist(faithful$waiting, breaks = seq(min(x), max(x), length = 10),
     probability = T)
# 브릭 조정 가능

# ----------------------------
x = faithful$waiting
hist(faithful$waiting, nclass = 10, probability = T)
lines(density(x), col = "red", lwd = 2)
# 밀도함수 density

fit = density(x)
lines(x = fit$x,
      y = fit$y,
      col = "red", lwd = 2)
y = density(x)
str(y)
y$y

# ----------------------------
if(!require(vioplot)){install.packages("vioplot"); library(vioplot)}

x = rpois(1000, lambda = 3)
vioplot(x, col = "lightblue")

# ----------------------------
x = rpois(1000, lambda = 3)
vioplot(x, col = "lightblue", names = 'variable')

# ----------------------------
attach(mtcars)
boxplot(mpg~cyl, data = mtcars, names = c('4 cyl','6 cyl', '8 cyl'),
        main = "MPG dist by cylinder")

# ----------------------------
# 좋지 않은 방법
hist(mpg[cyl==4], xlab="MPG", main = "MPG dist by cylinder",
     xlim = c(5, 40),  ylim = c(0,10), col = 'lightblue',
     nclass = trunc(sqrt(length(mpg[cyl==4]))))
hist(mpg[cyl==6], xlab="MPG", main = "MPG dist by cylinder",
     xlim = c(5, 40),  ylim = c(0,10), col = 'orange',
     nclass = trunc(sqrt(length(mpg[cyl==6]))), add= TRUE)
hist(mpg[cyl==8], xlab="MPG", main = "MPG dist by cylinder",
     xlim = c(5, 40),  ylim = c(0,10), col = 'red',
     nclass = trunc(sqrt(length(mpg[cyl==8]))), add= TRUE)
# add = TRUE : 그래픽 객체 initialize 하지 말고 덮어 그려라
# 데이터 개수에서 스퀘어루트(sqrt) 하고 소수점(trunc)을 버림
# 데이터가 적어서 bin의 개수 적게 잡힘
# 데이터가 가려져서 보이지 않음(orange)

# ----------------------------
# location, 산포 바로 비교하기 용이하므로 일반적으로 세로로 배열
# xlim, ylim을 다같이 맞추고 그렸다는 것 주의
par(mfrow = c(3,1)) # layout 3행 1열로 잡아주는
hist(mpg[cyl==4], xlab="MPG", main = "MPG dist by cylinder",
     xlim = c(5, 40),  ylim = c(0,10), col = 'lightblue',
     nclass = trunc(sqrt(length(mpg[cyl==4]))))
hist(mpg[cyl==6], xlab="MPG", main = "MPG dist by cylinder",
     xlim = c(5, 40),  ylim = c(0,10), col = 'orange',
     nclass = trunc(sqrt(length(mpg[cyl==6]))))
hist(mpg[cyl==8], xlab="MPG", main = "MPG dist by cylinder",
     xlim = c(5, 40),  ylim = c(0,10), col = 'red',
     nclass = trunc(sqrt(length(mpg[cyl==8]))))
# 교수님이라면 box plot 쓰겠다

# ----------------------------
par(mfrow = c(1,1))
plot(density(mpg[cyl==4]), xlab="MPG", main = "MPG dist by cylinder",
     xlim = c(5, 40), ylim = c(0, 0.26))
lines(density(mpg[cyl==6]), col = "red", lty = 2)
lines(density(mpg[cyl==8]), col = "blue", lty = 3)      
legend("topright", paste(c(4,6,8), "Cylinder"),
       col = c("black","red", "blue"),
       lty = c(1,2,3), lwd = 3, bty ="n")

# ----------------------------
tmp = c("buckled", "unbuckled")
belt <- matrix( c(58, 2, 8, 16), ncol = 2, 
                dimnames = list(parent = tmp, child = tmp))
belt

# ----------------------------
barplot( t(belt), main = "Stacked Bar chart for child seat-belt usage",
         xlab = "parent", ylab = "Frequency", legend.text = TRUE,
         col = c("green", "red"))
# 전치행렬 t
# 앞에서는 독립성 검정
# 여기서는 동질성 검정
# 지금 값에서 relative freq로 바뀌어야 하고 높이도 비슷하게 수정해야 함
