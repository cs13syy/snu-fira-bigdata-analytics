1. predict(ridge.mod,s=0,exact=T,type="coefficients")[1:20,] 
- exact=T? 


2. lambda=1e10
- 1e10?


3. grid=10^seq(4,-1,length=100)
- 어떻게 해석? 10의 4승, 10의 -1승 사이에 100 간격으로


4. mpg\~poly(horsepower, i)와 mpg\~horsepower+I(horsepower^i)의 차이는?
- 앞의 경우 i가 3이면 1,2,3차 / 뒤의 경우 i가 3이면 1,3차
  
  
5. SE와 SD의 차이?
- xmu의 추정량 xbar의 sd(standard deviation)은 se(standard error)
- sd는 모집단에 대한 표준편차, 결국에는 같은 말
