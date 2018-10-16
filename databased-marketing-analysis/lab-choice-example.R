library(mlogit)
setwd('C:\\Users\\yuniv\\OneDrive\\바탕 화면\\SNU FIRA\\9_데이터기반마케팅애널리틱스(송인성교수님)\\ChoiceExample')

ydata = read.csv('yogurt100.csv')
ydata[,15:18]=ydata[,15:18]*10  # scaling up prices of yogdata

# column label
# 1. Pan I.D.	
# 2. Expend $	
# 3. Income	
# 4. HH Size	
# 5. IPT
# 6. Quantity	
# 7-10. Choice outcome of Brand 1-4 
# 11-14. Feature 1-4 Dummies
# 15-18. Price 1-4 Dummies */

# use mlogit package
attach(ydata)
ydata$Choice = Brand.1*1+Brand.2*2+Brand.3*3+Brand.4*4
detach(ydata)
ydata2 = mlogit.data(ydata, choice ="Choice", shape = "wide", varying=11:18, alt.levels=1:4)

####################################################
# fot multinomial logit model with mlogit package
####################################################
mlout = mlogit(Choice~Price+Feature, data=ydata2)
summary(mlout)

#Call:
#mlogit(formula = Choice ~ Price + Feature, data = ydata2, method = "nr", 
#    print.level = 0)

#Frequencies of alternatives: "점유율"
#       1        2        3        4 
#0.341975 0.401235 0.029218 0.227572 

#nr method "뉴튼랩슨, 6번 돌아"
#6 iterations, 0h:0m:0s 
#g'(-H)^-1g = 0.000824 
#successive function values within tolerance limits 

#Coefficients :
#               Estimate Std. Error  t-value  Pr(>|t|)    
#2:(intercept) -0.744249   0.079776  -9.3292 < 2.2e-16 *** # - : 1번 브랜드에 비해 작다
#3:(intercept) -4.473863   0.185478 -24.1207 < 2.2e-16 *** # - : 1번 브랜드에 비해 작다
#4:(intercept) -1.387754   0.088049 -15.7611 < 2.2e-16 *** # - : 1번 브랜드에 비해 작다
#Price         -3.705793   0.239946 -15.4443 < 2.2e-16 *** # price 클수록 효용 3.70 단위 떨어진다
#Feature        0.487414   0.119921   4.0644 4.815e-05 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Log-Likelihood: -2658.6
#McFadden R^2:  0.067662 
#Likelihood ratio test : chisq = 385.88 (p.value = < 2.22e-16)
#regression의 f-test : 귀무가설 모든 alpha, beta가 제로일 때 choice prob이 1/n, 모델이 유의하다

####################################################################################
# fot multinomial probit model with mlogit package : probit takes a longer time 
####################################################################################

mpout = mlogit(Choice~Price+Feature, data=ydata2, probit=T)
summary(mpout)

#Call:
#mlogit(formula = Choice ~ Price + Feature, data = ydata2, probit = T)

#Frequencies of alternatives:
#       1        2        3        4 
#0.341975 0.401235 0.029218 0.227572 

#bfgs method
#24 iterations, 0h:1m:58s 
#g'(-H)^-1g = 3.93E-08 
#gradient close to zero 

#Coefficients :
#               Estimate Std. Error  t-value  Pr(>|t|)    
#2:(intercept) -0.522605   0.068863  -7.5890 3.220e-14 ***
#3:(intercept) -2.481746   0.297565  -8.3402 < 2.2e-16 ***
#4:(intercept) -1.165487   0.206655  -5.6398 1.703e-08 ***
#Price         -2.079235   0.187779 -11.0728 < 2.2e-16 ***
#Feature        0.285171   0.068571   4.1588 3.200e-05 ***
#2.3            1.274680   0.258029   4.9401 7.809e-07 *** from 공분산행렬, new error term
#2.4           -0.072720   0.309061  -0.2353  0.813981     from 공분산행렬, new error term
#3.3            0.770114   0.158268   4.8659 1.139e-06 *** from 공분산행렬, new error term
#3.4            0.739908   0.369709   2.0013  0.045358 *   from 공분산행렬, new error term 
#4.4            0.944867   0.315440   2.9954  0.002741 **  from 공분산행렬, new error term
---
  #Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  
#Log-Likelihood: -2643.5 
#McFadden R^2:  0.072927 
#Likelihood ratio test : chisq = 415.9 (p.value = < 2.22e-16)
 
  
##############################################################################
# multinomial logit with my own likelihood + nlm (optimization function)
##############################################################################
# model made without package
yogdata = as.matrix(ydata)
n=2430

myll=function(para) {
  expv = exp(outer(rep(1,times=n),c(0.00, para[1:3]),"*") + para[4]*yogdata[,15:18] + para[5]*yogdata[,11:14])
  sumv=rowSums(expv)
  lnbuypr = log (expv/cbind(sumv,sumv,sumv,sumv)) # (expv/cbind(sumv,sumv,sumv,sumv)) 선택확률
  mylogll = colSums(lnbuypr*yogdata[,7:10])
  sum(-mylogll)
}


initp = array(-0.001,dim=5) # starting value for beta 

outpara = nlm(myll,initp,hessian=TRUE, print.level=1, iterlim=length(initp)*100)
# outpara = nlm(myll,initp,hessian=TRUE, print.level=2, iterlim=length(initp)*100)

vcov = solve(outpara$hessian) # hessian의 inverse
se = sqrt(diag(vcov))

cat("MLE Output \n")
cat("The likelihood value :", outpara$minimum,"\n")
cat("Estimate and the Standard Errors \n")
print (t(rbind(outpara$estimate,se)))
