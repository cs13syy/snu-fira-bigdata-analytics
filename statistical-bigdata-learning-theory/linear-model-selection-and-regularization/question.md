### 1. predict(ridge.mod,s=0,exact=T,type="coefficients")[1:20,] 
- exact=T? 


### 2. lambda=1e10
- 1e10? 10의 10승
- 유효숫자 표기법 참고


### 3. grid=10^seq(4,-1,length=100)
- 어떻게 해석? 10의 4승부터 10의 -1승까지 동일한 간격으로 100개


### 4. mpg\~poly(horsepower, i)와 mpg\~horsepower+I(horsepower^i)의 차이는?
- 앞의 경우 i가 3이면 1,2,3차 / 뒤의 경우 i가 3이면 1,3차
- (mpg\~poly(horsepower,3))의 경우 단순히 hp, hp^2, hp^3이 아니라 복잡한 1,2,3차식 제공, 아래처럼 만들기 위해서는 다 전개해서 계수 다시 계산해야
- (mpg\~hp,hp^2,hp^3)의 경우 그냥 hp, hp^2, hp^3 계수값 반환
  
### 5. SE와 SD의 차이?
- xmu의 추정량 xbar의 sd(standard deviation)은 se(standard error)
- sd는 모집단에 대한 표준편차, 결국에는 같은 말
