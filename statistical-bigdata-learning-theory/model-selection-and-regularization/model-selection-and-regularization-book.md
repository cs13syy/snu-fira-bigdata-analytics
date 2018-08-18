# 선형모델 선택 및 regularization (Linear Model Selection and Regularization)
- 선형모델은 약간의 확장만으로 non-linear 모델과 비교하여 놀라울 정도로 경쟁력을 갖고 있다
- 일반 최소제곱적합을 다른 적합절차로 대체하여 단순선형모델을 개선할 수 있는 몇 가지 방법을 논의한다
- 그렇다면 왜 OLS 말고 다른 적합절차를 사용하는가? 예측 정확도와 해석력 때문
- 예측 정확도 : p(변수의 개수)가 n(자료 개수)보다 많아지는 상황에서는 variance가 폭등
- 해석력 : OLS는 실제 Y 함수의 이해에 상관이 없는 변수를 없애주지 못한다 -> 계수를 0을 만들기 어렵다
- 이 장에서는 크게 세 가지 방법에 대해 배운다
- 1. Subset Selection : 유의미한 설명변수만을 부분집합으로 추려서 OLS를 시행하는 방법
- 2. Shrinkage Methods : 모든 변수로 적합을 하되 계수들을 0으로 regularize하는 방법
= 3. Dimention Reduction : 큰 차원의 p개의 예측 변수를 m차원으로 투영(projection)시키는 방법
- 보통 regression에 중점을 두고 있지만 classification에서도 사용할 수 있다
***
## 부분집합 선택 (Subset Selection)
### Best Subset Selection
- 가능한 모든 경우의 수에 적합을 해보고 이 중 best 부분집합을 찾는 방법
- (1) 모든 사이즈에 대해 최적의 적합을 찾아낸다 (총 변수 8개, 사이즈 1에 대해 적합 8번)
- (2) 그 중 가장 좋은 모델을 뽑는다 (사이즈는 동일하니 R^2로 비교한다)
- (3) 그렇게 뽑힌 모델 중에서도 최고의 모델을 뽑는다 (사이즈가 다르니 기준은 CV-error, Cp, AIC, BIC, Radj)
- R^2는 설명변수의 개수가 많아지면 자동적으로 값이 증가하는 경향이 있으므로 3번의 기준이 될 수 없다
- 고려해야 하는 적합의 수가 2^p개므로, computation이 힘든 단점이 있어 p가 큰 경우에 사용이 어렵다
- 그리고 p가 많이 크면, 과적합(overfitting)된 모델을 고르게 될 가능성이 높다
### Stepwise Selection
#### 전진 선택법 (Forward Selection)
-
-
#### 후진 선택법 (Backward Selection)
-
-
***
## Shrinkage Methods

### 능형 회귀 (Ridge Regression)
### 라쏘 (The Lasso)
