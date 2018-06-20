#simple practice
a = pi
print(a)
print(b)

a = c() #create vector
ls() #show all objects
rm(list=ls()) #remove all objects
load("") #load directory or file
getwd() #show filepath



#restore the workspace
save.image("") #restore all info
#r 데이터 파일(.rdata)은 사진찍은 것 같이 그대로 보존
#r file(.r)은 일반 문서 형태
#console 창에 입력하는 것은 메모리 상에 저장됨
#패키지를 우리의 메모리로 가져오자 library("")



#library and packages
library("rgl") #load package
image(volcano) #run package
persp3d(volcano) #run package

#persp3d example from help tap
# (3) Visualizing a simple DEM model

z <- 2 * volcano        # Exaggerate the relief
x <- 10 * (1:nrow(z))   # 10 meter spacing (S to N)
y <- 10 * (1:ncol(z))   # 10 meter spacing (E to W)

open3d()
bg3d("slategray")
material3d(col = "black")
persp3d(x, y, z, col = "blue1", aspect = "iso",
        axes = FALSE, box = FALSE)

#워크스페이스는 메모리에 저장
#네임스페이스(객체 이름 저장), 밸류스페이스(객체에 배정된 값 저장), 주소(밸류 위치)
#다시 창 닫고 열어서 ?persp3d 하면 안 나옴. 워크스페이스 뿐만 아니라 help 파일도 같이 저장되기 때문
#library("rgl")을 불러온 후에 검색 및 결과 확인 가능
#?? 함수 : help 창을 웹에 연결

??persp3d
rgl::persp3d(volcano) # 패키지 명을 함수 명 앞에 명시



#load dataset
#웹데이터를 r이 관리하는 메모리 공간으로 가져오기 = read file 작업
#import dataset -> from text(readr) -> url 입력, update
#first row as names : 첫째 줄이 헤더일 경우 사용
#delimiter comma : 구분자는 컴마
#skip : 어디서부터 읽어야 할지

library(readr)
ls()
print(wine)
save.image("snu-fira-jjj-1-wine")
a=ls()
rm(list='wine')
rm(list=ls()) # 반환된 모든 객체 삭제, 워크스페이스 초기화, 그러나 밸류는 그대로, 말소된 밸류들의 garbage가 생김
gc() # garbage 처리, 다시 밸류 쓸 수 있도록 메모리 반환
# 추후에 컴퓨터와 통신하는 인터페이스 창으로 사용, 백그라운드 창에서 기다리게 만드는 방법 배울 예정




#환경변수
#환경변수의 패쓰를 주다 - 어떤 위치에서도 R을 실행시킬 수 있다
#환경변수가 등록되어 있으면 현재 디렉토리에 없으면 다 뒤져서 찾아냄
#내PC>속성>고급시스템설정>환경변수>편집>새로만들기>확인




#data type practice
#dtype 중요한 이유 : 메모리 관리에 요구, 정밀도 관리에 중요
x = c(88, 15, 12, 13)
x
y = c(3)
y
#연산자이면서 함수인 콜론(:), 시작과 끝 두 개의 argument 받음
#콜론(:) : 하나씩 더해주거나, 하나씩 빼주는 함수, 뒤에 오는 숫자 넘지 않도록
#length=a, a개의 벡터 생성하라
x1 = 1:3
x1
x2 = 10:5
x2
x3 = c(x1, x2)
x3
x4 = seq(from = 12, to = 31, by = 2)
x4
x5 = seq(from = 12, to =30, length = 100)
x5
# repeat function
x = rep(8,4)
x
p = rep((c(5, 12, 13)), c(1, 2, 3))
p
u = x
u
x
x = 5:8
x
x1 = x[1:3]
x1
x2 = c(x1[1:3], 10, x[4])
x2
y = c(1.2, 3.9, 0.4, 0.12)
y[1:3]
y[c(1:3)] #C(1:3) = 1 2 3



#r/java
library(XLConnect) #r에서 java 설치완료
install.packages("XLConnect") # 엑셀 및 자바 핸들링 패키지 설치