# Analysis of Variance, ANOVA

# ---------------------------------
# One-way ANOVA, 
# ---------------------------------

# ---------------------------------
# One-way ANOVA, with different repeated measures
# ---------------------------------

# ---------------------------------
# Two-way ANOVA, no repeated measures
# ---------------------------------

# ---------------------------------
# Two-way ANOVA, with repeated measures
# ---------------------------------



# lab-1 : one-way anova
# create dataframe
a = c(643, 655, 702)
b = c(469, 427, 525)
c = c(484, 456, 402)
x = data.frame()
x <- cbind(a, b, c)
colnames(x) = c("경차", "중형차", "대형차")
# create means
abar = mean(a); bbar = mean(b); cbar = mean(c); n=3
tbar = (abar+bbar+cbar) / n
# calculate SStr, SSE, SST
SStr = sum((abar-tbar)^2 + (bbar-tbar)^2 + (cbar-tbar)^2) * n
SSE = sum((643-abar)^2 + (655-abar)^2 + (702-abar)^2 + 
            (469-bbar)^2 + (427-bbar)^2 + (525-bbar)^2 +
            (484-cbar)^2 + (456-cbar)^2 + (402-cbar)^2)  
SST = SStr + SSE
SST # 96303.56
SStr # 86049.56
SSE # 10254
# test statistics
f0 = (SStr/2)/(SSE/6)
f0 # 25.2
# p-value
p = 1-pf(25.2, 2, 6)


# 25.17 
# f값 : 5.14 -> 유의수준 0.05에서 귀무가설 기각. 차이가 있다.
