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

# bit operation practice
x, y = False, True 
(x | y) # T
x, y = 1, 0
(x | y)  # 1
x, y = 0, 0
(x | y) # 0
x, y = True, False
(x & y) # F
x, y = 0, 1
(x & y) # 0
x, y = 1, 0
(x & y) # 0
x, y = False, 1 
(x ^ y) # 1 (WARNING, return numeric)
x, y = True, True
(x ^ y) # 0
x, y = 0, True
(x ^ y) # 1 (WARNING, return numeric)

bin(192) # 0b11000000 (count: 10)
x = 192 << 1 
bin(x) # 0b110000000 (count: 11)
x # 384
x = 192 >> 1 
bin(x) # 00b100000 (count: 9)
x 96
bin(-192) # -0b11000000
x = -192 << 1 
bin(x) # -0b110000000 
x # -384
x = -192 >> 1
bin(x) #-0b110000
x # -96


===================================================

  
# data type : float practice (1)
3 + 7.0 # 10.0
3 * 7.0e+1 # 210.0 (WARNING)
.0 - .2 # -0.2
float('+1.2345') # 1.2345
float('     -12.345') # -12.345
float(123) # 123.0
float('-.4528') # -0.4528
float('-11') # -11.0
float('1e3') # 1000.0 (WARNING)
float(-1e-3) # -0.001 (WARNING)
float('-Infinity') # -inf
float('3.14') / float(-.1) # -31.4

# data type : float practice (2)
from fractions import Fraction
x = Fraction(3, 7)
print(x) # 3/7
y = x * 2
print(y) # 6/7
a - Fraction(8, 6)
print(a) # 4/3
b = Fraction(8, 4)
print(b) # 2 (WARNING, returns integer)
c = Fraction(0, 0)
print(c) # error


===================================================


# data type : string practice (1)
'안녕 파이썬' # '안녕 파이썬'
"안녕 파이썬" # "안녕 파이썬"
print('안녕 파이썬') # 안녕 파이썬 # print() does not show quotation marks
print("안녕 파이썬") # 안녕 파이썬 # print() does not show quotation marks

# data type : string practice (2)
y = '\t일\n월\n화\n수\n목\n금\n\t토'
y # '\t일\n월\n화\n수\n목\n금\n\t토'
print(y)

# data type : string quiz
# print the sentence with 3 methods using print() function only once
# (1) 3 quotation marks
print('''
President Barack Obama said,
 "Don't just play on your phone,
\tprogram it."''')
# (2) single quotation mark
print('President Barack Obama said,\n "Don\'t just play on your phone,\n\tprogram it."')
# (3) double quotation marks
print("President Barack Obama said,\n \"Don't just play on your phone,\n\tprogram it.\"")

# data type : string what to remember
# (1) line continuation : use (()) instead of \
# (2) if you want to escape from string escape, use raw string 'r'
# (3) ord() : unicode char -> unicode int
# (4) chr() : unicode int -> unicode char
