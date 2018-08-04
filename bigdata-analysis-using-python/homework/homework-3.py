# Assignment Number...: 3
# Student Name........: 양서윤
# File Name...........: hw3_양서윤
# Program Description.: 문자열 서식을 활용하는 방법을 익힌다. 리스트(lists),
# 튜플(tuples)을 생성하는 방법을 익힌다. 리스트와 튜플을 슬라이싱(slice)하는 방법을 익힌다.

steak = 30000
vat = 15
total = int(steak * ((100 + vat)/100))
# 스테이크의 가격, VAT, VAT가 반영된 실제 가격을 각각 steak, vat, total 변수에 할당했다.
# VAT가 반영된 실제 가격은 나누기 연산으로 인해 float 값이 출력되므로 int()를 사용하여 정수로 변환해 total 변수에 할당했다.
print(('스테이크의 원래 가격은 {0} 원입니다. 하지만 VAT가 {1}%로, 계산하셔야 할 가격은 {2} 원입니다.').format(steak, vat, total))
# 문자열의 format 메소드를 사용, 대체필드의 필드명으로 위치 전달인자의 인덱스를 사용했고, 입력을 원하는 순서대로 변수를 입력값으로 넣었다.
# print 함수를 사용해 문장을 출력했다.

s = '@^TrEat EvEryonE yOu meet likE you want tO be treated.$%'
s = s[0:3] + s[3:].lower()
# 문자열 가장 처음의 대문자 T는 바뀌지 않아야 하기에, 문장 맨 앞 '@^T' 부분을 s[0:3]으로, T 이후 나머지 문자열을 s[3:]로 슬라이싱 했다.
# s[3:]에 해당하는 문자열을 대문자에서 소문자로 바꿔야 하므로 lower() 메소드를 사용했다.
# 두 문자열을 '+'로 결합하여 변수 s에 다시 할당했다.
s = s.strip('@^$%')
# 문자열 앞 뒤에 있는 특수문자를 제거하기 위해 문자열 양쪽에서 원하는 문자를 제거할 수 있는 strip() 메소드를 사용했다.
# 특수문자를 제거한 문자열을 다시 s에 할당했다.
print(s)
# print 함수를 사용해 문장을 출력했다.

numbers = (2, 18, 26, 89, 45, 39, 14)
# 소괄호()를 사용하여 제시된 정수들을 순서대로 입력, numbers 튜플을 생성했다.
print(numbers)
# print 함수를 사용해 numbers 튜플을 출력했다.

print(len(numbers))
# len 함수를 사용해 numbers 튜플에 포함된 요소의 개수를 확인하기 위해 print 함수로 출력했다.

fruits = ['apple', 'orange', 'strawberry', 'pear', 'kiwi']
# 대괄호[]를 사용하여 제시된 집합의 원소를 순서대로 입력, fruits 리스트를 생성했다.
print(fruits)
# print 함수를 사용해 fruits 리스트를 출력했다.
fruits_sub = fruits[0:3]
# fruits 리스트의 첫 세 요소만 가져올 수 있도록 fruits 리스트를 fruits[0:3]로 슬라이싱해 변수 fruits_sub에 할당했다.
print(fruits_sub)
# print 함수를 사용해 fruits_sub 리스트를 출력했다.
