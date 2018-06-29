# example : break와 stop의 차이 알 수 있는 example을 만들어라
# example : break
# break는 두번째 for문까지에 해당, 즉 i는 계속 돌아감
for (i in 1:3) {
	for (j in 1:3) {
		print(c(i, j))
		if (j==2) break
	}
}
#result : 
[1] 1 1
[1] 1 2
[1] 2 1
[1] 2 2
[1] 3 1
[1] 3 2
# example : stop
# stop은 두번째 뿐만 아니라 첫번째 for문도 멈추게 함
for (i in 1:3) {
	for (j in 1:3) {
		print(c(i, j))
		if (j==2) stop()
	}
}	
#result :
[1] 1 1
[1] 1 2
Error: 
# stop() : 에러를 만들어 내는 함수


# homework : rowwise average function
s_rowMean = function(x)
{
  if (class(x) != "matrix")
    stop("x is not matrix")
  v = rep(0, nrow(x)) # v가 matrix면, 저장 공간 미리 확보 
  for (i in 1:nrow(x))
  {
    v[i] = mean(x[i,]) # 행을 하나씩 가져와서 평균 계산
  }
  return(v)
}  

x = matrix(1:10, 5, 2)
x
s_rowMean(x) # 아래와 동일
s_rowMean(matrix(1:10, 5, 2))
