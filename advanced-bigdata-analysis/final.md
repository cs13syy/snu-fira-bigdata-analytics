1. Deep learning의 응용분야를 5개 이상 적으시오. (입력데이터, 출력 결과물, 응용분야로
정리하시오).
이미지 분석 : 30 x 30 크기의 이미지, CNN
언어 분석 : 번역

2. 다음의 신경망 모형에서 입력변수 x와 출력변수 y사이의 함수관계를 수식으로 쓰시오.
(단, 입력변수는 5차원, 3개 중간층의 노드의 개수는 각각 6개, 출력 노드의 개수는 4개로
4개의 class를 분류하는 문제이다.)
해결

3. Cross-entropy에 대해서 설명하시오.
뉴럴 네트워크 학습에서 목적함수로 MSE cost function을 사용하는 경우, activation function으로 시그모이드 함수를 사용하면 z값이 너무 크거나 작아지면 미분값이 급격히 0에 가까워지는 현상이 발생한다. 이는 학습속도가 저하되는 문제를 유발한다. 이 문제 때문에 MSE cost function 대신 cross-entropy cost function을 사용한다. 오차가 더 큰 input 값에 대해서는 더 많이 업데이트 하고, 오차가 더 작은 인풋값에 대해서는 더 적게 업데이트하는 결과를 얻을 수 있다.
 
4. Gradient descent algorithm에 대해서 설명하시오.
특정 목적함수 L(세타)를 최소화하는 세타를 찾기 힘든 경우에 사용하는 대표적인 반복 알고리즘. 

5. 역전파알고리즘(Backpropagation)에 대해서 설명하시오.

6. Stochastic gradient descent 방법에 대해서 설명하시오.

7. 2006년 전까지 딥러닝이 많이 사용되지 않은 이유들을 설명하시오.
레이어를 깊게 쌓을수록 Backpropagation 과정에서 Gradient가 사라지는 Vanishing Gradient Problem 때문에 한계에 직면하게 되고, MLP보다 강력한 성능을 보여주는 SVM과 같은 Kernel Method가 등장함으로써, 인공신경망 연구는 다시 인공지능 학계의 주류에서 밀려나게 된다.

8. 2006년도 Hinton교수의 논문에 대해서 설명하시오.
힌톤 교수는 "A fast learning algorithm for deep belief nets"라는 2006년의 논문을 통해, 최적화 알고리즘의 함정(local minima)들을 데이터의 전처리 과정(pre-training을 통해 해결할 수 있음을 밝혔습니다. 힌톤 교수는 이 논문을 통해 인공신경망의 각 층들을 먼저 비지도학습 방법(unsupervised learning)을 통해 전처리하고, weight의 초기값을 제대로 설정하면 깊은 신경망학습이 가능하다는 것을 밝혔다.

9. 3가지 이상의 activation함수를 적으시오.
Relu, Sigmoid, Tanh

10. Sigmoid activation함수의 문제점을 적고 ReLU activation함수와 비교 하시오
sigmoid는 일단 지수함수를 계산해야 하기 때문에 계산이 느리고, 결정적으로 Vanishing Gradient 라고 하는 근본적인 문제를 가지고 있었다. 
Vanishing Gradient 라는 문제는 미분값이 작기 때문에 (0~1) 0.xxx 를 계속 곱하다 보면 0에 수렴하게 된다는 것인데, 오류역전파를 사용할수록 앞 레이어의 가중치들이 급격하게 무의미하게 변해버려(사라져서) 출력에 미치는 영향이 감소한다는 것이다. sigmoid는 값을 변화시키지만 ReLU 함수는 임계값을 넘는 순간 입력을 그대로 넘겨준다. 즉, ReLU를 통해 0 아니면 양수가 출력됨으로써 기울기가 사라지지 않게 되는 것이다.

11. Drop-out 알고리즘을 설명하시오.
12. Batch normalization알고리즘을 설명하시오.
13. Adam알고리즘에 대해서 설명하시오.
14. Deep directed network, deep Boltsman machine 그리고 Deep belief network 모형
을 설명하고 이중 Deep belief network이 많이 쓰이는 이유를 설명하시오.
15. 다음의 deep belief network에서 x의 주변확률밀도함수를 구하시오.
(단, 입력 노드는 4개, 3개 중간층의 노드의 갯수는 각각 3, 4, 3개이고, visible 노드와
hidden 노드는 binary 값을 갖는다고 가정.)
16. (Open problem) 연속형 변수를 위한 deep belief network를 설명하시오.
17. Deep belief network의 응용분야를 설명하시오.
18. Auto-encoder의 모형을 쓰고 학습하는 방법을 설명하시오.
19. Stacked auto-encoder를 설명하고 학습하는 방법을 설명하시오.
20. Transfer learning에 대해서 설명하고 (stacked) auto-encoder가 어떻게 이용되는지
설명하시오.
21. CNN에 대해서 설명하시오.
22. Convolutional layer를 설명하고 입력과 출력사이의 관계를 수식과 그림을 표현하시오.
23. (Open problem) ResNet에 대해서 설명하시오.
24. 언어이해에서 일반적인 시계열모형의 사용에 대한 문제점을 설명하시오.
25. RNN에 대해서 설명하시오.
26. LSTM에 대해서 설명하고 수식으로 표현하시오.
27. GRU에 대해서 설명하고 수식으로 표현하시오.
28. (open problem) Machine translation에 사용되는 딥러닝 architecture를 설명하고 수
식으로 표현하시오.
29. 이미지 캡션 자동 생성을 위한 딥러닝 architecture를 설명하시오.
30. (open problem) Word2Vec에 대해서 설명하시오.
31. 딥러닝을 이용한 추천알고리즘들에 대해서 설명하시오.
