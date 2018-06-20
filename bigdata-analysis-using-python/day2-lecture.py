# receive input as integer
z = int(input('Enter integers : '))
print(z+1)

# casting practice
a=1
print(type(a))
x='1'
y='2'
print(x+y)

# lab 2-3-1
i=1234
s='1234'
print(i==s)
s=int(s)
print(i==s)

# lab 2-3-2
print('What is your name?')
x = input()

print('Hi! '+x)
print('The length of your name is:')
print(len(x))

y = int(input('What is your age? '))
print('You will be', y+1 ,'years old in the next year.')
print('Bye~~~!')

# print function practice
print()
print(end='\n')
print(print()==print(end='\n'))
print('python', 5,    'a',    15) # python 5 a 15
print('python', 5,    'a',    15, sep='+') #python+5+a+15
print('1', '2', '3', sep=' @ ', end=' end', file=open('num.txt', 'w'))

# print function - revisited
name = '홍길동'
print('Hi!', name) # Hi! 홍길동
print('Hi! ' + name) # Hi! 홍길동
# the results are the same
# , you can use several data types
# + you can use only one data type
# print(3, 'a') : success
# print(3 + 'a') : fail, you should use only one data type
print('a', 3, 'b') # a 3 b
print('a ' + str(3) + ' b') # a 3 b

# print function and merging string
age = input()
print('your age is', age)
print('당신의 나이는', age, '살 입니다.')
print('당신의 나이는', age + '살 입니다.')
print('당신의 나이는 {}살 입니다.'. format(age))
