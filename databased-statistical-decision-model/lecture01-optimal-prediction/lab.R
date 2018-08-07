#----- Sec 3: Probability and Distributions ----------------------------------------#


#--- 1. Prussian horsekick data (p. 32)
k = c(0, 1, 2, 3, 4) # number of death
x = c(109, 65, 22, 3, 1) # freq
p = x / sum (x) # relative frequencies
print (p)
par ( mfrow = c(1 ,2)) #multiple graphs
barplot (x, names = k); pie(x)
r = sum (k * p) # mean
v = sum (x * (k - r)^2) / 199 # variance
f = dpois (k, r) #poisson density, 단위 시간당 죽음이 일어날 횟수에 대한 기대값이 r일때, k번 일어날 확률
print( cbind (k, p, f)) # 사망수, 실제 사망수 비율, 포아송 분포(기대값 0.61일때)로부터의 사망수 확률


#--- 2. Random sampling

#sample function : random sampling from finite population
sample (1:40 ,5)
sample (c("H","T"), 10, replace =T) # replace=T : 복원추출
sample (c("s","f"), 10, replace =T, prob =c(0.9 , 0.1)) # success 나올 확률을 0.9로


#--- 3. The built-in distributions in R

#dnorm, pnorm, qnorm, and rnorm
x = seq ( -4, 4, 0.1); pp = seq (0, 1, 0.001);
par( mfrow = c(2,2))
plot (x, dnorm(x), type = "l")       #Density or point probability
plot (x, pnorm(x), type = "l")       #Cumulated probability, distribution function
plot (pp, qnorm (pp), type = "l")    #Quantiles
plot (rnorm (200))                   #random numbers


#----- Sec 4: R Graphics -----------------------------------------------------------#

#--- Generic x-y plot


# Example 1: plot, text and abline
par (mfrow = c(1,1))
x <- runif(50,0,2); y <- runif(50,0,2) #random sample in uniform(0,2) distribution
plot (x, y, main =" Main title ", sub =" subtitle ",
      xlab ="x- label ", ylab ="y- label ")
abline (a = 0.5 , b = 1) #a: intercept, b : slope
abline (h = 0.5 , col = 'red ')
abline (v = 0.5 , col = " blue ")
text (0.5 ,0.6 , " text at x = 0.5 , y = 0.6 ")


# Example 2: plot, text and lines
head ( USArrests )
attach ( USArrests )
plot ( Murder , Assault , pch = 20, col = " red ") #pch : plotting character
text ( Murder , Assault , rownames ( USArrests ), cex = 0.5) #cex : scaling of text
localregfit <- lowess ( Assault ~ Murder ) 
#lowess returns an object containing components x and y which give the coordinates of the smooth
#추세선 찾는 방법 중 하나
lines ( localregfit $x, localregfit $y )


# Example 3: Print the rownames instead of symbols
plot ( Murder , Assault , type = "n")
text ( Murder , Assault , rownames ( USArrests ), cex = 0.5)


# Example 4: Scatterplot matrix for multi-variate data frame
plot( USArrests ) #or
pairs( USArrests )


#----- Sec 5: R Programming Basics -------------------------------------------------#

#--- 1. Flow Control

#Conditional Executions: if statement
if(1==0){
  print(1)
}else{
  print(2)
}

# Conditional Executions: ifelse statement operates on vectors
x <- 1:10
ifelse (x <5, x, 0)

# for Loops : Loops over a fixed set of values
x <- seq (0, 1 ,.05)
plot (x, x, ylab ="y", type ="l")
for ( j in 2:8 ) lines (x, x^j)

# while Loops: Iterates as long as a condition is true
z <- 0
while(z <5){
  z <- z + 2
  print (z)
}

# while Loop with break statement
z <- 0
while(T) {
  z <- z+ 1
  print(z)
  if(z>2) break
}


#--- 2. The apply function family (p. 52)
# apply a function to each element of a set of values or vectors and collect the results in a single structure.

head( USArrests )
apply ( USArrests , 2, mean ) # 1:row, 2:column, vector 출력

#lapply : returns a list
#sapply : tries to simplify the result to a vector or a matrix if possible. 가능한 간단하게. 주로 vector.

install.packages("ISwR")
library(ISwR)
str(thuesen)
lapply(thuesen, mean, na.rm=T)
sapply ( thuesen , mean , na.rm=T)

#tapply : factor에 따라 첫번째 인자의 function값을 출력 
#median of energy expenditure for each level (lean, obese)
data ( energy )
str ( energy )
head( energy )
tapply ( energy $ expend , energy $ stature , median ) 


#--- 3. Your Own R functions (p. 55)

# most of the R software can be viewed as a series of R functions.
# easily write custom functions

# R function example 1
myfn <- function (x1, x2=5) {
  z1 <- x1 / x1
  z2 <- x2 * x2
  myvec <- c(z1 , z2)
  return ( myvec )
}
myfn(x1=2, x2=3)
myfn(2,3)
x <- myfn(5); x

# R function example 2
hist.with.normal <- function (x, xlab = deparse (substitute(x)) ,...){
    h <- hist (x, plot=F, ...)
    s <- sd(x)
    m <- mean (x)
    ylim <- range (0, h$density , dnorm (0, sd=s)) #min, max value
    hist (x, freq =F, ylim =ylim , xlab =xlab , ...)
    curve ( dnorm (x,m,s), add =T)
}

hist.with.normal(USArrests$Murder)
# deparse(substitute(x)) 입력값을 캐릭터로 변환하여 넣어줌
