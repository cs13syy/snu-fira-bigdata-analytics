from IPython.core.interactiveshell import InteractiveShell
InteractiveShell.ast_node_interactivity = "all"


# set : what to remember
1. unordered (no index, no slicing)
2. mutable
3. iterable
4. unique (repetition not allowed)
5. object is hashable, immutable data type
6. can't hold list, set, dict 


# create set
1. {} (have a item inside)
2. set()
3. set(iterable) *iterable: str, list, tuple, set, dict...


empty = set() # 빈 셋의 생성
empty

set1 = set('바나나')
set1
set2 = set({'바나나'})
set2

S = {'바나나'}
S


# set operating
membership -> in / not in
operator | -> union (합집합)
operator & -> intersection (교집합)
operator - -> difference (차집합)
operator ^ -> symmetric difference (대칭차)


# set methods
s.copy()
s.add(x)
s.pop
s.remove(x) # not x in set : error
s.discard(x) # not x in set : 
s.update(t)
s.clear()
s.isdisjoint(t)
s.issubset(t)
s.issuperset(t)


# set methods practice
s = {2, 3, 4, 5}
s.discard(1)
s # {2, 3, 4, 5}
s.remove(1) # error


# set comprehension
# what to remember : no repetition, {}

x = [i * i for i in (-3, -2, -1, 0, 1, 2, 3)] # list comprehension
y = {i * i for i in (-3, -2, -1, 0, 1, 2, 3)} # set comprehension
x # [9, 4, 1, 0, 1, 4, 9]
y # {0, 1, 4, 9}

x = [abs(i) for i in range(-9, 10)]
y = {abs(i) for i in range(-9, 10)}
x # [9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
y # {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}


# frozen set
1. immutable
2. can hold frozen set
3. in case of binary operator, follow "left"


# what is mapping?
1. unordered
2. key - value
3. key is hashable object(immutable), unique
4. value (all data type allowed)
5. iterable


# dictionary : what to remember
1. mutable
2. mapping : unordered, key - value (no index, no slicing)
    but you can use a kind of indexing with "keys"
3. key : only immutable data types
4. value : any data type
5. printed with {}


# create dictionary
# 1. {} (have a key-value inside)
# 2. {}
# 3. dict() # {}

empty1 = {}
empty1

empty2 = dict()
empty2

empty1 == empty2


d1 = dict(drum = '드럼', guitar = '기타') # keyword : drum, guitar automatically type set
d2 = dict({'drum': '드럼', 'guitar': '기타'}) # mapping
d3 = dict([['drum', '드럼'], ['guitar', '기타']]) # iterable : list of tuples
d4 = dict((['drum', '드럼'], ['guitar', '기타'])) # iterable : tuple of lists
d5 = dict([['drum', '드럼'], ['guitar', '기타']]) # iterable : list of lists
d3

complex_dic = {'악기': ['기타', '베이스'], '가족':{1: '엄마', 2: '아빠', 3: '나'}, (8, 15): '광복절', 'RGB': [255, 72, 90], 'id': (), 0: 55, -307:None, 'fruits': set()}
complex_dic

complex_dic['X'] = -258.42
complex_dic['가족'][4] = '동생'
complex_dic['악기'].append('베이스') # dic['악기'] is a list
complex_dic['fruits'].add('블루베리') # dic['fruits'] is a set
complex_dic

del complex_dic['id']
complex_dic


# dictionary methods
d.clear()
d.copy()
d.keys() # just view, cannot handle
d.values() # just view, cannot handle
d.items() # just view, cannot handle
d.fromkeys()
d.get(k) # no k in d, return None
d.get(k,v) # no k in d, return v # example : worldcup
d.pop(k) # no k in d, return error
d.pop(k,v) # no k in d, return v
d.popitem() # no in d, return error


# dictionary methods practice
complex_dic = {'악기': ['기타', '베이스'], '가족':{1: '엄마', 2: '아빠', 3: '나'}, (8, 15): '광복절', 'RGB': [255, 72, 90], 'id': (), 0: 55, -307:None, 'fruits': set()}
complex_dic
complex_dic[-307] = '영하'
complex_dic

complex_dic.keys()
complex_dic.values()
complex_dic.items()
tuple(complex_dic.keys())
list(complex_dic.items())


# dictionary methods practice
complex_dic = {'악기': ['기타', '베이스'], '가족':{1: '엄마', 2: '아빠', 3: '나'}, (8, 15): '광복절', 'RGB': [255, 72, 90], 'id': (), 0: 55, 1: 55, 2: 55, 'x': -258.42, -307: None, 'fruits': set()}
complex_dic['RGB']
complex_dic.get('RGB')
complex_dic['y'] # error
complex_dic.get('y') # nothing
complex_dic.get('y', 0) # 0
complex_dic
complex_dic.setdefault('y', 0) # if no y, put {'y': 0} -> like default dictionary
complex_dic


# dictionary comprehension
x = {i: pow(i, 2) for i in range(-9, 10)}
x

koreng = dict(사과='apple', 블루베리='blueberry', 딸기='strawberry', 
              키위='kiwi', 바나나='banana', 포도='grape', 자두='plum')
engkor = {v: k for k, v in koreng.items()}
engkor


# default dictionary practice 1
from collections import defaultdict
dd1 = defaultdict(str)
dd2 = defaultdict(int)
x = dd1['name'] # nothing
x # ''
dd1 # defaultdict(str, {'name': ''})
len(dd1)
y = dd2['name']
y # 0
dd2 # defaultdict(int, {'name': 0})
len(dd2)


# default dictionary practice 2
from collections import defaultdict
dd_int = defaultdict(lambda: -1)
dd_point = defaultdict(lambda: (0,0))
dd_msg = defaultdict(lambda: '남겨진 메시지가 없습니다')

x = dd_int['잔액']
x
dd_int

y = dd_point['좌표']
y
dd_point

z = dd_msg['메시지']
z
dd_msg
len(dd_msg)


# default dictionary practice advanced 1
item_list = [('과일', '블루베리'), ('악기', '드럼'), ('악기', '베이스'), ('과일', '사과'), ('악기', '기타')]
d = {}
for k, v in item_list:
    d.setdefault(k, []).append(v)
list(d.items())


# default dictionary practice advanced 2
from collections import defaultdict
item_list = [('과일', '블루베리'), ('악기', '드럼'), ('악기', '베이스'), ('과일', '사과'), ('악기', '기타')]
dd = defaultdict(list)
for k, v in item_list:
    dd[k].append(v)
list(dd.items())


# default dictionary practice advanced 3
from collections import defaultdict
item_list = [('과일', '블루베리'), ('악기', '드럼'), ('악기', '베이스'), ('과일', '사과'), ('악기', '기타')]
dd = defaultdict(set)
for k, v in item_list:
    dd[k].add(v)
list(dd.items())


# default dictionary practice advanced 4
from collections import defaultdict
item_list = [('과일', '블루베리'), ('악기', '드럼'), ('악기', '베이스'), ('과일', '사과'), ('악기', '기타')]
dd = defaultdict(int)
for e1, e2 in item_list:
    dd[e1] += 1 # ??
list(dd.items())


# ordered dictionary
stock = dict(키보드=2, 드럼=3, 기타=11, 베이스=5, 색소폰=1)
from collections import OrderedDict

OrderedDict(sorted(stock.items()))
OrderedDict(sorted(stock.items(), key=lambda e: len(e[0])))
OrderedDict(sorted(stock.items(), key=lambda e: e[0]))


# location practice 1
list1 = ['블루베리', '사과', '바나나']
list2 = [1, 2, 3]
list3 = list1

list1 # ['블루베리', '사과', '바나나']
list2 # [1, 2, 3]
list3 # ['블루베리', '사과', '바나나']

list3.append('포도')
list3 # ['블루베리', '사과', '바나나', '포도]
list1 # ['블루베리', '사과', '바나나', '포도]
list2 # [1, 2, 3]

list1 = list2 
list1 # [1, 2, 3]
list2 #  [1, 2, 3]
list3 # ['블루베리', '사과', '바나나', '포도]

list2[-1] = 7 
list2 # [1, 2, 7] 
list1 # [1, 2, 7]
list3 # ['블루베리', '사과', '바나나', '포도]


# shallow copy 1
x = [1, 2, 3]
y = x
y is x

y[-1] = '드럼'
print(x, y)

z = x[:]
z is x

z[0] = '기타'
print(x, y, z)


# shallow copy 2
x = [1, 2, 3]
y = x
y is x

y[-1] = '드럼'
print(x, y)

z = x.copy()
z is x

z[0] = '기타'
print(x, y, z)


# shallow copy (simple)
x = [1, 2, 3]
y = x
z = x.copy()

x[-1] = '드럼'
print(x, y, z) # [1, 2, '드럼'] [1, 2, '드럼'] [1, 2, 3] 


# shallow copy (complex)
x = [1, 2, ['드럼', '기타', '베이스']]
y = x.copy()

y is x, y == x # F, T

x[0] = 'Python'
y[-1][-1] = '키보드'

x # [python, 2, ['드럼', '기타', '키보드']]
y # [1, 2, ['드럼', '기타', '키보드']]


#deep copy
import copy
x = [1, 2, ['드럼', '기타', '베이스']]
y = copy.deepcopy(x)

y is x, y == x

x[0] = 'Python'
y[-1][-1] = '키보드'

x # ['Python', 2, ['드럼', '기타', '베이스']]
y # [1, 2, ['드럼', '기타', '키보드']]


# reversed() function
L = list(range(6))
L
reversed(L)
list(reversed(L))


# sorted() function
x = []
for i in zip(range(-9, 0, 2), range(0, 10, 2)):
    x += i
x
sorted(x)
sorted(x, reverse=True)
sorted(x, key=abs)

# num : small -> big
# eng : upper -> lower

L1 = ['a', 'd', 'e', 'b', 'f', 'b']
L1.sort()
L1


# list : Lab 3-2-1
e = [1, 7, [4, 9], 'f', ('a', 'b')]
e.append('g')
print(e)
print(e[4:6])


# tuple : Lab 3-2-2
atuple = (1, 5, (2, 3), 'green', ['드럼', '기타'])
btuple = atuple[-2:]
(2, 3) in atuple
5 in btuple


# set : confusing example
s5 = {2, 7, 3}
s5.update([2, 4, 5]) # cannot hold list, elementwisely
s5 # {2, 3, 4, 5, 7}


# set : Lab 3-2-3
s1 = {2, 4, 5, 7}
s2 = {1, 2, 7, 9}
s1 | s2
s1 & s2


# dictionary : confusing example
d = {None: None}
type(d) # dict
len(d) # 1


# dictionary : Lab 3-2-4
d = {'even':(2, 4, 6, 8, 10), 'odd':(1, 3, 5, 7, 9), 'prime':(2, 3, 5, 7)}
d
d['all'] = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
d
del d['odd']
d


# comparison operators
# chaining ok
# list, tuple ok - chr follows unicode order
