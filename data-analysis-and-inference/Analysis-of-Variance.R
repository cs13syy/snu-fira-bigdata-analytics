# Analysis of Variance, ANOVA


# ---------------------------------
# One-way ANOVA, with same number of repetition
# ---------------------------------
A1 <- c(47, 58, 51, 61, 46); A2 <- c(51, 62, 31, 46, 49)
A3 <- c(50, 38, 47, 27, 23); A4 <- c(22, 23, 28, 42, 25)
A <- c(A1, A2, A3, A4)

group <- as.factor(rep(1:4,each=5))
fabric <- data.frame(A, group)
A_table <- cbind(A1, A2, A3, A4)
apply(A_table, 2, mean)
aov_fabric <- anova(lm(A~group, data=fabric))
p_value <- 1-pf(6.4599, 3, 16)


# ---------------------------------
# One-way ANOVA, with different number of repetition
# ---------------------------------
A1 <- c(2, 3, 4, 5); A2 <- c(4, 5, 6, 4, 3); A3 <- c(6, 5, 7, 4, 6, 8)
A <- c(A1, A2, A3)
mean(A); mean(A1); mean(A2); mean(A3)

group <- as.factor(rep(1:3, times=c(4, 5, 6)))
A_table <- data.frame(A, group)
aov_press <- anova(lm(A~group, data=A_table))
p_value <- 1-pf(4.8119, 2, 12)


# ---------------------------------
# Two-way ANOVA, no repeated measures
# ---------------------------------
pres <- c(79, 75, 69, 65, 72, 66, 64, 62, 51, 48, 
         44, 41, 58, 56, 51, 45, 68, 65, 61, 58)
b <- as.factor(rep(1:4, 5))
a <- as.factor(rep(1:5, each=4))
pres_table <- data.frame(pres, b, a)
aov_table <- anova(lm(pres~b+a, data=pres_table))
b_p_value <- 1-pf(73.80, 3, 12)
a_p_value <- 1-pf(264.72, 4, 12)


# ---------------------------------
# lab-1 : one-way anova
# ---------------------------------
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
