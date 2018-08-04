# input 함수를 사용해 사용자가 좋아하는 계절을 질문하고 그 결과를 season 변수에 할당했다.
season = input('What is your favorite season? ')

# 현재 문자열인 season 변수를 출력하기 위해 print 함수를 사용했다.
print(season)

# input 함수를 사용해 사용자가 태어난 날짜를 질문하고 그 결과를 date 변수에 할당했다.
date = input('Which date were you born? ')

# type 함수를 사용해 date의 자료형을 확인하기 위해 print 함수를 사용해 출력했다.
print(type(date)) 

# float 함수를 사용해 현재 문자열인 date 변수를 실수형으로 변환하고 print 함수로 출력했다.
print(type(float(date))) 

# 사용자가 좋아하는 계절과 태어난 날짜를 한 문장에 출력하기 위해 print 함수를 사용했다.
# 문자열 연산 중 덧셈(+)을 사용하여 하나의 문장을 만들었다.
print('My favorite season is ' + season + '. ' + 'I was born on the ' + date + 'th.')
