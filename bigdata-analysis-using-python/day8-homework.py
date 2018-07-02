# lab 4-15 (try/exception practice - 2)

while True:
    try:
        number = int(input("임의의 양의 정수를 입력하세요: "))
        if number <= 1:
            raise ValueError
        elif number == 2:
            print('이 숫자는 소수입니다.')
        for i in range(2, number):
            if type(number) == int and number > 0 and number % i == 0:
                print('{} x {} = {}'.format(i, int(number/i), number),
                      '이 숫자는 소수가 아닙니다.', sep='\n')
                break
        for j in range(2, number):
            if number == 2 or number % i != 0:
                print('이 숫자는 소수입니다.')
                break
    except:
        print('ValueError: 1보다 큰 양의 정수를 입력하세요.')
