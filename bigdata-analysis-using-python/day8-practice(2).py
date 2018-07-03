# numpy 연산
a = np.array([20, 30, 40, 50])
b= np.arange(4)
print('b: ', b)
print('a-b: ', a-b)



b**2 #각 원소 제곱
10*np.sin(a)
a<35 #논리연산



#행렬 연산, 행렬은 대문자 벡터는 소문자
A = np.array([[1,2],
            [0,2]])
B = np.array([[3,5],
            [2,1]])
print(A+B)

A*B #elementwise product

np.dot(A, B) #matrix product, matmul보다 더 큰 개념
np.matmul(A, B) #A, B가 2d array여야 함

C = np.array([[1,2],
            [3,4]])
C.T #T 전치행렬, transpose

np.linalg.inv(A) #linear algebra, inverse matrix

np.random.seed(1)
a = np.round(np.random.random((2, 3)), 3)
a

a.sum()
a.max()
a.min()



b = np.arange(12).reshape(3, 4)
b
b.sum(axis = 0) #sum of each column, 행에 대한 것 axis = 0, 1행의 썸, 2행의 썸...
b.sum(axis = 1) #sum of each column, 열에 대한 것 axis = 1, 1열의 썸, 2열의 썸... 모르겠으면 직접 돌려보기
b.mean()
b.mean(axis = 0) #mean of each column
b.std(axis = 1) #std of each row, 크면 클수록 산포가 크다, 상대적인 개념이라고 생각하는 것이 좋다
b.var() #variance of b



#pandas
#자료 처리를 위해 numpy 라이브러리 대신 pandas 라이브러리를 사용할 수 있다
#numpy 라이브러리는 행렬의 형태 

import pandas as pd #아래 두 개 같은 거!
iris_data = pd.read_csv("Iris.csv")
#iris_test = pd.read_csv(r"C:\Users\yuniv\PycharmProjects\untitled\fira-pythonbasic\day8\Iris.csv")

import os
os.getcwd()
#os.chdir('untitled')

iris_data.shape #행과 열의 숫자
iris_data.head(6) #그냥 head면 디폴트 5개
iris_data.tail(3) #끝 부분 보기
iris_data = iris_data.drop("Id", axis = 1) #id 변수 제거, 열을 제거하므로 axis = 1
# 행렬에는 넘파이, 데이터프레임에는 판다스



#기초통계 및 탐색적 자료 분석
#결측치 수 확인
iris_data.isnull().sum() #true가 있다면 1씩 더해짐
iris_data.isnull().sum().sum() #결과는 0, 결측치가 없다
iris_data.isnull() #데이터 자체에 대해 결측 확인

# 결측치 제거 함수, 행을 뺄건지(axis=0), 열을 뺄건지(axis=1)
# 변수가 너무 많을 땐 행을 뺀다, 의학자료와 같이 rara한 자료 최대한 안 빼려고 하면 열을 삭제
iris_data.dropna(axis=0)

iris_data.columns #열 명 확인하기
iris_data.iloc[0, 2]
iris_data.loc[1:3, "variety"]
iris_data.iloc[[0, 50, 100], :] #인덱스와 동일

#iris_data.variety 
#iris_data.variety == 'Setosa' 결과는 t/f로
sum(iris_data.variety == 'Setosa')
iris_data.variety.value_counts() #각각 객체가 50개별로 구성되어 있음
(iris_data.variety == 'Setosa').tail()
a = iris_data.loc[iris_data.variety == 'Setosa', ["sepal.length", "petal.length"]]
print(a.shape) # (데이터 개수 50, 변수 개수 2)
a.head()

iris_data.index
iris_data.columns = ['a', 'b', 'c', 'd', 'e'] #인덱스도 (첫 열) 변경 가능하다
iris_data.head()
pd.__version__

iris_data.mean() # 범주형 자료는 평균 취하지 않는다, 범주형 자료는 테이블로 보는 게 좋다
iris_data.var()
iris_data.corr()
# 변수끼리의 상관 관계
# -1부터 1까지의 값, 강한 음의 상관관계 그리고 강한 양의 상관관계
(abs(iris_data.corr()) > 0.8).sum() #절대값 취하고 true 몇 개인지 
# 각 값에서 하나씩 빼고(자기자신), 나누기 2 해야 해
# 위처럼 summary하는 법 알아야

iris_data.describe()
# count 관측된 개수, 만약 결측치 있으면 알려줌 (149 이렇게)
# eda, 요약 통계량을 확인 함

#groupby 함수를 사용하여 그룹화를 한 뒤 그룹별 통계량을 볼 수 있다
iris_data.groupby(iris_data['variety']).describe()




#visualization : matplotlib.pyplot 라이브러리 필요

#boxplot : 데이터를 시각화하는 방법 중에 하나
import matplotlib.pyplot as plt
iris_data.boxplot()
plt.show()

import matplotlib.pyplot as plt
iris_data.hist(bins=30) # 잘 분포되어 있는지 치우치지 않는지 확인하기 위해
plt.show()

# 그룹별로 히스토그램 그려야, hist by group (나중에)
iris_data.boxplot(column  = 'petal.length')
iris_data.hist(bins=30, column = 'petal.length')
plt.show()

#그룹별로 boxplot 보기
iris_data.boxplot(column = 'petal.length', by = 'variety')
plt.show()

pd.plotting.scatter_matrix(iris_data, diagonal='hist', alpha=0.7, figsize=(8, 8))
plt.show()

#추가적인 라이브러리, hue 변주형 변수
import seaborn as sns
sns.pairplot(iris_data, hue='variety', size=3)
plt.show()

