# 중심극한정리 : 이항분포의 정규근사
par(mfrow=c(1,3))

plot(0:10,dbinom(0:10,size=10,prob=0.1), pch=16, xlim=c(-3,15))
lines(0:10,dbinom(0:10,size=10,prob=0.1), xlim=c(-3,15))
lines(-5:15,dbinom(-5:15,mean=1,sd=sqrt(0.9)), xlim=c(-3,15), col='blue')

plot(0:15,dbinom(0:15,size=30,prob=0.1), pch=16, xlim=c(-3,15))
lines(0:15,dbinom(0:15,size=30,prob=0.1), xlim=c(-3,15))
lines(-5:15,dbinom(-5:15,mean=3,sd=sqrt(2.7)), type='l', xlim=c(-3,15), col='blue')

plot(0:25,dbinom(0:25,size=50,prob=0.1), pch=16, xlim=c(-3,15))
lines(0:25,dbinom(0:25,size=50,prob=0.1), xlim=c(-3,15))
lines(-5:25,dbinom(-5:25,mean=5,sd=sqrt(4.5)), xlim=c(-3,15), col='blue')


# 카이제곱분포
par(mfrow=c(1,1))
plot(seq(0,40,0.1), dchisq(seq(0,40,0.1),3), xlab='x', ylab='density', type='l')
lines(seq(0,40,0.1), dchisq(seq(0,40,0.1),6), col='blueviolet')
lines(seq(0,40,0.1), dchisq(seq(0,40,0.1),9), col='coral')
lines(seq(0,40,0.1), dchisq(seq(0,40,0.1),20), col='seagreen')
legend('topright', legend=c('k=3', 'k=6', 'k=9', 'k=20'), 
       col=c('black', 'blueviolet', 'coral', 'seagreen'), lty=c(1,1,1,1,1))
# 자유도가 3,6,9,20으로 커질수록 정규분포의 형태를 띈다


# t분포
plot(seq(-5,5,0.1), dt(seq(-5,5,0.1),20), col='seagreen', xlab='x', ylab='density', type='l')
lines(seq(-5,5,0.1), dt(seq(-5,5,0.1),6), col='blueviolet')
lines(seq(-5,5,0.1), dt(seq(-5,5,0.1),9), col='coral')
lines(seq(-5,5,0.1), dt(seq(-5,5,0.1),3))
lines(seq(-5,5,0.1), dnorm(seq(-5,5,0.1)), col='blue')
legend('topright', legend=c('k=3', 'k=6', 'k=9', 'k=20', 'normal'), 
       col=c('black', 'blueviolet', 'coral', 'seagreen', 'blue'), lty=c(1,1,1,1,1))


# F분포
par(mfrow=c(1,3))
plot(seq(0,4,0.1), df(seq(0,4,0.1),3,20), col="seagreen", xlab='x', 
     ylab='density', type='l', main='k1=3')
lines(seq(0,4,0.1), df(seq(0,4,0.1),3,6), xlab='x', ylab='density', 
      type='l', col="blueviolet")
lines(seq(0,4,0.1), df(seq(0,4,0.1),3,10), xlab='x', ylab='density', 
      type='l', col="coral")
lines(seq(0,4,0.1), df(seq(0,4,0.1),3,3), xlab='x', ylab='density', 
      type='l')
legend('topright', col=c('black', 'blueviolet', 'coral', 'seagreen'),
       lty=c(1,1,1,1), c('k2=3', 'k2=6', 'k2=10', 'k2=20'))

plot(seq(0,4,0.1), df(seq(0,4,0.1),10,20), col="seagreen", xlab='x', 
     ylab='density', type='l', main='k1=10')
lines(seq(0,4,0.1), df(seq(0,4,0.1),10,6), xlab='x', ylab='density', 
      type='l', col="blueviolet")
lines(seq(0,4,0.1), df(seq(0,4,0.1),10,10), xlab='x', ylab='density', 
      type='l', col="coral")
lines(seq(0,4,0.1), df(seq(0,4,0.1),10,3), xlab='x', ylab='density', 
      type='l')
legend('topright', col=c('black', 'blueviolet', 'coral', 'seagreen'),
       lty=c(1,1,1,1), c('k2=3', 'k2=6', 'k2=10', 'k2=20'))

plot(seq(0,4,0.1), df(seq(0,4,0.1),20,20), col="seagreen", xlab='x', 
     ylab='density', type='l', main='k1=20')
lines(seq(0,4,0.1), df(seq(0,4,0.1),20,6), xlab='x', ylab='density', 
      type='l', col="blueviolet")
lines(seq(0,4,0.1), df(seq(0,4,0.1),20,10), xlab='x', ylab='density', 
      type='l', col="coral")
lines(seq(0,4,0.1), df(seq(0,4,0.1),20,3), xlab='x', ylab='density', 
      type='l')
legend('topright', col=c('black', 'blueviolet', 'coral', 'seagreen'),
       lty=c(1,1,1,1), c('k2=3', 'k2=6', 'k2=10', 'k2=20'))
