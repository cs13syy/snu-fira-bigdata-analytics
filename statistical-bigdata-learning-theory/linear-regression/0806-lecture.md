# 선형 회귀 (Linear Regression)

**lecture key point**
- 다중회귀분석에서 상관계수의 의미
- 회귀분석에서 중요한 변수, 모형 선택에 대해
***

#### classification
- y가 class label이면 classification이라고 한다 (CH4~)
- class label: factor와 같이 전체를 카테고리, 범주로 나눈 것
- p(y=k) = f(x1, x2, x3)

#### non-linear
- f: 비모수, 부드러운 함수
- p: 변수의 수, p가 많아지면 어려움

#### linear
- 비모수 함수 추정은 자기한테 딱 맞는 옷을 찾아가는 과정이라면, 선형 회귀는 누구한테나 대략 fit이 되는 청바지와 같은 개념
- 즉, 보편적인 근사 개념
- y = b0 + b1*x1 + b2*x2 + b3*x3 + e

***

- 통계학습은 결국 예측(prediction) 또는 관계(estimation/inference) 둘 중 하나로 귀결
- 딥러닝 : prediction - 영상/디지털 데이터, stable한 결과를 얻으려면 엄청난 양의 데이터 필요
- 예측 : y=f(x)로 y값 예측
- 추론 : y와 x의 관계 규명

***

## 단순회귀모형 (Simple Linear Regression)
- 광고 데이터(advertising) : 매체 별로 sales 추이
- E[y] = f(x1, x2, x3)
- y=sales, x1=tv, x2=radio, x3=news
- f가 무엇인지 알아내는 것이 목적
- 변수 사전 스크리닝할 때, 의미없는 변수 x 몇 개 없앨 때 주로 사용된다 (혹은 sample correlation)

#### 회귀계수의 추정
- 최소제곱법 : 잔차제곱합(실제값과 모형의 차)을 최소화하는 b0, b1
(1)
- xbar, ybar를 항상 지나게 된다
- xbar, ybar에서의 var(y)는 정확, 그러나 거기서 멀어지면 멀어질수록 accuracy 떨어진다
- 데이터 x 밖의 범위에 대해서는 prediction해서는 안 된다
(2)
- E(Y|X=x0) hat은 x가 주어졌을 때 y의 평균 (조건부)
- 왜 di가 아니라 세로로 길이를 잴까?
- di로 재는 것 -> 주성분분석(PCA)
(3)
- regression to mean (추후에 다시 설명)

***

#### 불편성, 표준오차, 시그마의 추정
- 설명변수 x 어떻게 뽑아야 하나?
- 대부분 회귀분석이지만, 풀어야 되는 문제는 다양
- 평균 고정이니까 분산 최소화 -> 분산이 분모에 들어가니까 max가 되어야겠지
- min(x1, x2, ... xn) -> max(sum(xi-xbar)^2)
- 0과 1 사이 값이라면, 0과 1일때 최대가 된다
- 사례 : 구글 클라우드 네트워크 a/b 테스트

***

- 회귀모형 : lm()
- 신뢰구간: confint()
- 결정계수: 회귀식이 전체식을 얼마나 설명하느냐  (R^2 = r^2)
- b1hat도 x,y 표준화 * r로 표현할 수 있다

***

## 중회귀모형 (Multiple Linear Regression)
- 모형 : 각각의 설명력은 떨어질 수 있어도 변수들의 조합이 중요
- Y = b0 + b1*x1 + ... + bp*xp + e
- (Y-XB)t(Y-XB)
- 위 행렬을 미분 -> Xt*X*B=Xt*Y
- 행렬의 모든 공식을 보려면 matrix cookbook 검색
- ★중회귀 분석에서 coefficient는 더이상 sample correlation이 아니다★
- corr(y, (x0, x1, ..., xn)) # multiple correlation, 그 중 max 출력
- corr((y0, y1, ..., ym), (x0, x1, ..., xn)) # cannonical correlation, 그 중 max 출력
- b0 hat = partial corrleation (y1, y3|x1, x2)
- x1, x2, x3 서로 독립 아니라서 영향 주고 받아
- 특정 변수의 영향을 통제해주는 것
- 그냥 x,y 단순회귀분석이라고 보면 되는가? 아니다, 다른 변수의 영향을 못 발라내기 때문
- simpson's paradox, association & causation 회귀분석에서 조심해야
- data sneeping 5% 함정 어쩌다 보니 유의하게 나왔을 수도

***

## 가변수 (Dummy Variable)
- xi = 1 또는 0 -> i번째 사람이 여성이면 1,  i번째 사람이 남성이면 0
- 가변수 개수는 데이터 개수 -1
