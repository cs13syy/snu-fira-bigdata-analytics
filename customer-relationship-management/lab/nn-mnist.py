import torch
import torch.nn as nn
import torchvision
import torchvision.transforms as transforms

# Device configuration
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

# Hyper-parameters
input_size = 784 # 28*28 pixel
hidden_size = 500 # 한 레이어에서 500개 노드
num_classes = 10 # y라벨의 개수, output 10개, 0부터 9까지
num_epochs = 5 # 몇 번 업데이트 할 것인지
batch_size = 100 # SGD 한 번 샘플할 때 100개씩 하겠다
learning_rate = 0.001

# MNIST dataset
train_dataset = torchvision.datasets.MNIST(root='../../data',
                                           train=True,
                                           transform=transforms.ToTensor(),
                                           download=True)

test_dataset = torchvision.datasets.MNIST(root='../../data',
                                          train=False,
                                          transform=transforms.ToTensor())

# Data loader, train 데이터셋을 learning이 될 때마다 shuffle 해 줌
train_loader = torch.utils.data.DataLoader(dataset=train_dataset,
                                           batch_size=batch_size,
                                           shuffle=True)

test_loader = torch.utils.data.DataLoader(dataset=test_dataset,
                                          batch_size=batch_size,
                                          shuffle=False)


# Fully connected neural network with one hidden layer
# 클래스로 지정하는 이유? 클래스로 지정만 하면 NeuralNet.forward 말고 forward라고만 써도 돼
class NeuralNet(nn.Module):
    def __init__(self, input_size, hidden_size, num_classes):
        super(NeuralNet, self).__init__()
        self.fc1 = nn.Linear(input_size, hidden_size) # 784 -> 500
        self.relu = nn.ReLU() # activation 함수 시그모이드 말구 relu 씀
        self.fc2 = nn.Linear(hidden_size, num_classes) # 500 -> 10

    def forward(self, x): # forward 과정
        out = self.fc1(x)
        out = self.relu(out)
        out = self.fc2(out)
        return out


model = NeuralNet(input_size, hidden_size, num_classes).to(device)
# 파라미터는 init 값
# to(device) 딱히 없어도 됨


# Loss and optimizer
criterion = nn.CrossEntropyLoss() # 로스
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)

# Train the model
total_step = len(train_loader)
for epoch in range(num_epochs):
    for i, (images, labels) in enumerate(train_loader): # loader가 뱉어주는 값은 batch size 만큼의 x와 y
        # Move tensors to the configured device
        images = images.reshape(-1, 28 * 28).to(device) # reshape 하나의 벡터로 만들어?
        labels = labels.to(device)

        # Forward pass
        outputs = model(images)
        loss = criterion(outputs, labels)

        # Backward and optimize
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        if (i + 1) % 100 == 0:
            print('Epoch [{}/{}], Step [{}/{}], Loss: {:.4f}'
                  .format(epoch + 1, num_epochs, i + 1, total_step, loss.item()))

# Test the model
# In test phase, we don't need to compute gradients (for memory efficiency)
with torch.no_grad():
    correct = 0
    total = 0
    for images, labels in test_loader:
        images = images.reshape(-1, 28 * 28).to(device)
        labels = labels.to(device)
        outputs = model(images)
        _, predicted = torch.max(outputs.data, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()

    print('Accuracy of the network on the 10000 test images: {} %'.format(100 * correct / total))

# Save the model checkpoint
torch.save(model.state_dict(), 'model.ckpt')
