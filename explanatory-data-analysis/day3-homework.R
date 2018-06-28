# example : break와 stop의 차이 알 수 있는 example을 만들어라
v <- c("Hello","loop")
cnt <- 2

repeat {
   print(v)
   cnt <- cnt + 1
	
   if(cnt > 5) {
      break
   }
}

# homework : rowwise average function
s_rowMean = function(x)
{
  if (class(x) != "matrix")
    stop("x is not matrix")
  v = rep(0, nrow(x)) # v가 matrix면, 저장 공간 미리 확보 
  for (i in 1:nrow(x))
  {
    v[i] = mean(x[i,]) # 열을 가져와서 평균 계산
  }
  return(v)
}  
# ctrl + alt + f : 함수 실행

x = matrix(1:10, 5, 2)
x
s_rowMean(x)
s_rowMean(matrix(1:10, 5, 2))
