# Assignment Number...: 4
# Student Name........: 양서윤
# File Name...........: hw4_양서윤
# Program Description.: 제어문(조건문, 반복문)을 활용하는 법을 익힌다.

restaurant_list = [{'상호': 'A', '메뉴': '피자', '가격(원)': 20000},
                   {'상호': 'B', '메뉴': '치킨', '가격(원)': 18000},
                   {'상호': 'C', '메뉴': '짜장면', '가격(원)': 5000},
                   {'상호': 'D', '메뉴': '초밥', '가격(원)': 15000},
                   {'상호': 'E', '메뉴': '치킨', '가격(원)': 23000},
                   {'상호': 'F', '메뉴': '족발', '가격(원)': 30000}]
# 제시된 식당의 정보(상호, 메뉴, 가격)를 하나의 dict 자료형으로 만들기 위해 중괄호{}를 사욯했다.
# 식당 별로 상호, 메뉴, 가격을 키로 그에 대한 값을 밸류로 하여 총 6개의 딕셔너리를 만들었다.
# 6개의 딕셔너리를 원소로 갖는 리스트를 대괄호[]로 생성하여 restaurant_list 변수에 할당했다.

want_to_eat = input('먹고 싶은 음식을 입력하세요 : ')
# input 함수를 사용해 사용자가 먹고 싶은 음식을 입력 받아 그 결과를 want_to_eat 변수에 할당했다.
index = 0
# restaurant_list 내의 모든 딕셔너리를 탐색하기 위해 값이 0인 index 변수를 생성했다.
match = []
# 사용자가 먹고 싶은 음식이 restaurant_list에 있는지 확인하기 위해 빈 리스트 match를 생성했다.

while index < len(restaurant_list):
    if restaurant_list[index]['메뉴'] == want_to_eat:
        result = '식당 {}, 가격 {} 원'.format(restaurant_list[index]['상호'], restaurant_list[index]['가격(원)'])
        match.append(want_to_eat)
        print(result)
    index += 1
else:
    if want_to_eat not in match:
        print('결과가 없습니다.')

# 1. restaurant_list 내의 모든 딕셔너리를 탐색하기 위해 while 문을 사용했다.
# 2. 임의의 길이를 가진 식당 목록에 대해서도 동일한 수행을 적용하도록 하기 위해
#    while 문을 최대 len(restaurant_list)번 돌리는 것으로 설정했다.
# 3. 초기값이 0으로 설정된 index 변수의 값을 하나씩 증가시켜, 다음 딕셔너리에 대해 if 문을 수행할 수 있도록 했다.
# 4. index 변수값이 증가하면서, 특정 index에서 want_to_eat 입력값이 해당 딕셔너리의 '메뉴' 키에 해당하는
#    밸류와 동일할 경우, print 함수를 사용하여 해당 메뉴를 판매하는 식당과 가격을 출력하도록 했다.
# 5. format 함수를 사용하여, 해당 메뉴를 보유한 딕셔너리의 '상호', '가격(원)' 두 키에 해당하는 밸류를 출력하도록 했다.
# 6. want_to_eat과 딕셔너리의 '메뉴' 키의 밸류가 일치할 경우, append 함수를 사용하여 빈 리스트 match에 want_to_eat 요소를 추가했다.
# 7. restaurant_list 내의 모든 딕셔너리를 탐색했음에도 불구하고 want_to_eat 입력값이 메뉴에 없는 경우,
#    즉 match 리스트에 아무 요소도 없는 경우, print 함수를 사용하여 '결과가 없습니다.'라는 문장을 출력하도록 했다.
