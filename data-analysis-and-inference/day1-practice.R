#프로그래밍 언어로서의 함수
myfunction <- function(x) {return (20+(x*x))}
myfunction(10)
myfunction(25)

#for 문
x = c(1, -6, 3, -5, 8, 4, -7, 2, 15)
cs = x[1] #cs는 x의 첫번째 인덱스
for (i in 2:length(x)) { #누적합이니까 첫번째는 제외
  cs[i]=cs[i-1]+x[i]
}
cs
cumsum(x) #위 과정은 누적합 함수 cumsum(x)의 작동원리

#while 문
b=122%%2 #b는 2로 나눈 나머지
quot=122%/%2 #quot는 2로 나눈 몫
while(quot>0) { #quot가 0보다 큰 이상 계속 반복 
  b=c(quot%%2, b) #b는 (몫을 2로 나눈 나머지, b)로 구성된벡터
  quot=quot%/%2 #quot는 quot를 2로 나눈 몫으로 재할당
}
b
#첫번째, b=0, quot=61, b=(1,0), quot=30, b=(0,1,0)

#break
x = 1:5
for (val in x) {
  if (val==3) {
      break
  }
  print(val)
}

#next
x = 1:5
for (val in x) {
  if (val==3) {
      next
    }
  print(val)
}