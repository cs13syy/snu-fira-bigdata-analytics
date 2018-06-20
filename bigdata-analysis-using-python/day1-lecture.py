# 교수님의 파이썬 정의 : 파이썬은 다양한 모형을 조립할 수 있는 블록완구에 더 가깝다. 논리적인 사고로 표현만 할 수 있다면 마치 블록완구로 원하는 모형을 만들 수 있듯이 파이썬이 제공하는 다양한 기능들을 잘 조립만 한다면 나머지는 파이썬이 알아서 처리해준다

# 프로그램 개발 과정 :
# (1) 프로그램 논리 설계 및 개발
# (2) 프로그램 코드화 (코딩)
# (3) 기계어(machine language)로 변환 (컴파일)
# (4) 프로그램 실행과 검증

# always repeat the following task : googling -> copy&paste -> run -> think
# recommended coding style : PEP 8
# use only one kind of indentation (4 space or 1 tab)

# pseudocode practice : check if user's input is odd or even
a = int(input())
if a%2 == 0:
    print("짝수")
else:
    print("홀수")

# input() : always return string

# coding practice
number = input('1과 9 사이 정수 중 하나를 입력하세요..! ')
print('구구단', number + '단입니다.')
for i in range(1, 10):
    print(int(number)*i, end=' ')