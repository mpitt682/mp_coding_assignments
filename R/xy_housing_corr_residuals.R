# Calculating correlation coefficients and linear regression for two different datasets provided in class

# Problem 1
xy = read.csv("Corr_residuals_xy.csv", header = T)
xy


# 1a
(cor(xy))  

# 1c
result.1 = lm(xy$y~xy$x1+xy$x2+xy$x3+xy$x4)
summary(result.1)
result.2 = lm(xy$y~xy$x2+xy$x3+xy$x4)
summary(result.2)
result.3 = lm(xy$y~xy$x2+xy$x4)
summary(result.3)

# 1d
(resid.3 = residuals(result.3))
plot(xy$x2,resid.3)
lines(c(0,120),c(0,0))
plot(xy$x4,resid.3)
lines(c(0,40),c(0,0))
plot(resid.3)
lines(c(0,13),c(0,0))
boxplot(resid.3)

# 1e
x2.e = 35.6
x4.e = 29
(y = 1.1584*x2.e -2.627*x4.e + 281.6166)

# 1f
qqnorm(resid.3)
qqline(resid.3)

# Problem 2
house = read.csv("Corr_residuals_housing.csv", header = T)
house

# 2a
cor(house)

# 2b-2d
attach(house)
names(house)
y = Asking.Price
x1 = Square.Footage
x2 = Bedrooms
x3 = Baths
result.1 = lm(y~x1+x2+x3)
summary(result.1)
result.11 = lm(y~x1)
summary(result.11)
result.12 = lm(y~x2)
summary(result.12)
result.13 = lm(y~x3)
summary(result.13)

# 2e
result.2 = lm(y~x1+x3)
summary(result.2)

# 2f
(resid.2 = residuals(result.2))
plot(x1,resid.2)
lines(c(0,4000),c(0,0))
plot(x3,resid.2)
lines(c(0,5),c(0,0))
plot(resid.2)
lines(c(0,14),c(0,0))
boxplot(resid.2)
qqnorm(resid.2)
qqline(resid.2)
detach(house)

# 2g
(0.07181*1000)
(54.91632*1000)

# 2h
x1.h = 2900
x3.h = 3
(y = 0.07181*x1.h+54.91632*x3.h + 24.09198)
(y*1000)

