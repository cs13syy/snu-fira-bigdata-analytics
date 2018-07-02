# Assignment Number...: 5
# Student Name........: 양서윤
# File Name...........: hw5_양서윤
# Program Description.: 간단한 if-else 문과 for, while 문을 활용하는 법을 익힌다.


a = int(input('Enter a: '))
b = int(input('Enter b: '))
c = int(input('Enter c: '))

if a > b and a > c:
    print(b + c)
elif b > a and b > c:
    print(a + c)
else:
    print(a + b)


city = input('Enter the name of the city: ')
if city == 'Seoul':
    print('The size of {} is {}'.format(city, 605))
elif city == 'New York':
    print('The size of {} is {}'.format(city, 789))
elif city == 'Beijing':
    print('The size of {} is {}'.format(city, 16808))
else:
    print('Unknown')


import math
for i in range(1, 10):
    n = math.factorial(i)
    print(n)


import math
num = 0
while num < 10:
    n = math.factorial(num)
    print(n)
    num += 1
