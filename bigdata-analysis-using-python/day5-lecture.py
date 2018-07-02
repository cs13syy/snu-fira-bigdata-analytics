a = 10
c = a * a * a
d = a + c
print(d)



b = 10.0
d = b * 3 - 10
e = d % 4
print(e)



str1 = 'I'
str2 = 'love '
str3 = 'Python'

str4 = str1 + str2 + str3 #변수끼리의 +는 사이에 띄어쓰기
str4 = str4[0:6]
str5 = str4 + 'programming'
print(str5)



# lab 3-1-4
meal = 137.50
tax_rate = 8.875
tip = 15 / 100
total = (meal + meal*tax_rate/100) * (1+tip)
print('{}'.format(round(total, 2))) # 소수점, a번째 자리까지



empty1 = []
print(empty1)
empty2 = list()
print(empty2)

L = ['Python']
print(L)
name = ['뽀빠이', '피카츄', '펠릭스', '아톰', '미니']
print(name)

list1 = list('Korea') 
print(list1) # ['K', 'o', 'r', 'e', 'a']
list2 = ['Korea']
print(list2) # ['Korea']
print(len(empty1), len(empty2), len(L), len(name), len(list1), len(list2))



complex = ['프로도', '네오', ['라이언', '무지', '어피치']]
len(complex) # 3
complex[1] # '네오'
complex[2] # ['라이언', '무지', '어피치']
complex[2][-1] # ['어피치']
complex[-1][1][0] # ['무] # str도 인덱스 가능



a = [1, 2, 3]
b = [4, 5, 6]
c = a + b
c # [1, 2, 3, 4, 5, 6]

['a', 'b'] + ['c', 'd'] # ['a', 'b', 'c', 'd']

[0] * 5 # [0, 0, 0, 0, 0]
[1, 2, 3] * 3 # [1, 2, 3, 1, 2, 3, 1, 2, 3]



L = ['프로도', '네오']
# L += 307 : error, int는 iterable이 아니다

L += [307]
L # ['프로도', '네오', 307]

L += '제이지' # 순회형이라 하나씩 들어가
# ['프로도', '네오', 307, '제', '이', '지']

L[3:] = []
L += ['제이지']
print(L) # ['프로도', '네오', 307, '제이지']



s = ['a', 'b', 'c', 'd']
s[1:2] # ['b']
s[1] # 'b'



int_str1 = []
for i in range(1, 10):
    int_str1.append(str(i))
int_str2 = [str(i) for i in range(1, 10)]
print(int_str1)
print(int_str2)



int_str_odd1 = []
for i in range(1, 10):
    if i % 2 == 1:
        int_str_odd1.append(str(i))   
int_str_odd2 = [str(i) for i in range(1, 10) if i % 2 ==1]
print(int_str_odd1)
print(int_str_odd2)



odd_integers = [i for i in range(10) if i % 2 == 1]
squares = [pow(i, 2) for i in odd_integers]
print(odd_integers)
print(squares)



pairs = [(x,y) for x in range(2, 10)
            for y in range(1, 10)]
print(pairs)
print(len(pairs))
multiplication_tuple = [(x, y, x*y) for x in range(2, 10)
                            for y in range(1, 10)]
print(multiplication_tuple)
print(len(multiplication_tuple))



triples = [(x, y, z)
          for x in range(1, 10)
              for y in range(x+1, 10)
                  for z in range(y+1, 10, x+1)]
print(triples)
print(len(triples))



# 중첩 리스트 축약 형식
sku = [(gender + size + color)
       for gender in 'FM'
           for size in 'SMLX' 
               if not (gender == 'F' and size == 'X') 
               for color in 'WGRB']
print(sku) # if not 위치 상관 없음
sku = [gender + size + color for gender in 'FM' for size in 'SMLX' for color in 'WGRB' if not (gender == 'F' and size == 'X')]
print(sku)



# 추가 설명
for x in [1, 2, 3]
    for y in [4, 5, 6]
        for z in [7, 8, 9]
# 1 - 4, 5, 6 - 7, 8, 9, 7, 8, 9, 7, 8, 9 
# 총 27개 



# 튜플
# 리스트 = 인덱스, 순서 있고, 가변형, []
# 튜플 = 인덱스, 순서 있고, 불변형, ()
a = '홍길동'
b = 27
a, b # ('홍길동', 27)

# 튜플 생성
empty1 = ()
print(empty1)
empty2 = tuple()
print(empty2)

T = ('파이썬',) # 쉼표 있는 것 주의
print(T)

# tuple, list
x = [1, 2, 3]
y = [4, 5, 6]
z = y
y[0] = 3
print(y)
print(z)



stock = dict(키보드=2, 드럼=3, 기타=11, 베이스=5, 색소폰=1)
from collections import OrderedDict
OrderedDict(sorted(stock.items()))
OrderedDict(sorted(stock.items(), key=lambda e: len(e[0])))
OrderedDict(sorted(stock.items(), key=lambda e: e[0]))



x = [1, 2, ['드럼', '기타', '베이스']]
y = x.copy()
y is x, y == x
x[0] = 'Python'
y[-1][-1] = '키보드'
x # ['Python', 2, ['드럼', '기타', '키보드']]
y # [1, 2, ['드럼', '기타', '키보드']], 위의  x에서 리스트 복사



import copy
x = [1, 2, ['드럼', '기타', '베이스']]
y = copy.deepcopy(x)
y is x, y == x
x[0] = 'Python'
y[-1][-1] = '키보드'
x # ['Python', 2, ['드럼', '기타', '베이스']]
y # [1, 2, ['드럼', '기타', '키보드']]



# Lab 3-2-1
e = [1, 7, [4, 9], 'f', ('a', 'b')]
e.append('g')
print(e)
print(e[4:6])



# Lab 3-2-2
atuple = (1, 5, (2, 3), 'green', ['드럼', '기타'])
btuple = atuple[-2:]
(2, 3) in atuple
5 in btuple



# Lab 3-2-3
s1 = {2, 4, 5, 7}
s2 = {1, 2, 7, 9}
s1 | s2
s1 & s2



# Lab 3-2-4
d = {'even':(2, 4, 6, 8, 10), 'odd':(1, 3, 5, 7, 9), 'prime':(2, 3, 5, 7)}
d
d['all'] = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
d
del d['odd']
d
