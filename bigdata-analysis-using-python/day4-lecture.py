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













# data type : string practice (5) - slicing
# data type : string practice (5) - slicing
