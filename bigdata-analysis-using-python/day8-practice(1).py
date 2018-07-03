# basic practice
a = 1
print(a)
a == 2
b = 3
a + b

7*8
13//3
43%3
13%3

a = 'py'
b = 'thon'
print('a + b = ', a+b)
print('a x 5 = ', a*5)




# 자료 형태
# int 사이즈가 작다
# float 사이즈가 크다, 용량 많이 잡아먹는다
# int 사이즈 작고 불러오기 편하고, 불러와서 float으로 바꾸는 게 어렵지 않고 오래 걸리지 않는다

a = 1
print(type(a))
b= 1.
print(type(b))
d = 'a'
print(type(d))

a = 0.0
b = 2
a + b

a = 1
print('a : ', a, 'a type : ', type(a))
a = float(a)
print('a : ', a, 'a type : '. type(a))

a = [123, 'a, 45, 'hello', 678]
a[0]
a[1]
a[1:4]

a = [123, 'a', 45, 'hello', 678]
a.extend([5]) # 리스트 형태로 입력해야 한다
print(a)
a.append(6) # [] 없이 값만 입력하면 된다
print(a)
len(a)




# 제어문
if True:
    print(1)
# 한 줄로 쓸 수 있음 
if True: print(1)

x = 1
i = 0
while x<1000:
    x*=2
    i+=1
print('x =', x)
print('i =', i)

# for loop 내가 원하는 만큼 제어하고 사용할 수 있음
# while 문을 위험해서 쓰지 않는 편

x = 1
i = 0
while x<1000:
    x*= 2
    i+= 1 
    if i > 5: break        
print('x =', x)
print('i =', i)

for word in ['a', 'b', 'c', 'd']:
    print(word)
    
sum = 0 
for i in range(1, 11): # 11이 일종의 제어
    sum += i    
sum




# quiz (answer)
numlist = [2, 6, 10, 3, 8, 2, 12, 4, 0, 5]
maxnum = numlist[0] # maxnum 변수는 numlist의 첫번째 인덱스 값
for x in numlist: # numlist 원소 각각에 대해
    if maxnum < x: # maxnum이 x보다 작으면
        maxnum = x # maxnum을 x로 교체
print(maxnum) # 결과적으로 최대값이 numlist의 첫번째 인덱스 값이 된다




# quiz (mine)
numlist = [2, 6, 10, 3, 8, 2, 12, 4, 0, 5]
numlist.sort()
print(numlist[-1])




# 자료 처리를 위한 python 라이브러리
# numpy : 어레이, 행렬에 대한 것, 데이터프레임, 숫자형으로만 이루어져 있어서 속도가 빠름, optimization
# np.array 함수로 다차원 배열을 생성, 배열 안의 배열로 차원을 구분
# np.reshape 함수로 차원 변경 가능
# pandas : 범주형 변수, 클래스, 탐색적 자료 분석
# 원하는 결과가 나왔는지 반드시 체크하기

import numpy as np
a = np.array([[1, 2, 3],
             [4, 5, 6]])
print('shape of a: ', a.shape) # a.shape : a의 행과 열 개수를 반환
a

a = np.arange(15) # 디폴트 시작이 0, 0부터 15-1까지 (range와 동일)
a # array([0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14])
a = np.arange(1, 15) # 스타트값 지정
a # array([1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14])
np.__version__

a = np.arange(15)
# a.reshape(3, -1) # 3행으로 만들고 싶고, 열은 네가 알아서 해라
a = a.reshape(3, 5)
b = np.arange(15).reshape(3, 5)
print('a: ', a)
print('b: ', b)
# a: [[ 0  1  2  3  4]
      [ 5  6  7  8  9]
      [10 11 12 13 14]]
# b: [[ 0  1  2  3  4]
      [ 5  6  7  8  9]
      [10 11 12 13 14]]
     
     
np.zeros((3, 4))
# array([[ 0.,  0.,  0.,  0.],
         [ 0.,  0.,  0.,  0.],
         [ 0.,  0.,  0.,  0.]])
np.ones((2, 3, 4), dtype = np.int8)
# array([[[1, 1, 1, 1],
         [1, 1, 1, 1],
         [1, 1, 1, 1]],
 
         [[1, 1, 1, 1],
         [1, 1, 1, 1],
         [1, 1, 1, 1]]], dtype=int8)


n = 10
a = np.zeros(n)
for i in range(n):
    a[i] == i**2
    
b = []
n = 10
for i in range(n):
    b.extend([i**2])
    
    

# numpy indexing
b = np.arange(15).reshape(3, 5)
print(b)
# b: [[ 0  1  2  3  4]
      [ 5  6  7  8  9]
      [10 11 12 13 14]]
print(b[0, 1]) # 인덱싱은 리스트와 똑같다
print(b[:, np.array([0, 3])]) # 1열과 4열만 뽑는 것
print(b[np.array([True, False, True]), :])
print(b[np.array([True, False, True]), :1])

b[np.array([True, False, True]), np.array([0, 3])]
np.where #조건에 만족하냐 안하냐
b[np.array([True, False, True])][:, np.array([0, 3])]
tmp = [[1, 2, 3], [4, 5, 6]]
tmp[1][1]



#quiz numpy
#뽑힐 확률 동일, np.random.random으로 균등분포 (0,1)을 따르는 난수를 생성할 수 있다
#unifmat = np.random.random(size = (100,5))은 균등분포 (0, 1)을 따르는 100x5의 행렬을 생성한다.
#unifmat에서 세 번째 열이 0.3 보다 작고 네번째 열이 0.7보다 큰 행들을 논리 연산자를 이용하여 추출하시오.

# np.random.seed(123) : 난수 생성 방법론 하나 선택
unifmat = np.random.random(size = (100, 5))
print(unifmat)
unifmat[(unifmat[:, 2] < 0.3) & (unifmat[:, 3] > 0.7),:]
