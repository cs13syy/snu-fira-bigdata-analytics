# data type : boolean practice (1)
bool(0) # F
bool(0.0) # F
bool(1) # T
bool(-1) # T
bool(10)  # T
bool(0.1) # T
bool('') # F
bool([]) # F
bool([1,2]) # T
bool(()) # F

# data type : boolean practice (2)
if False:
  Print("Hi") #
if False:
  Print("Hi") # "Hi"

# data type : boolean practice (3)
if True or False:
  print("Hello") # hello
if False and True:
  print("Hello") #
  
# data type : boolean practice (4)
t, f = True, False
t or f # T
t and f # F
f or False # F
t and True # T
not t # F
0 and 5 # 0 
1 and 5 # 5 (**short-circuit**)
1 or 5 # 1 (**short-circuit**)
0 or 5 # 5 (**short-circuit**)


===================================================

  
# data type : integer practice (1)
1 + 2 + 3 - 4 + 5 - 6 + 7 #8
3 * 5 # 15
4 / 2 # 2.0 (**in case of devision, return float**)
13 / 7 # 1.8754...
13 // 7 # 1
13 % 7 # 6
2 ** 3 # 8
1 + 2.0 # 3.0 (**if one is float, the result is also float**) 
3.0 - 3 # 0.0
1 * 1.0 # 1.0

# data type : integer practice (2)
x = 2 + 3 * 5 # 17
y = (2 + 3) * 5 # 25
x - y # -8
x -= y
x # -8
y /= 5 # 5.0
y //= 2 # 2.0
x += 11
x # 3
y **= x
y # 8.0
y %= x
y # 2.0

# data type : integer practice (3)
abs(-12) # 12
divmod(13, 7) # (1, 6) (**returns tuple**)
pow(2, 3) # 8
pow(2, 3, 5) # 3
round(1.23546, 1) # 1.2
round(1.23546, 2) # 1.24
round(1.23546, 3) # 1.235
round(123546, -2) # 123500
round(123546, -3) # 124000
round(123546.789, -3) # 124000.0

int() # 0 (**default is 0**)
int(10) # 10
int('10') # 10
int(12.9999) # 12
int('12.999') # error
int('10') # 10
int('10', 10) # 10
int('10', 2) # 2
int('10', 8) # 8
int('10', 16) # 16
int('00000011') # 11
int('00000011', 10) # 11
int('00000011', 2) # 3
int('00000011', 8) # 9
int('00000011', 16) # 17
int('65', 10) # 65
int('1000001', 2) # 65
int('101', 8) # 65
int('41', 16) # 65
int(65) # 65
bin(65) # 0b100001
oct(65) # 0o101
hex(65) # 0x41

# data tyoe : reset
x = 65 
type(x) # <class: 'integer'>
x = "A"
type(x) # <class: 'string'>











  
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
