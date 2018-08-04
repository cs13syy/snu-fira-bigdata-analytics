# Assignment Number...: 6
# Student Name........: 양서윤
# File Name...........: hw6_양서윤
# Program Description.: 새로운 함수를 정의하는 방법을 익힌다. 람다 함수를 익힌다.


def area_triangle(h, w):
    return 0.5 * h * w
print(area_triangle(10, 15))
# 삼각형의 면적을 구하는 area_triangle() 함수를 정의했다.
# area_triangle() 함수의 매개변수로 h와 w를 설정했다.
# 함수의 결과값으로 삼각형의 면적인 0.5 * h * w를 반환하도록 했다.
# 함수를 불러와 인수 값으로 h에는 10, w에는 15를 입력하고 print 함수를 사용하여 출력했다.


def distance(a, b):
    x = (a[0]-b[0])**2
    y = (a[1]-b[1])**2
    d = (x+y)**(1/2)
    return d
print(distance((1,2), (5,7)))
# 2차원 공간 상에서 두 점 사이의 거리를 계산하는 distance() 함수를 정의했다.
# 함수의 매개변수로 a, b를 생성하여 2차원 공간 상에서 두 점의 좌표를 받도록 했다.
# for 문을 사용해 a와 b 사이의 거리를 계산하는 연산을 만들었다.
# a의 첫번째 인덱스 값과 b의 첫번째 인덱스 값의 차를 제곱하여 x 변수에 할당했다.
# a의 두번째 인덱스 값과 b의 두번째 인덱스 값의 차를 제곱하여 y 변수에 할당했다.
# x값과 y값을 더한 값의 제곱근을 구해, 두 점 사이의 거리를 나타내는 d 변수에 할당했다.
# 함수의 결과값으로 d, 즉 두 점 사이의 거리를 반환하도록 했다.
# distance() 함수를 불러와 인수 값으로 a에는 (1,2), b에는 (5,7)을 입력하고 print 함수로 출력했다.


def count(n):
    if n == 0:
        print('zero!!')
    else:
        print(n)
        count(n-1)
count(5)
# 하나의 인수 n을 갖는 count() 함수를 생성했다.
# 입력된 n에 대해 조건에 따라 다른 값을 출력하도록 if 문을 사용했다.
# 만약 n이 0과 같다면 'zero!!'를 출력하도록 했다.
# 만약 n이 0이 아니라면 n을 출력하도록 했다.
# 임의의 양의 정수인 n부터 0까지 세어보도록 하기 위해, 함수 자기 자신 count(n-1)을 호출했다.
# n의 값이 하나씩 작아지면서, 0이 될 때, 'zero!!'가 출력된다.
# 함수를 불러와 인수값으로 5를 입력하고 그 결과를 print 함수로 출력했다.


area_triangle_ld = lambda h, w: 0.5 * h * w
print(area_triangle_ld(10, 15))
# 삼각형의 넓이를 계산하는 area_triangle_ld() 람다함수를 생성했다.
# area_triangle_ld() 함수의 매개변수로 h, w를 설정했다.
# 함수의 결과값을 낼 표현식으로 삼각형의 면적인 0.5 * h * w를 입력했다.
# 함수를 불러와 인수 값으로 h에는 10, w에는 15를 입력하고 print 함수를 사용하여 출력했다.
