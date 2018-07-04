# lab - 소수 구하기
while True:
    try:
        i = int(input('임의의 양의 정수를 입력하세요: '))
        if not isinstance(i, int) or i < 2:
            raise ValueError
    except ValueError:
        print('ValueError: 1보다 큰 양의 정수를 입력하세요.')
        continue
    else:
        break

# --- 소수 확인 절차
# 전달인자의 값을 2부터 n-1까지의 숫자로 나누어, 나머지가 0인 숫자가 있으면 소수가 아니다.
for n in range(2, i):
    if i % n == 0: # 1과 자신 외에 나누어 떨어지는 수가 존재하면 소수가 아니다.
        print('{} x {} = {}'.format(n, int(i//n, i)))
        print('이 숫자는 소수가 아닙니다.')
        break
else: # 1과 자신 이외에 제수가 없는 경우
    print('이 숫자는 소수입니다.')
    
    
    
# 함수를 사용할 때 필요한 정보 : 함수 이름, 전달인자 개수와 자료형, 반환값 자료형
# 매개변수 : 함수 실행할 때 내부에서 사용되는 식별자
# 전달인자 : 함수 호출 시 넣어주는 값
# 함수에서 반환하는 값이 있을 수도 또 없을 수도 (ex: print 함수, 반환 안하고 출력)
# 함수의 종류: 전역함수, 지역함수, 람다함수, 메소드(클래스 명시)
# print 함수에서 키워드 end=': ' -> 줄바꿈 하지 않는다 



# function practice
def hi():
    print('안녕하세요 교수님!')
def person(name):
    print('제 이름은 {}입니다.'.format(name))
hi()
person('Emily')
person('John')
person('Amy')



# 람다함수 : sth = lambda 매개변수 : 표현식
# 간편 조건문 사용 시 if-else 구문 사용 가능

x = lambda i : '' if i == 1 else 's'
count = 1
print('{} file{} processed.'.format(count, x(count)))
count = 5
print('{} file{} processed.'.format(count, x(count)))


def area(b, h):
    return 0.5 * b * h
area(4, 5)


x = lambda b, h: 0.5 * b * h # 익명함수
x(4, 5)


pair = [(2, 'n', 'Pineapple'), (1, 'b', 'Orange'), (1, 'a', 'Banana'), (1, 'b', 'grape'), (2, 'a', 'apple')]
pair.sort() # 대문자가 소문자보다 먼저
pair
pair.sort(reverse=True)
pair
pair.sort(key = lambda e: (e[1], e[2])) # 2열, 3열 기준으로 sorting
pair
pair.sort(key = lambda e: e[1:3], reverse=True) # 위와 같은데 반대
pair
pair.sort(key = lambda e: (e[1], e[2].lower())) # e[1], e[2] # 대소문자 구분없이 소문자로 정렬
pair



# void function
def void_product(i, j):
    print('{}와 {}의 곱은 {}'.format(i, j, i*j))    
void_product(3, 5)
x = void_product(3, 5)
print(x) # None
print(void_product(3, 5)) # 출력하고, return값 없다



# value-returning product
def value_returning_product(i, j):
    return i * j
value_returning_product(3, 5)
x = value_returning_product(3, 5)
print(x)
print(value_returning_product(3, 5)) 


def value_returning_product(i, j):
    return i - j
    return i * j
y = value_returning_product(3, 5)
print(y)
# 첫번째 return만 실행됨, 두번째는 시행 안 됨


def value_returning_product(i, j):
    return i - j, i * j
y = value_returning_product(3, 5)
print(y)


# another use of return : pass
def positive_product(i, j):
    if i<0 or j<0:
        return
    print('{}와 {}의 곱은 {}'.format(i, j, i*j))
positive_product(5, 7) # 5와 7의 곱은 35
positive_product(-5, 7) # 함수 빠져나감 
positive_product(5, -7) # 함수 빠져나감



# 위치 전달인자
def string_head(text, length=7, indicator='...'):
    if len(text) > length:
        text = text[:length - len(indicator)] + indicator
    return text
s = '파이썬과 빅데이터 분석' # 12

string_head(s) 
string_head(s, 9)
string_head(s, 9, '!!!')
string_head(s, 20, '!!!')
string_head(s, length=20, '!!!') # 키워드 전달인자는 위치 전달인자 앞에 나올 수 없다
string_head(s, indicator='!!!', length=20) # 이건 된다
string_head(s, '!!!', length=20) # error, error 안나려면 indicator='!!!')
string_head(s, '!!!') # error : 앞에서 나오는 전달인수 값 다 있어야 하나요?



# 키워드 전달인자
def string_head(text, length=7, indicator='...'):
    if len(text) > length:
        text = text[:length - len(indicator)] + indicator
    return text
s = '파이썬과 빅데이터 분석'

string_head(length=9, text=s)
string_head(s, indicator='~~~') # 위치 전달인자가 키워드 전달인자보다 앞에 있으므로 문제 없음
string_head(s, indicator='~~~', length=15) # 위치 전달인자가 키워드 전달인자보다 앞에 있으므로 문제 없음
string_head(indicator='^^^^^^^', length=10, text=s) # 순서 상관 없음



# * 표시 : * 뒤에는 무조건 키워드 전달인자만 나와야 함
def product_in_units(i, j, k, *, units='square meters'):
    result = i * j * k
    return '{} {}'.format(result, units)

product_in_units(2, 3, 4)
product_in_units(2, 3, 4, units='square inches')
product_in_units(2, 3, 4, 'square inches') # * 뒤에 위치 전달인자 나왔으므로 error



# * 표시가 전달인자 맨 앞에 있는 경우 : 위치 전달인자 사용 않고 전부 키워드 전달인자로 사용할 것
def print_setup(*, paper='A4', copies=1, color=False):
    print("프린터 셋팅: paper='{}', copies={}, color={}".format(paper, copies, color))
    
print_setup() # 기본으로 출력
print_setup(paper='Letter', color=True) # 요청한대로 바뀜
print_setup('Letter') # error, *가 있는데도 불구하고 위치 전달인자를 사용해서



# **kwargs : 정해져 있지 않은 키워드 전달인자의 뭉탱이를 의미, very flexible
def add_fruit_detail(fruit_name, date_produced, **kwargs):
    print('과일종류 =', fruit_name)
    print('생산일자 =', date_produced)
    for key in sorted(kwargs): # sorted : 가나다순, sort된 뭉탱이의 key에 대해서
        print('{} = {}'.format(key, kwargs[key])) # 이 format 형식으로 출력하라

add_fruit_detail('블루베리', '9일')
add_fruit_detail('바나나', '11일', 원산지='필리핀')
add_fruit_detail('오렌지', '11일', 원산지='제주도', 수량=55)



#위치 전달인자, 키워드 전달인자 패킹/언패킹, 엄청 flexible 해졌다
def print_args(*args, **kwargs):
    for i, arg in enumerate(args): # 위치 전달인자 args에 대해서, i는 인덱스
        print('위치 전달인자 {} = {}'.format(i, arg))
    for key in kwargs: # 키워드 전달인자 kwargs에 대해서
        print('키워드 전달인자 {} = {}'.format(key, kwargs[key]))
print_args('라이언', -7, 2.5, age=19, email='ryan@korea.kr')



# 전역 변수
x = '안녕 파이썬'
def func():
    y = '나는 파이썬을 사랑합니다'
    print(x)
    print(y)
    
    
# nonlocal 문
x = '안녕 파이썬'
def func():
    x = 'Hi Python'
    def localfunc():
        nonlocal x
        x = '코딩'
        print(x)
    print(x) 
    localfunc()
    print(x)
    
func() # Hi Python, 코딩, 코딩
x # '안녕 파이썬'
