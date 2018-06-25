# data type : string practice (3) - index
s = '안녕 파이썬'
s[0] # '안'
s[2] # ' '
s[4] # '이'
s[6] # error (WARNING)
s[-1] # '썬'
s[-3] # '파'
s[-6] # '안'
s[-7] # error (WARNING)

# data type : string practice (4) - slicing
# seq[start:end] : the 'end' is not included
# seq[start:end:step] : if step < 0, start from the back (WARNING)
s = 'abcde 12345'
len(s) # 11
s[:] # 'abcde 12345'
s[0:len(s)] # 'abcde 12345'
s[2:8] # 'cde 12'
s[2:] # 'cde 12345'
s[-7:] # 'e 12345'
len(s[1:3]) # 2
s[::3] # 'ad14'
s[:-4:3] # 'ad1'
s[::-2] # '531eca'
s[:4:-2] # '531'
s[2:4:-2] # ''

# data type : string practice (5) - slicing
# in case of slicing, no error sign if you go out of the boundary
s = "초급자를 위한 파이썬"
len(s) # 11
s[11] # error
s[11:] #''
s[10] # '썬'
s[8:11] # '파이썬'
s[8:99] # '파이썬' (no error)

# data type : string practice (5) - revising
s = '초급자를 위한 파이썬'
s[0] = '중' # error
t = '중' + s[1:]
t # '중급자를 위한 파이썬'
s # '초급자를 위한 파이썬' 
s = '중' + s[1:] # relocation, garbage
s # '중급자를 위한 파이썬'
s = s[:7] + ' 맛있는 ' + s[8:]
s # '중급자를 위한 맛있는 파이썬'
s.replace('중', '초') # '초급자를 위한 맛있는 파이썬' 
s # 중급자를 위한 맛있는 파이썬' (s no change)
s.replace('중', '진짜 초') # '진짜 초급자를 위한 맛있는 파이썬'
s # '중급자를 위한 맛있는 파이썬'

# data type : string practice (6) - class attribute
import string
string.whitespace
# ' \t\n\r\x0b\x0c'
string.ascii_letters
# 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
string.ascii_lowercase
# 'abcdefghijklmnopqrstuvwxyz'
string.ascii_uppercase
# 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
string.digits
# '0123456789'
string.hexdigits
# '0123456789abcdefABCDEF'
string.octdigits
# '01234567'
string.punctuation
# '!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
string.printable
# '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c'

# data type : string practice (7) - combination
'a' 'b' 'c' # 'abc'
first_name = '길동'
'홍' first_name # error
'홍' + first_name # '홍길동'
print('홍', first_name) # 홍 길동

'jins' + 'o' * 7 # 'jinsooooooo'
'jins' + 7 * 'o' # 'jinsooooooo'
s = '홍길동'
print(s * 3) # 홍길동홍길동홍길동
s = '홍길동\n'
print(s * 3)
# 홍길동
# 홍길동
# 홍길동

# data type : string practice (8) - join()
# str.join(iterable) : string, list, tuple, set, dictionary
languages = ['Python', 'Java', 'Ruby']
' '.join(languages) # 'Python Java Ruby'
''.join(languages) # 'PythonJavaRuby'
'=><='.join(languages) #'Python=><=Java=><=Ruby'
', '.join(reversed(languages)) # 'Ruby, Java, Python'
'+'.join([1, 2, 3]) # error, integer is not iterable

# data type : string practice (9) - split()
# str.split(sep=None, maxsplit=-1) from the left
# str.rsplit(sep=None, maxsplit=-1) from the right
# returns list
eng = 'Introduction to Python'
kor = '파이썬을 배우면서 파이썬을 즐기자!!!'
kor.split() # ['파이썬을', '배우면서', '파이썬을', '즐기자!!!']
kor.rsplit(maxsplit=1) # ['파이썬을 배우면서 파이썬을', '즐기자!!!'] (maxsplit=-1, all)
eng.split('t', 2) #['In', 'roduc', 'ion to Python'] (sep is not included)
eng.rsplit('o') # ['Intr', 'ducti', 'n t', ' Pyth', 'n']
'    \t     \n    \n\t  \t   '.split() # []
# if sep is not set, continuous whitespace is regarded as one sep
# in case of empty string or string with only whitespaces, returns empty list 
# if sep is set but it is empty string, returns ['']

# data type : string practice (10) - partition()
# str.partition(sep) # from the left 
# str.rpartition(sep) # from the right
# returns 3-tuple : before sep, sep, after sep
# if sep does not exist, returns str itself and two empty str
eng = 'Introduction to Python'
kor = '파이썬을 배우면서 파이썬을 즐기자!!!'
eng.partition(' ') # ('Introduction', ' ', 'to Python') 
eng.rpartition(' ') # ('Introduction to', ' ', 'Python')
kor.partition('!') # ('파이썬을 배우면서 파이썬을 즐기자', '!', '!!')
s = '/usr/local/bin/python'
s.rpartition('/') # ('/usr/local/bin', '/', 'python')
s.rpartition('x') # ('', '', '/usr/local/bin/python')

# data type : string practice (11) - strip()
# str.strip([chars]) - from the both sides
# str.lstrip([chars]) - from the left 
# str.rstrip([chars]) - from the right
# if no chars, remove all whitespace
eng = 'Introduction to Python'
kor = '파이썬을 배우면서 파이썬을 즐기자!!!'
eng.strip('InoP') # 'troduction to Pyth'
kor.rstrip('!') # '파이썬을 배우면서 파이썬을 즐기자'
eng.lstrip('ntroduction) # 'Introduction to Python'
# there is no 'I'(first str for lstrip) so you can't strip
eng.rstrip('ntroduction) # 'Introduction to Pyth'
s = '\t 금연!!   \t!    \n'
s.strip() # '금연!!   \t!'
s.lstrip() # '금연!!   \t!    \n'
s.rstrip() # '\t 금연!!   \t!'       

# data type : string practice (12) - replace()
# str.replace(old, new, count) 
s = 'I like Python programming'
s.replace('like', 'do love') # 'I do love Python programming'
s # 'I like Python programming'
s = s.replace('like', 'do love')
s # 'I do love Python programming'
s.replace('o', '0', 2) # 'I d0 l0ve Python programming'

# data type : string practice (13) - methods related to English
eng = 'Introduction to Python'
eng.title() # 'Introduction To Python' - first one of each word capitalized
eng.capitalize() # 'Introduction to python' - first one capitalized
eng.lower() # 'introduction to python'           
eng.upper() # 'INTRODUCTION TO PYTHON'
eng.swapcase() # 'iNTRODUCTION TO pYTHON'

# data type : string practice (14) - count()
# str.count(sub, start, end)
eng.count('o') # 4
eng.count('o', -2) # 1
eng.count('o', 0, -2) # 3 - end is not included
kor.count('파이썬') # 2         
          
# data type : string practice (15) - find()
# str.find(sub, strat, end)
# str.rfind(sub, strat, end)          
# if no sub, returns -1
eng.find('t') # 2
eng.rfind('t') # 18
kor.rfind('파') # 10
kor.rfind('Python') # -1

# data type : string practice (16) - index()
# str.index(sub, strat, end)
# str.rindex(sub, strat, end)          
# if no sub, returns error
eng.index('t') # 2
eng.rindex('t') # 18
kor.index('파이썬') # 0
kor.index('python') # error
           
# data type : string practice (17) - startswith(), endswith()
# str.startswith(prefix, strat, end)
# str.endswith(prefix, strat, end)          
eng.startwith('i') # False
eng.endswith('Python') # True
kor.startswith('파이썬') # True
kor.endswith('자') # False
           
# data type : string practice (18) - is~()
'\n '.isspace() # True
' t'.isspace() # False
'a학'.isalpha() # True
'a3학'.isalpha() # False, '3'
'-3'.isdigit() # False, '-'
'1.23'.isdigit() # False, '.'
'007'.isdigit() # True
           
'-3'.isdecimal() # False, '-'
'1.23'.isdecimal() # False, '.'
'007'.isdecimal() # True
'-3'.isnumeric() # False, '-'
'1.23'.isnumeric() # False, '.'
'007'.isnumeric() # True
s = chr(8533) # unicode int -> char
s # '⅕'
s.isdigit() # False
s.isdecimal() # False
s.isnumeric() # True 
           
'-3a동'.isalnum() # False, '-'
'3a동'.isalnum() # True
'-3'.isalnum() # False, '-'
'1.23'.isalnum() # False, '.'
'07호C'.isalnum() # True
           
'-3'.isprintable() # True
' 3'.isprintable() # True
''.isprintable() # True
' '.isprintable() # True
'\n\t'.isprintable() # False
' \n'.isprintable() # False
'n '.isprintable() # True

eng = 'Introduction to Python'           
eng.istitle() # False
eng.islower() # False
eng.isupper() # False
           
# data type : string practice (19)
kor = '파이썬을 배우면서 파이썬을 즐기자!!!'
kor.center(25) # '  파이썬을 배우면서 파이썬을 즐기자!!!  '
kor.center(24) # ' 파이썬을 배우면서 파이썬을 즐기자!!!  '
kor.center(25, '#') # '##파이썬을 배우면서 파이썬을 즐기자!!!##'
kor.center(10, '#') # '파이썬을 배우면서 파이썬을 즐기자!!!'
kor.ljust(25) # '파이썬을 배우면서 파이썬을 즐기자!!!    '
kor.ljust(25, '!') # '파이썬을 배우면서 파이썬을 즐기자!!!!!!!'
kor.ljust(15, '!') # '파이썬을 배우면서 파이썬을 즐기자!!!'
kor.rjust(15, '!') # '파이썬을 배우면서 파이썬을 즐기자!!!'
kor.rjust(25, '$') # '$$$$파이썬을 배우면서 파이썬을 즐기자!!!'
kor.rjust(15) # '파이썬을 배우면서 파이썬을 즐기자!!!'
kor = '파이썬을\t배우면서\t파이썬을\t즐기자!!!'
kor.expandtabs() # '파이썬을    배우면서    파이썬을    즐기자!!!'
kor.expandtabs(3) # '파이썬을  배우면서  파이썬을  즐기자!!!'
kor.expandtabs(10) #'파이썬을      배우면서      파이썬을      즐기자!!!'
