# Example comparison using linear regression  of Real Estate Data based on price, number of rooms, and neighborhood.

# Problem 1

neighbor = read.csv("Neighborhood_data.csv", header = T)
neighbor
attach(neighbor)
sample.size = 20

# Replacing 0 and 1 in Neighborhood column to make it easier to understand the linear model summary
df = data.frame(Price, Rooms, Neighborhood)
df$Neighborhood[df$Neighborhood==0] = "East"
df$Neighborhood[df$Neighborhood==1] = "West"
detach(neighbor)
df

# 1a
attach(df)
n.dataWest = lm(Price~Rooms + Neighborhood)
summary(n.dataWest)

# changing the baseline to confirm the math for the linear model based on West- mostly for practice
Neighborhood = relevel(factor(Neighborhood), ref = "West")
n.dataEast = lm(Price~Rooms + Neighborhood)
summary(n.dataEast)

# 1c
E.price = 9.219*9 + 12.697*0 + 243.737
(E.price*1000)
E.price2 = 9.219*9 -12.697*1 + 256.434
E.price2*1000

# 1f - testing variables separately
mod.rooms = lm(Price~Rooms)
summary(mod.rooms)
mod.nhood = lm(Price~Neighborhood)
summary(mod.nhood)
detach(df)

# 1g
slope.rooms = 9.219
SE.rooms = 1.030

significance = 0.05
df = sample.size - 3
sig.left = sig.right = significance / 2

(t.right = qt(1-sig.right, df))
(margin.error = t.right * SE.rooms)
(ci.upper = slope.rooms + margin.error)
(ci.lower = slope.rooms - margin.error)

# 1h
slope.nhood = 12.697
SE.nhood = 3.535

significance = 0.05
df = sample.size - 3
sig.left = sig.right = significance / 2

(t.right = qt(1-sig.right, df))
(margin.error = t.right * SE.nhood)
(ci.upper = slope.nhood + margin.error)
(ci.lower = slope.nhood - margin.error)

