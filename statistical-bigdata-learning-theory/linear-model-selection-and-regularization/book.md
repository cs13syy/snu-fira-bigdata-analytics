# 선형모델 선택 및 regularization (Linear Model Selection and Regularization)
- 선형모델은 약간의 확장만으로 non-linear 모델과 비교하여 놀라울 정도로 경쟁력을 갖고 있다
- 일반 최소제곱적합을 다른 적합절차로 대체하여 단순선형모델을 개선할 수 있는 몇 가지 방법을 논의한다
- 그렇다면 왜 OLS 말고 다른 적합절차를 사용하는가? 예측 정확도와 해석력 때문
- 예측 정확도 : p(변수의 개수)가 n(자료 개수)보다 많아지는 상황에서는 variance가 폭등
- 해석력 : OLS는 실제 Y 함수의 이해에 상관이 없는 변수를 없애주지 못한다 -> 계수를 0을 만들기 어렵다
- 이 장에서는 크게 세 가지 방법에 대해 배운다
- 1) Subset Selection : 유의미한 설명변수만을 부분집합으로 추려서 OLS를 시행하는 방법
- 2) Shrinkage Methods : 모든 변수로 적합을 하되 계수들을 0으로 regularize하는 방법
= 3) Dimention Reduction : 큰 차원의 p개의 예측 변수를 m차원으로 투영(projection)시키는 방법
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
- (1) 설명변수를 하나도 포함하지 않은 영모델에서
- (2) 설명변수를 하나씩 추가해간다 (이 때 추가하는 변수는 추가했을 때 가장 낮은 RSS나 가장 높은 R^2를 가질 경우)
- (3) 더 이상 중요한 변수가 없으면(t-통계량이 유의한 게 없으면) 선택을 멈춘다
- best subset selection에 비해 computation이 훨씬 간단하다는 장점이 있다
- 하지만 반드시 best model이 선택되는 것은 아니다 (X1, X3보다 X3, X6이 더 설명력이 높을 수 있다)
- p가 n보다 많아지는 경우 각 모델의 유일한 OLS 계수를 찾기 어렵다
#### 후진 선택법 (Backward Selection)
- (1) 모든 변수가 있는 모델에서 
- (2) 제일 큰 p-value를 가진 변수를 지운다
- (3) 남은 변수로 또 p-value를 계산해서 뺀다
- (4) 더 이상 뺄 변수가 없으면 멈춘다
- 전진 선택법과 마찬가지로 best model이 선택되는 것은 아니다 
- p가 n보다 많아지는 경우 모든 변수가 들어간 모델 자체를 적합할 수가 없다
***
## Choosing the Optimal Model
- 좋은 모델의 판단 기준으로 test error를 추정하는 방법
- 1) training error rate에 overfitting을 고려한 수학적인 보정을 가하여 test error를 간접 추정
- 2) training set 중 몇 개를 따로 빼내서 test error를 직접 추정 (resampling methods)
### Cp, AIC, BIC, and Adjusted R2
- training error rate에 overfitting을 고려한 수학적인 보정을 가하여 test error를 간접 추정
- 변수의 개수가 다른 모델들 간의 비교도 가능하다
- Mallow's Cp : 잔차제곱합 / 분산추정량 + (2p − n)
- AIC : 최대 가능도에 의해 적합된 모델에 의한 기준, Cp의 상수배, error ϵ에 정규 가정하면 OLS와 같은 값
- BIC : 베이지안 관점에서 계산된 지표, AIC에서 2가 logn으로 바뀐 것, 더 많은 변수에 더 많은 패널티를 주어 다른 기준들에 비해 단순한 모델을 줌
- Adjusted R2 : SSE와 SST를 각각의 자유도로 나눈 것
- Adjusted R2를 제외하고는 값이 작을수록 좋은 모델
### Validation and Cross-Validation
- 위 방법보다 이점이 많다 -> 가정을 거의 하지 않고, 또 자유도를 구하기 힘들거나 σ^2를 구하기 힘든 여러 경우에도 사용될 수 있음
- 어떠한 회귀 문제에서 다양한 기준을 놓고 판단하려고 할 때, one-standard-error-rule을 적용한다
- one-standard-error-rule : 추정된 test MSE가 크게 다르지 않은 수준 내에서, 가장 단순한 모델을 고르고자 함
***
## Shrinkage Methods
- 모든 변수로 적합을 하되, 계수들을 0으로 regularize하는 방법
- 추정된 계수들의 변동(variance)을 대폭 줄여준다는 이점이 있다
### 능형 회귀 (Ridge Regression)
- OLS에 λ(≥0)라는 tuning parameter를 붙여 가중치를 둔다
- 기존의 RSS에서 (모든 계수의 제곱합) X (지정된 상수 λ)를 최소화 하는 식이 더 붙는다
- 따라서 계수들이 작아지도록 유도하게 된다
- RSS를 최소화함으로써 잘 적합하는 동시에, shrinkage penalty라고 불리는 λ식을 통하여 계수들(β1,..,βp)이 0으로 가게 하려는(variance를 줄이려는) shrink의 효과도 부여한다 (β0 은 shrink의 대상에 포함되지 않는다)
- λ는 분석자에 의해 결정되며, λ가 0이면 shrinkage의 비중을 0, λ가 커질수록 shrinkage 효과에 비중을 둔다
- λ식을 보면, ridge에서 추정되는 계수는 λ에만 영향을 받는 것이 아니라, 각 변수들의 scaling에도 영향을 받는다
- 따라서 보통 ridge regression전에 모든 변수들을 표준화(각 변수의 표준편차로 나누는 것)를 해주고 진행을 한다
- Ridge를 쓰는 이유? bias-variance trade-off 때문
- OLS는 unbiased하나 높은 variance를 가진 계수를 추정하게 됨 -> 데이터가 조금만 바뀌어도 계수들 크게 변동 -> 설명변수 사이즈 크면 해도 없다
- Ridge는 약간의 bias에서의 손해를 보더라도 variance를 크게 줄여 OLS보다 좋은 결과를 가져옴
- 계산 시 λ만 바꾸면 되기 때문에, computation도 어렵지 않은 이점이 있다  
### 라쏘 (The Lasso)
- 해석의 측면에서 Ridge의 단점 : 설정 상 모든 변수로 적합해야 하고 다른 변수의 계수도 완벽히 0은 아닐 것
- 식을 보면, Ridge 식에서 β2j가 |βj|로 바뀌었을 뿐
- 계수들이 0의 방향으로 shrink하게 했던 ridge와 달리, Lasso는 적당한 λ만으로 몇몇 계수를 정확하게 0으로 가게 만들 수 있다
- 따라서 몇몇 중요하지 않은 변수가 사라진 효과가 있으므로, 해석력에서 ridge보다 강력한 강점을 가지고 있다
- 전체의 변수를 포함하지 않고 몇몇 변수만을 포함한다는 의미에서, Lasso를 sparse한 model이라고도 한다
- Lasso와 Ridge의 성능의 우위는 데이터의 상황에 따라 다르다
- 유의미한 변수가 적을때는 Lasso가, 반대의 경우 Ridge가 더 좋은 성능을 보인다
- 이를 미리 완벽하게 알 수는 없으므로, cross-validation의 방법이 사용된다
### Selecting the Tuning Parameter
- λ, 값을 어떻게 설정할 것인가?
- 몇몇의 λ 값들을 선정하여 그 값들에 대해 cross-validation을 하고 가장 작은 cross-validation error를 보인 λ를 선정한다
- 최종적으로 다시 모든 데이터에 대해 해당 λ로 적합을 한다
***
