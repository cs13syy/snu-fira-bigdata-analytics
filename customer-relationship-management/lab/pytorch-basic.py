import torch
import torchvision
import torch.nn as nn
import numpy as np
import torchvision.transforms as transforms



x = torch.tensor(1.0, requires_grad=True)
w = torch.tensor(2.0, requires_grad=True)
b = torch.tensor(3.0, requires_grad=True)

# Build a computational graph.
y = w * x + b    # y = 2 * x + 3

# Compute gradients.
y.backward()

# Print out the gradients.
print(x.grad)    # x.grad = 2
print(w.grad)    # w.grad = 1
print(b.grad)    # b.grad = 1




# Create tensors of shape (10, 3) and (10, 2).
x = torch.randn(10, 3) # 10행 3열 짜리 매트릭스를 텐서로 만들어라
y = torch.randn(10, 2)

# Build a fully connected layer.
linear = nn.Linear(3, 2) # torch 안 클래스 nn을 가져오겠다, 선형 모형을 하겠다, y=2x+3
print ('w: ', linear.weight)
print ('b: ', linear.bias)

# Build loss function and optimizer.
criterion = nn.MSELoss() # 회귀니까 loss로 MSE 설정
optimizer = torch.optim.SGD(linear.parameters(), lr=0.01)
# SGD = stockist gradient descent 데이터를 확률적으로 랜덤하게 뽑아서 쓰겠다
# 파라미터 = 업데이트할 주체, lr은 w를 업데이트 하는 가중치 learning rate

# Forward pass. 여기서부터 for문 써서 반복문 사용하면 됨.
pred = linear(x)
# x를 집어넣어서 예측값을 알아보겠다

# Compute loss.
loss = criterion(pred, y) # 1개의 스칼라 값
print('loss: ', loss.item())

# Backward pass.
loss.backward()
# loss로부터 새로운 파라미터 업데이트, 그 대상은 w와 b
# 미분값 계산, w에 대한 미분값

# Print out the gradients.
print ('dL/dw: ', linear.weight.grad)
print ('dL/db: ', linear.bias.grad)

# 1-step gradient descent.
optimizer.step()

# You can also perform gradient descent at the low level.
# linear.weight.data.sub_(0.01 * linear.weight.grad.data)
# linear.bias.data.sub_(0.01 * linear.bias.grad.data)

# Print out the loss after 1-step gradient descent.
pred = linear(x)
loss = criterion(pred, y)
print('loss after 1 step optimization: ', loss.item())



####################### Loading data from numpy

x_np = np.array([[1,2], [3,4]])
x_t = torch.from_numpy(x_np)
