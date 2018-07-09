# lab 5-1-1 (다시보기)
L = list(range(1, 101))
for i in range(len(L)):
    L[i] += 1
print(L)



# lab 5-1-2
a = (1, 3, 5, 7, 9)
a = list(a)
for i in range(len(a)): # 이 방법 암기하자
    a[i] = str(a[i])
a.append('x')
a.append('y')
a.append('z')
# a += list('xyz')
# for e in tuple('xyz):
#     a.append(e)
for i in a :
    print(i, type(i))



# for문과 append의 조합 -> list 축약문
a = (1, 3, 5, 7, 9)
a = list(a)
a = [str(e) for e in a]
a.extend(['x', 'y', 'z'])
for e in a:
    print(e, type(e))
    
    
    
# lab 5-1-3
def xor(a, b):
    if a == b:
        return False
    else:
        return True
xor(True, True)
xor(True, False)
xor(False, True)
xor(False, False)
# return 이면 print 함수 써야하고, print 함수를 쓰면 따로 출력하려고 하지 않아도 된다



def bitwise_xor(x, y):
    return x ^ y
xor(True, True)
xor(True, False)
xor(False, True)
xor(False, False)



# lab 5-1-4
def expand_rectangle(a, b):
    d = a * b
    a_new = a+5
    b_new = 2*b
    d_new = a_new * b_new
    r = round(d/d_new, 2)
    print('Width = {}\nLength = {}\nArea Ratio = {}'.format(a_new, b_new, r))
expand_rectangle(7, 10)



# lab 5-1-5
def calculator(operator, integer1, integer2):
    if operator == 'add':
        return integer1 + integer2
    elif operator == 'sub':
        return integer1 - integer2
    elif operator == 'mul':
        return integer1 * integer2
    elif operator == 'div':
        return integer1 / integer2
    else:
        print('{} is not supported.'.format(operator))
        return None # PEP 9 Recommendation
calculator('addition', 3, 5)
calculator('add', 3, 5)
calculator('sub', 7, 8)
calculator('mul', 11, 2)
calculator('div', 7, 3)
calculator('add', '3', '5')
calculator('add', [1, 2], [3, 4])



# lab 5-1-6 : 특정 원소가 있는지 없는지 확인하기
def vowel(word):
    word = word.lower()
    a = []
    v = ['a', 'e', 'i', 'o', 'u']
    for i in word:
        if i in v:
            a.append(i)
    print(len(a))
vowel('Apples')
vowel('I love Python')



def vowel(word):
    v = ['a', 'e', 'i', 'o', 'u']
    count = 0
    for i in word:
        if i.lower() in v:
            count += 1
    print(count)
vowel('Apples')
vowel('I love Python')



# lab 5-2-1
def calculator_int(*args):
    if 0 not in args:
        sum = 0
        for i in args:
            sum += i
            avr = round(sum/len(args)) # 정수로 출력하려면 round에 숫자 안써도 됨
    else:
        zero_idx = args.index(0)
        args = args[0:zero_idx]
        sum = 0
        for j in args:
            sum += j
            avr = round(sum/len(args))
    result = (sum, avr)
    return result

calculator_int(1, 2, 3, 4, 5)
calculator_int(1, 3, 5, 7, 9, 10)
calculator_int(-3, 2, 0, 4, 5)



def calculator_int(*numbers):
    sum = 0
    count = 0
    
    for i in numbers:
        if i != 0:
            sum += i
            count += 1
        else:
            break
    return (sum, int(round(sum/count, 0)))

calculator_int(1, 2, 3, 4, 5)
calculator_int(1, 3, 5, 7, 9, 10)
calculator_int(-3, 2, 0, 4, 5)



# 인덱스 함수 꼭 기억하기
a = (-3, 2, 0, 4, 5)
a.index(0)



# lab 5-2-2
def search(args, a):
    if a in args:
        return args.index(a)
    return False # else 생략 가능
    
mylist = [1, 2, 3]
mytuple = ('a', 'b', 'c')
print(search(mylist, 2))
print(search(mylist, 10))
print(search(mytuple, 'c'))
print(search(mytuple, 'l'))



# lab 5-2-3
def search_char(args, s):
    if s in args:
        return args.index(s)
    return -1
print(search_char('python', 'o'))
print(search_char('I love python', 'o'))
print(search_char('python', 'P'))
print(search_char('바나나', '나'))
print(search_char('안녕 파이썬', 'p'))



# 다시보기
# lab 5-2-4
# 초기값 설정 시 for문 위에서 설정하기  
def reverse_odd_text(*args): # * : 여러개가 들어간다
    odd = 0
    for i in args:
        if len(i) % 2 == 1:
            odd += 1
            print(i[::-1])
        else:
            print(i)
    return odd
odd_count = reverse_odd_text('red', 'blue', 'green', 'yellow', 'purple', 'black', 'white')
odd_count



# lab 5-2-5
def sort_scores(*args):
    scores = sorted(args, reverse=True)
    return scores
print(sort_scores(100, 27, 54, 88, 46, 97, 75, 53))



# 다시보기
def sort_scores(*args): # *는 튜플
    # tuple은 sort() 메소드가 없기 때문에 리스트로 형변환
    score_list = list(scores)
    score_list.sort(reverse=True)
    for s in 
sort_scores(100, 27, 54, 88, 46, 97, 75, 53)



# lab 5-2-6
def sort_by_word_length(*args):
    a = sorted(args)
    return a
    
colors = ['green', 'brown', 'gray', 'blue', 'red']
sort_by_word_length(colors)



# 다시보기
# lab 5-2-6
# 딕셔너리를 사용, 길이와 단어를 기록, 후에 sort 사용
def sort_by_word_length(*words):
    t = []
    for w in words:
        t.append((len(w), w))
        
    # sort() 메소드는 먼저 길이 비교해서 만약 길이가 같다면 단어를 비교해서 정렬
    t.sort(reverse=True)
    sorted_words = []
    for length, w in t:
        sorted_words.append(w)
    return sorted_words

colors = ['green', 'brown', 'gray', 'blue', 'red']
sort_by_word_length(colors)



# 다시보기
def sort_by_word_length(*words): 
    t = [(len(w), w) for w in words]
    t.sort(reverse=True)
    return [w for length, w in t]

colors = ['green', 'brown', 'gray', 'blue', 'red']
sort_by_word_length(colors)
