# Assignment Number...: 8
# Student Name........: 양서윤
# File Name...........: hw8_양서윤
# Program Description.: 함수를 정의하고 활용하는 법을 익힌다. 패키지와 모듈을 불러오는 법을 익힌다.

import datetime, time
now = datetime.datetime.now()
print(time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()))
# datetime, time 모듈을 불러왔다.
# datetime.now() 함수를 사용항 현재 시간을 now 변수에 할당했다.
# strftime() 함수를 이용해 지정된 시간 표현 형식을 작성하고, print 함수로 결과를 출력했다.


import calendar
print(calendar.isleap(2050))
print(calendar.weekday(2050, 7, 7))
# calendar 모듈을 불러왔다.
# isleap() 함수를 사용해 2050년이 윤년인지 알아보기 위해 파라미터로 2050을 입력, print 함수로 출력했다.
# weekday() 함수를 사용해 2050년 7월 7일이 무슨 요일인지 알아보기 위해, weekday의 파라미터로 2050, 7, 7을 입력, print 함수로 출력했다.


from collections import Counter
def vowel(sen):
    counts = Counter(sen)
    a_num = counts['a']
    e_num = counts['e']
    i_num = counts['i']
    o_num = counts['o']
    u_num = counts['u']
    print('The number of a: {}'.format(a_num))
    print('The number of e: {}'.format(e_num))
    print('The number of i: {}'.format(i_num))
    print('The number of o: {}'.format(o_num))
    print('The number of u: {}'.format(u_num))
    if a_num >= e_num and a_num >= i_num and a_num >= o_num and a_num >= u_num:
        sen = sen.replace('a', 'A')
    if e_num >= a_num and e_num >= i_num and e_num >= o_num and e_num >= u_num:
        sen = sen.replace('e', 'E')
    if i_num >= a_num and i_num >= e_num and i_num >= o_num and i_num >= u_num:
        sen = sen.replace('i', 'I')
    if o_num >= a_num and o_num >= e_num and o_num >= i_num and o_num >= u_num:
        sen = sen.replace('o', 'O')
    if u_num >= a_num and u_num >= e_num and u_num >= i_num and u_num >= o_num:
        sen = sen.replace('u', 'U')
    print(sen)
vowel('The regret after not doing something is bigger than that of doing something.')
# collections 패키지의 Counter 모듈을 불러왔다.
# 하나의 문장을 전달인자로 받도록 vowel() 함수를 정의했다.
# Counter 모듈을 사용해 하나의 문장을 받아 문장 내 알파벳 개수를 확인하도록 하고, 결과를 counts 변수에 할당했다.
# counts는 딕셔너리이므로, 문장 내 각 모음의 개수를 출력하기 위해, 모음을 key로 value 즉 개수를 얻고자 한다.
# 각 모음 별로, counts에서 모음을 key로하여 value로 개수를 뽑아내고, 모음_num 형태의 각 변수에 할당했다.
# print 함수를 사용하여 각 모음의 개수를 출력했다. 출력 시 format 함수를 사용하였다.
# 입력받은 문자열에서 가장 많은 개수를 가진 모음을 대문자로 바꾸어 새로운 문장을 출력하기 위해 if 문을 사용했다.
# 특정 모음의 개수가 다른 모음들의 각각의 개수보다 크거나 같은 경우, replace 함수를 사용하여 소문자를 대문자로 변경했다.
# 그리고 print 함수를 사용하여 결과를 출력했다.
# vowel() 함수를 호출하여 전달인자로 지정된 문자열을 입력했다.
