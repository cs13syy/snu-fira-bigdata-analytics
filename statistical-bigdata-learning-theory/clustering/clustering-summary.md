## Kmeans
### concept
- 사전 정보 없이 자료를 컴퓨터에게 주고, “유사한 대상끼리 묶어보아라!” 라고 명령을 내리는 분석 방법
- w는 center 가 움직일 때마다 다른 점들과의 거리의 합
- 거리를 구하기 때문에 컴퓨터 시간이 오래 걸리는 경우가 많음
### code decription
- kmeans(x,centers,nstart,algorithm...)
- x = nxp matrix (n은 observation의 개수, p는 covariate)
- centers = 클러스터의 개수 또는 initial center
- 성능에 있어서 초기 center가 굉장히 중요
- nstart = 몇 번 새로 시작해볼지, 값을 키우면 랜덤 센터를 nstart번 정함
- algorithm : 정확하게, 빠르게 하고자할 때 사용하는 패키지
- cluster means: 센터의 위치
- within cluster sum: 센터와 각 점들간의 거리의 제곱합
- $cluster, $center
- $withinss는 작고 $betweenss는 클수록 좋다
- set.seed() : 랜덤으로 무언가를 해야할 때
- 맨 처음 씨드 잡아놓고 전체 실행 또는 한 청크마다 씨드 고정
- col=(km.out$cluster+1) #0이면 블랙, 저렇게 하면 빨, 초

## Hierarchical Clustering
- complete : 집단 간 거리 중에 가장 먼, 가장 보수적, 가장 많이 씀
- single : 집단 간 거리 중에 가장 가까운, 1:99가 될 확률 높음
- 클러스터링 개수 k 몇 개가 적당한가? 적당히 크게 잡고 군집 분포 보고 그 후에 줄이는 방법 추천
- hclust의 파라미터
- d = distance(거리는 구하는 건 오래 걸리는 일), 미리 거리는 구해놓고 넣어라 라는 뜻. dist라는 함수를 이용해서 넣어라. matrix를 받지 못해. x라는 자료가 있다면, dist(x)를 써라. 
- hc.complete/average/single : 덴도그램만 만든 것. 이 이후에 cutree해야 끝남
- cutree(계층군집화 객체, 클러스터의 개수)
- 과정이 복잡하고 성능이 그닥 좋지 않음
- as.dist(): 거리행렬로 바꾸어줌
- dd=as.dist(|1-cor(t(x))|) # 비유사도 나타냄, 통계적 거리
- members = 

## Principal Component Analysis
### concept
- unsupervised : 반응 변수 없는 경우에 속함
- 
- 
- pca regression : 활용 정도 높음. 
### code description
- 
