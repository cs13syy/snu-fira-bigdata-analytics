# Assignment Number...: 5
# Student Name........: 양서윤
# File Name...........: hw5_양서윤
# Program Description.: 간단한 if-else 문과 for, while 문을 활용하는 법을 익힌다.


a = int(input('Enter a: '))
b = int(input('Enter b: '))
c = int(input('Enter c: '))
# 사용자로부터 입력값을 받기 위해 input 함수를 사용해 3개의 정수 변수 a, b, c를 생성했다.

if a > b and a > c:
    print(b + c)
elif b > a and b > c:
    print(a + c)
else:
    print(a + b)
# 세 값을 비교하여 작은 값 2개의 합을 출력하기 위해 if 문을 사용했다.
# "a>b and a>c"가 참인 경우, 즉 a값이 b값과 c값 보다 클 경우, print 함수를 사용해 b+c 값을 출력하도록 했다.
# "a>b and a>c"는 거짓이나, "b>a and b>c"가 참인 경우 b값이 가장 큰 수이므로 print 함수를 사용해 a+c 값을 출력하도록 했다.
# "a>b and a>c"와 "a>b and a>c" 조건 모두 거짓인 경우, 즉 c값이 가장 큰 경우 print 함수를 사용해 a+b 값을 출력하도록 했다.


city = input('Enter the name of the city: ')
# input 함수를 사용해 사용자로 하여금 도시를 입력하도록 하고 그 결과를 city 변수에 할당했다.

if city == 'Seoul':
    size = 605
elif city == 'New York':
    size = 789
elif city == 'Beijing':
    size = 16808
else:
    size = 'Unknown'
# 사용자가 입력한 도시에 해당하는 면적을 출력하기 위해 if-elif-else 문을 사용했다.
# 입력값이 'Seoul'과 일치할 경우, size 변수의 값으로 605를 할당했다.
# 입력값이 'Seoul'이 아닌 'New York'과 일치할 경우, size 변수의 값으로 789를 할당했다.
# 입력값이 'Seoul', 'New York'이 아닌 'Beijing'과 일치할 경우, size 변수의 값으로 16808을 할당했다.
# 입력값이 'Seoul', 'New York', 'Beijing'도 아닌 그 외의 값일 경우, size 변수의 값으로 'Unknown'을 할당했다.

print('The size of {} is {}'.format(city, size))
# 문자열 포매팅(formatting)을 활용하여, 첫번째 인덱스 항목에는 format 함수의 첫번째 입력값인 city가,
# 두번째 인덱스 항목에는 format 함수의 두번째 입력값인 size가 되도록 하고, print 함수로 출력했다.


import math
#계승 값(factorial)을 계산하기 위해서 math 라이브러리를 불러온다.
for i in range(0, 10):
    n = math.factorial(i)
    print(n)
# 0부터 9까지 10개의 각 정수의 계승 값을 계산하기 위해 range(0, 10) 객체를 만들어 사용했다.
# range(0, 10)에 해당하는 모든 i 값을 탐색하기 위해 for 문을 사용했다.
# i 변수에 숫자들이 0부터 9까지 하나씩 차례로 대입되면서 계승 값을 구하는 "n = math.factorial(i)" 문장을 반복적으로 수행하게 된다.
# math 라이브러리의 factorial 함수를 사용하여, 각 i 값에 대한 계승 값을 변수 n에 할당했다.
# print 함수를 사용하여 변수 n을 출력했다.


import math
# 계승 값(factorial)을 계산하기 위해서 math 라이브러리를 불러온다.
num = 0
# 초기값이 0으로 설정된 num 변수를 생성했다.
while num < 10:
    n = math.factorial(num)
    print(n)
    num += 1
# 0부터 9까지 총 10번의 계승 값 계산을 하기 위해 while 문을 사용하고 조건식을 "num < 10"로 설정했다.
# math 라이브러리의 factorial 함수를 사용하여, 0부터 9까지 각 정수에 대한 계승 값을 변수 n에 할당했다.
# print 함수를 사용하여 변수 n을 출력했다.
# num 변수의 값을 하나씩 증가시켜, 다음 정수에 대해 while 문을 수행할 수 있도록 했다.
# num 변수의 값이 10이 되면, while의 조건문이 거짓이 되므로 while 문을 빠져나가게 된다.
