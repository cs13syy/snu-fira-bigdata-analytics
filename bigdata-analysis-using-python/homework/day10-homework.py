# Assignment Number...: 7
# Student Name........: 양서윤
# File Name...........: hw7_양서윤
# Program Description.: 파이썬을 이용해 재미있는 프로그램을 구성해본다. 제어문을 활용하는 방법을 익힌다.



print('''
[전략 게임: 아이돌 팬으로 살아남기]
 게임 규칙:
   (1) 지갑 사정, 약간의 부끄러움, 육체적 피로가 5에 도달하면 아이돌 팬을 그만둔다.
   (2) 30 단계 후, 아이돌 팬은 나이가 들어 팬을 그만둔다.
   (3) 스밍하기 : 지갑 사정 +1, 육체적 피로 +1
   (4) 알바하기 : 지갑 사정 -1, 육체적 피로 +1
   (5) 사진보며 힐링 : 약간의 부끄러움 -1, 육체적 피로 -1
   (6) 타팬과의 갈등 : 육체적 피로 +1
   (7) 덕밍아웃 당함 : 약간의 부끄러움 +1''')

name = input('팬의 이름을 입력하세요: ')

# print 함수를 사용하여 전략 게임의 이름과 게임 규칙을 출력한다.
# 한 문장으로 출력하기 위해 ''' 세 개 따옴표를 사용했다.
# input 함수를 사용하여 팬의 이름을 입력하도록 하고, 그 결과를 name 변수에 할당했다.



m = 0
s = 0
t = 0
# 지갑 사정(money)을 나타내는 수치로 변수 m을 생성해 초기값을 0으로 설정했다.
# 약간의 부끄러움(shyness)을 나타내는 수치로 변수 s을 생성해 초기값을 0으로 설정했다.
# 육체적 피로(tiredness)을 나타내는 수치로 변수 t을 생성해 초기값을 0으로 설정했다.



i = 0
while i < 30:
    i += 1
    num = int(input('''
## 아이돌 팬의 상태 ###
지갑 사정: {} 
약간의 부끄러움: {}
육체적 피로: {}
아이돌 팬에게 어떤 명령을 내릴까요?
1 - 스밍하기 
2 - 알바하기 
3 - 사진보며 힐링 
4 - 타팬과의 갈등 
5 - 덕밍아웃 당함 
번호를 입력하세요 = > '''.format(m, s, t)))
# 초기값이 0으로 설정된 변수 i를 생성했다.
# 0부터 29까지 총 30번의 루프를 돌리기 위해 while 문을 사용하고 조건식을 "i < 30"로 설정했다.
# 변수 i의 값을 하나씩 증가시켜, 다음 입력값에 대해 while 문을 수행할 수 있도록 했다.
# 변수 i가 값이 30이 되면, while의 조건문이 거짓이 되므로 while 문을 빠져나가게 된다.
# input 함수를 이용하여 명령하고자 하는 번호를 받고, 정수로 변환하여, 변수 num에 할당했다.



    while m<5 and s<5 and t<5:
        if num == 1:
            m += 1; t += 1
            print('지갑 사정은 나빠지고 육체적 피로가 쌓였지만 {}은(는) 행복합니다.'.format(name))
            break
        elif num == 2:
            m -= 1; t += 1
            print('{}은(는) 알바로 피곤하지만, 돈이 생겼습니다!'.format(name))
            break
        elif num == 3:
            s -= 1; t -= 1
            print('아이돌의 얼굴을 보니 부끄러움은 사라지고 피로도 풀렸습니다.')
            break
        elif num == 4:
            t += 1
            print('{}은(는) 타팬과 다투어 피로감이 상승했습니다'.format(name))
            break
        elif num == 5:
            s += 1
            print('{}은(는) 뜻하지 않게 덕밍아웃을 당해 약간 부끄러워졌습니다.'.format(name))
            break
        else:
            print('번호가 잘못 입력되었습니다.')
            break
    else:
        if m == 5:
            print('## 아이돌 팬의 상태 ###\n지갑 사정: {}\n약간의 부끄러움: {}\n육체적 피로: {}\n'
                  '{}은(는) 탈덕했습니다. 왜냐하면 {}이(가) 돈이 없었기 때문입니다.'''.format(m, s, t, name, name))
            break
        elif t == 5:
            print('## 아이돌 팬의 상태 ###\n지갑 사정: {}\n약간의 부끄러움: {}\n육체적 피로: {}\n'
                  '{}은(는) 탈덕했습니다. 왜냐하면 {}이(가) 피로를 이기지 못했기 때문입니다.'''.format(m, s, t, name, name))
            break
        elif s == 5:
            print('## 아이돌 팬의 상태 ###\n지갑 사정: {}\n약간의 부끄러움: {}\n육체적 피로: {}\n'
                  '{}은(는) 탈덕했습니다. 왜냐하면 {}이(가) 많이 부끄러웠기 때문입니다.'''.format(m, s, t, name, name))
            break
# m, s, t가 종료시점인 5보다 작을 경우를 while문의 조건문으로 설정하고 m, s, t가 5가 되면 while문을 빠져나와 게임이 종료되도록 했다.
# if-elif-else문을 사용하여 번호에 따라 m, s, t의 값을 조정하고 print 함수를 사용하여 명령 결과에 대한 안내문이 출력되도록 했다.
# 사용자가 초기에 입력한 이름을 안내문에 출력하기 위해, format 함수를 사용했다.
# if, elif, else 각 끝에는 break를 사용하여 맨 위 루프로 돌아가 다음 입력값을 받도록 했다.
# 입력을 받는 변수인 num에 1~5까지의 숫자 외의 값이 들어올 경우 else에서 '번호가 잘못 입력되었습니다.'를 출력하도록 했다.
# m, s, t 중 그 어떤 것이 5가 될 경우, while 문을 빠져나와 else에서 각 변수에 따라 해당하는 문장을 출력하고 break을 사용하여 게임이 종료되도록 했다.
# 한 줄로 이어진 문장이 아니라 다음 줄로 넘겨서 출력하기 위해 개행문자 '\n'을 사용했다.
# 문장 출력 시 format 함수를 사용하여 m, s, t, name의 값을 가져와 출력하도록 했다.



else:
    print('## 아이돌 팬의 상태 ###\n지갑 사정: {}\n약간의 부끄러움: {}\n육체적 피로: {}\n'
          '{}은(는) 탈덕했습니다. 왜냐하면 {}이(가) 나이가 많아서 쉬기로 결정했기 때문입니다.'''.format(m, s, t, name, name))
# 제일 먼저 등장한 while문에서 중간에 break 없이 정상적으로 while문이 종료되었다면, else문이 시행되도록 한다.
# print 함수를 사용하여 게임 종료 문구를 출력했다.