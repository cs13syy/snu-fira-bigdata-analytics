restaurant_list = [{'상호': 'A', '메뉴': '피자', '가격(원)': 20000},
                   {'상호': 'B', '메뉴': '치킨', '가격(원)': 18000},
                   {'상호': 'C', '메뉴': '짜장면', '가격(원)': 5000},
                   {'상호': 'D', '메뉴': '초밥', '가격(원)': 15000},
                   {'상호': 'E', '메뉴': '치킨', '가격(원)': 23000},
                   {'상호': 'F', '메뉴': '족발', '가격(원)': 30000}]

want_to_eat = input('먹고 싶은 음식을 입력하세요 : ')

index = 0
while index < len(restaurant_list):
    if restaurant_list[index]['메뉴'] == want_to_eat:
        print('식당 {}, 가격 {} 원'.format(restaurant_list[index]['상호'], restaurant_list[index]['가격(원)']))
    index += 1
else:
    print('결과가 없습니다.')
