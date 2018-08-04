# Assignment Number...: 2
# Student Name........: 양서윤
# File Name...........: hw2_양서윤
# Program Description.: 문자열(str) 자료형의 변수를 생성하고 슬라이싱(slice)하는 방법을 배운다

cellphone = 'Apple iphone7' # cellphone 변수를 만들고, 해당 변수에 핸드폰 정보를 문자열 형태로 할당했다.
print(cellphone) # print 함수를 사용해 cellphone 변수를 출력했다.
company = cellphone[0:5] # company 변수를 만들고, cellphone 변수를 슬라이싱해 핸드폰의 제조사를 선택하여 company 변수에 할당했다.
print(company) # print 함수를 사용해 company 변수를 출력했다.
model = cellphone[6:] # model 변수를 만들고, cellphone 변수를 슬라이싱해 핸드폰의 모델명을 선택하여 model 변수에 할당했다.
print(model) # print 함수를 사용해 model 변수를 출력했다.
print(type(company)) # type 함수를 사용해 company의 자료형을 확인하기 위해 print 함수로 출력했다.
print(type(model)) # type 함수를 사용해 model의 자료형을 확인하기 위해 print 함수로 출력했다.
print(('It had been that way for days and days.\n'
       ' And then, just before the lunch bell rang, he walked into our class room.\n'
       ' Stepped through that door white and softly as the snow.'))
# 해당 문장을 3개의 줄로 나누어 작성하기 위해 소괄호()를 사용했다.
# 첫번째, 두번째 문장 뒤에 이스케이프 문자가 들어간 개행 문자('\n')를 삽입하여 줄 바꿈을 했다.
# print 함수를 한 번만 사용해 문장을 출력했다.
