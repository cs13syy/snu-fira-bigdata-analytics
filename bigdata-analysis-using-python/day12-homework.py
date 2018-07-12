# Assignment Number...: 9
# Student Name........: 양서윤
# File Name...........: hw9_양서윤
# Program Description.: csv 파일을 불러와 읽는 방법을 익힌다. txt 파일을 파싱하는 방법을 익힌다.


with open('cars.csv', mode='r') as cars:
    for line in cars:
        print(line)
# open() 함수를 이용해 'cars.csv' 파일을 읽기 모드로 읽어온다.
# with 문으로 파일 전체를 읽고, 후에 파일 객체가 자동으로 close될 수 있도록 한다.
# for 문을 사용하여 'cars.csv' 파일의 각 줄을 불러와 print 함수로 출력했다.


with open('cars.csv', mode='r') as cars:
    alist = []
    for line in cars:
        line = tuple(line.split(','))
        alist.append(line)
    print(alist)
# open() 함수를 이용해 'cars.csv' 파일을 읽기 모드로 읽어온다.
# with 문으로 파일 전체를 읽고, 후에 파일 객체가 자동으로 close될 수 있도록 한다.
# 빈 리스트를 생성하고 변수 alist에 할당한다.
# for 문을 사용하여 파일의 각 줄을 불러온다.
# 각 행의 내용을 콤마를 기준으로 나누기 위해 split 함수를 사용하여 구분자로 콤마를 입력한다.
# 각 행마다 하나의 튜플을 생성하도록 하기 위해 tuple()을 사용하여 튜플로 형 변환한다.
# 콤마를 기준으로 split하고 튜플로 변환한 각 행(line)을 변수 line에 재할당한다.
# append() 함수를 사용하여 빈 리스트인 alist에 요소로 추가한다.


with open('My way.txt', mode='r') as myway:
    for line in myway:
        print(line)
# open() 함수를 이용해 'My way.txt' 파일을 읽기 모드로 읽어온다.
# with 문으로 파일 전체를 읽고, 후에 파일 객체가 자동으로 close될 수 있도록 한다.
# for 문을 사용하여 'My way.txt' 파일의 각 줄을 불러와 print 함수로 출력했다.


with open('My way.txt', mode='r') as myway:
    lines = myway.readlines()
    print(lines[2])
with open('My way.txt', mode='a') as myway:
    myway.write("\nI'll state my case, of which I'm certain")
with open('My way.txt', mode='r') as myway:
    final = myway.read()
    print(final)
# open() 함수를 이용해 'My way.txt' 파일을 읽기 모드로 읽어온다.
# with 문으로 파일 전체를 읽고, 후에 파일 객체가 자동으로 close될 수 있도록 한다.
# readlines() 함수를 이용해 파일의 내용을 한 줄 단위로 읽어 각 행의 내용을 하나의 리스트 요소로 저장한다.
# readlines() 함수로 읽어온 파일의 내용을 변수 lines에 할당한다.
# lines의 타입은 리스트이므로, 인덱싱을 사용해 세 번째 요소에 접근, print 함수로 출력한다.

# open() 함수를 이용해 'My way.txt' 파일의 마지막에 내용을 추가하는 'a' 모드로 읽어온다.
# with 문으로 파일 전체를 읽고, 후에 파일 객체가 자동으로 close될 수 있도록 한다.
# write() 함수를 사용해 'My way.txt' 파일에 지정된 문구를 추가한다.
# 새줄바꿈을 하여 다음 줄에 문구를 입력해야 하므로, 문자열 앞에 새줄바꿈을 하는 '\n'을 입력했다.

# open() 함수를 이용해 'My way.txt' 파일을 읽기 모드로 읽어온다.
# with 문으로 파일 전체를 읽고, 후에 파일 객체가 자동으로 close될 수 있도록 한다.
# 파일의 모든 데이터를 한 개의 문자열로 반환하는 read() 함수를 사용해 전체 내용을 읽어온다. 읽어온 내용을 final 변수에 할당했다.
# print 함수를 사용해 final을 출력했다.
