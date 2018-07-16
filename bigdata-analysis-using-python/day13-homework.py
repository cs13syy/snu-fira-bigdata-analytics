# Assignment Number...: 10
# Student Name........: 양서윤
# File Name...........: hw10_양서윤
# Program Description.: 파일을 열고 자료를 처리하는 법을 익힌다.


from collections import defaultdict
dd = defaultdict(list)
subway_data = []
HeaderList = []
# collections 모듈에서 defaultdict를 불러온다.
# defaultdict는 k라는 키에 접근하려 했을 떄 만약 k라는 키가 딕셔너리에 없을 경우
# k를 키로 가지고 디폴트 값으로 y를 가지는 새로운 항목을 생성한다.
# 디폴트 값을 리스트로 설정한 디폴트 딕셔너리 dd를 생성한다.
# 빈 리스트 subway_data를 생성한다.
# 각 열의 첫째 데이터를 따로 저장하기 위해 빈 리스트 HeaderList를 생성한다.


f = open('subway.txt', mode='r', encoding='utf-8-sig')
lines = f.read().splitlines()
f.close()
# open 함수를 사용해 텍스트 파일을 읽는다. 읽기 작업을 위해 mode는 r로, 인코딩은 utf-8-sig로 설정하고 f 변수에 할당했다.
# 파일의 데이터를 read 함수로 읽고, 각 줄의 마지막에 새줄바꿈 없이 줄 단위로 나눈 후
# 리스트 형식으로 반환하는 splitlines 함수를 사용하여 변수 lines에 할당했다.
# lines 변수를 정의한 후 close 함수로 주어진 파일을 닫았다.


for i, line in enumerate(lines):
    line = line.split(',')

    if i == 0:
        for i in range(len(line)):
            HeaderList.append(line[i])
        continue

    row = dict(zip(HeaderList, line))
    subway_data.append(row)

print(subway_data)
# 데이터의 각 줄을 탐색하기 위해 for문을 사용했다.
# (인덱스, 항목)의 튜플을 제공하는 enumerate 함수를 사용해 각 줄에 인덱스를 부여했다.
# 각 줄의 항목 사이 구분이 ','로 되어 있기에, ','를 기준으로 분리하기 위해 구분자를 ','로 지정한 split 함수를 사용했다.
# 첫번째 줄을 헤더로 지정하기 위해, if 문을 사용해 첫번째 줄을 불러냈다.
# for 문과 range 함수를 사용해 첫번째 줄의 요소 개수만큼 루프문을 돌려, append 함수를 사용하여 요소를 하나씩 HeaderList에 추가했다.
# 헤더를 만들었으면, 순환문의 첫 명령문으로 되돌아가 다음 반복을 진행하기 위해 continue 명령어를 사용했다.
# 각 줄에 대해 HeaderList와 각 줄의 요소를 zip 함수로 쌍을 이루게 하여 딕셔너리로 형변환 하여 변수 row에 할당했다.
# append 함수를 사용해, row 변수를 앞에서 만든 리스트 변수 subway_data에 추가했다.


print('''==================== 테스트 1 ====================
토요일 승차 정보만 모은 목록''')
test1 = []
for list in subway_data:
    if list['요일'] == '토' and list['구분'] == '승차':
        test1.append(list)
print(test1)
# 수행예시에 제시된 대로 print 함수를 사용해 테스트 명과 탐색할 정보의 내용을 출력한다.
# 탐색할 정보를 저장하기 위해 빈 리스트 변수 test1을 생성한다.
# subway_data의 각 행을 탐색하기 위해 for 문을 사용했다.
# if 문과 딕셔너리 키, 밸류를 사용하여 요일이 토요일, 구분이 승차인 데이터만을 가져온다.
# 조건에 해당하는 행을 빈 리스트 test1에 추가하고, print 함수로 test1 리스트를 출력한다.

print('''==================== 테스트 2 ====================
7-11시 승하차 인원이 1만명 이상인 요일의 목록''')
test2 = []
for list in subway_data:
    if int(list['7']) + int(list['8']) + \
            int(list['9']) + int(list['10']) >= 10000:
        test2.append(list['요일'])
print(test2)
# 수행예시에 제시된 대로 print 함수를 사용해 테스트 명과 탐색할 정보의 내용을 출력한다.
# 탐색할 정보를 저장하기 위해 빈 리스트 변수 test2을 생성한다.
# subway_data의 각 행을 탐색하기 위해 for 문을 사용했다.
# 조건에 해당하는 데이터를 뽑아내기 위해 if 문을 사용했다.
# '7','8','9','10' 키에 해당하는 값을 불러와 합계 계산을 위해 정수로 형변환하고, 합계가 10000 이상인 조건을 만든다.
# 조건에 해당하는 행의 키 '요일'에 해당하는 값을 빈 리스트 test2에 추가하고, print 함수로 test2 리스트를 출력한다.


print('''==================== 테스트 3 ====================
날짜가 짝수인 날짜 중 8-9시 승하차 인원보다 9-10시 승하차 인원이 많은 날들의 정보를 모은 목록''')
test3 = []
for list in subway_data:
    if int(list['날짜']) % 2 == 0 and int(list['8']) < int(list['9']):
        test3.append(list)
print(test3)
# 수행예시에 제시된 대로 print 함수를 사용해 테스트 명과 탐색할 정보의 내용을 출력한다.
# 탐색할 정보를 저장하기 위해 빈 리스트 변수 test3을 생성한다.
# subway_data의 각 행을 탐색하기 위해 for 문을 사용했다.
# 조건에 해당하는 데이터를 뽑아내기 위해 if 문을 사용했다.
# 날짜가 짝수인 데이터를 뽑아내기 위해, key '날짜'에 해당하는 값을 가져와 정수로 형변환하고 2로 나눴을 때 나머지가 0인 조건을 만든다.
# 8-9시 인원보다 9-10시 인원이 많은 날의 데이터를 가져오기 위해, 키 '8'과 키 '9'에 해당하는 값을 가져와 정수로 형변환하고
# 비교 연산자를 사용하여 조건을 만든다.
# 조건에 해당하는 행을 빈 리스트 test3에 추가하고, print 함수로 test3 리스트를 출력한다.
