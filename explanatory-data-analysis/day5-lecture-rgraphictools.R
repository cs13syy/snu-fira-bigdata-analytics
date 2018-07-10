# --------------------------------------
set.seed(1)
x <- sort(rnorm(100)) #rnorm : 정규 분포 난수 생성
x  
y<- 3+x^2 + rnorm(100)
plot(x, y, pch = 20)

# --------------------------------------
fit <- lm(y~x)
fit # intercept : y절편, x : 기울기
fit$coefficient

# --------------------------------------
plot(x, y, pch = 20)
abline(a = fit$coefficients[1], b = fit$coefficients[2], col = 'blue')
yTrueMean <- 3+ x^2
lines(x, yTrueMean , lty=2, col='black')

# --------------------------------------
if(!require(FNN)){install.packages("FNN"); library(FNN)}

x <- sort(rnorm(100))
knnx.index(x, 0, k = 10)
idx <- c(knnx.index(x, 0, k = 10)) # 값이 아니라 index다
idx

library(FNN)
knnx.index(x, c(0, 1), k = 10)
idx <- c(knnx.index(x, c(0, 1), k = 10))
idx
# 첫 행 : 0과 가까운 애들
# 둘째 행 : 1과 가까운 애들

library(FNN)
knnx.index(x, 0, k = 10)
idx <- c(knnx.index(x, c(0, 1), k = 5)) # 가까운 애들 5개
idx

# --------------------------------------
yhat <- mean( y[idx] ) 
yhat 

# --------------------------------------
eval.point = 0 # evalutating point, 기준점
plot(x, y, pch = 20)
abline( v = 0, col = 'black')
idx <- c( knnx.index(x, eval.point, k = 10) )
idx
points( x[idx], y[idx], col = 'red', pch = 20)
abline(h = mean(y[idx]), lty = 2, col = 'red')
mean(y[idx])

# --------------------------------------
eval.n = 100
eval.point = seq(-3, 3, length = eval.n)
plot(x, y, pch = 20)
idx.mat <- knnx.index(x, eval.point, k = 10) # 1000개
idx.mat # x들이 어디에 있는가
yhat = rep(0, eval.n) # yhat 자리(칸) 미리 생성
for (i in 1:eval.n)   yhat[i]<-mean(y[idx.mat[i,]])
# 각 행의 10개 x 데이터의 평균에 해당하는 y값이 yhat
lines(eval.point, yhat, type='l', lty=2, col='red')
# small x가 eval.point
# idx.mat : 100개 행, 10개 열로 구성된 매트릭스

par( mfrow = c(1,1))

# --------------------------------------
par( mfrow = c(1,2))
plot(x, y, pch = 20)
abline( v = 1, col = 'black')
index.mat <- c(knnx.index(x, 1, k = 10))
index.mat
points( x[index.mat], y[index.mat], col = 'red', pch = 20)
abline(h = mean(y[index.mat]), lty = 2, col = 'red')

plot(x, y, pch = 20)
abline( v = -1, col = 'black')
index.mat<- c(knnx.index(x, -1 , k = 10))
points( x[index.mat], y[index.mat], col = 'red', pch = 20)
abline(h = mean(y[index.mat]), lty = 2, col = 'red')


# --------------------------------------
# 주변 포인트 한 개만 보고 싶다면? k 조정
eval.n = 100
eval.point = seq(-3,3, length= eval.n)
plot(x, y, pch = 20)
idx.mat <- knnx.index(x, eval.point , k = 1)
yhat = rep(0, eval.n)
for (i in 1:eval.n)   yhat[i]<-mean(y[idx.mat[i,]])
lines(eval.point , yhat, type= 'l', lty = 2, col = 'red')

eval.n = 100
eval.point = seq(-3,3, length= eval.n)
plot(x, y, pch = 20)
idx.mat<- knnx.index(x, eval.point , k = 100) 
yhat = rep(0,eval.n)
for (i in 1:eval.n)   yhat[i]<-mean(y[idx.mat[i,]])
lines(eval.point , yhat, type= 'l', lty = 2, col = 'red')
# 점 데이터가 100개인데, k도 100이니까 답은 100개의 평균 하나


# k가 10에서 1이 되니까, red line이 많은 점을 지나게 되어버림
# k가 100으로 커지니까 일직선이 됨, 전체 데이터가 100개
# 어떠한 점에서도 neighborhood는 모두 똑같기 때문에 일직선
# 모든 점에서 y^ 값이 같아
# knn에서 k의 역할? k는 y^의 모델의 복잡도(자유도, degree of freedom)를 결정
# 어떤 k가 좋을까요? 목적을 생각해보자
# 목적은? 어떤 x의 점이 생겼을 떄 그것의 y값을 '잘' 예측하는 것
# "잘 맞춘다" 기준을 x=0에서, yi는 과거자료 or 미래관측치(90%)
# 우리가 만든 것 y*, 실제값 yi의 차이 |yi-y*|2 (유클리디안 distance)
# y*은 y(0)^ 즉 x=0에서의 예측치, x=0 고정이니 (과거의)데이터에 의존
# 평가 시 고려사항: 미래 관측치, x값(고정), 과거 데이터(고정)
# random 한 것에 대한 평가, 숫자로 표현하는 방법, 대표값 = 평균, 분산
# random 값 자체를 다루지 않고 평균을 씌움 E((yi-y*)2) = x=0에서 잘하냐 못하냐
# 기대값을 구하려면 확률 분포 함수를 알아야 되는데 안 구해짐 (EE)
# 원래 구하고 싶은 값(EE)에 근사하는 다른 대안을 찾아야 한다
# 나중에 배우게 되는 prediction error, 본질을 알자

# --------------------------------------
# 예측 오류 근사 (아래 방법을 쓰면 목적에 맞는 좋은 k 선택 가능)
# validation set 
# cross-validation set 
# gcv 
# information criteria

# --------------------------------------
# 3d plot
a = matrix(1:25, 5, 5) # 2차원 어레이 매트릭스, ggplot에서는 tile이라 함
image(a) # minimum value: red, 큰 값은 white, heat color
# 3행 1열 요소인 3은 (3, 1)에 위치
# 행을 x 좌표계, 열을 y 좌표계로 받는다
# 2행 4열 요소인 17은 (4, 2)에 위치

z = matrix(1:15, 3, 5)
z
y = c(0.1, 0.5, 0.7, 0.8, 0.85) # z의 열 개수(y 좌표계)와 동일
x = c(2.1, 2.3, 2.7) # z의 행 개수(x 좌표계)와 동일
# x, y는 증가수열
# 숫자 8은 2행 3열, 위치는 (2.3, 0.7)

# --------------------------------------
# 같은 데이터, 하나는 평면 3d로
if(!require(scatterplot3d)){install.packages("scatterplot3d"); 
  library(scatterplot3d)}
attach(mtcars) 
# attach 함수는? 데이터를 R 검색 경로에 추가하여 변수명으로 바로 접근할 수 있게 한다
scatterplot3d(wt, disp, mpg, main="3D Scatterplot")

# --------------------------------------
# 같은 데이터, 하나는 plot 3d로, 돌려볼 수 있음
if(!require(rgl)){install.packages("rgl");  library(rgl)}
attach(mtcars)
plot3d(wt, disp, mpg, col="red", size=3)

# --------------------------------------
mypal = c('blue', 'red', 'green')
mtcars$cyl
class(mtcars$cyl)
factor(mtcars$cyl)
mypal[factor(mtcars$cyl)] # 4: 'blue', 6: 'red', 8: 'green'
plot3d(wt, disp, mpg, col= mypal[factor(mtcars$cyl)], size=10)
# 등급별로 보기 좋음

# --------------------------------------
volcano
dim(volcano) #[1] 87 61

z <- 2 * volcano        # Exaggerate the relief
x <- 10 * (1:nrow(z))   # 10 meter spacing (S to N)
y <- 10 * (1:ncol(z))   # 10 meter spacing (E to W)
z[30, 4] # 244
x[30] # 300
y[4] # 40
## Don't draw the grid lines :  border = NA
par(bg = "slategray")
persp(x, y, z, theta = 135, phi = 30, col = "green3", scale = FALSE,
      ltheta = -120, shade = 0.75, border = NA, box = FALSE)

# --------------------------------------
persp3d(x, y, z, col = "green3")
# x, y가 증가함수로 sorting 되어있어야 함
contour(x, y, z) # 등고선으로 표현
