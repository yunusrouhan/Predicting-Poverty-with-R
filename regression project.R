##Setting the Working Directory
### pre-processing ######
#install.packages("data.table")
install.packages("corrplot")
library(corrplot)
setwd("D:/USF/Semester 2/Qmb")
library(readxl)
popdata=read_excel("6304 Regression Project Data.xlsx")
popdata$popcollege = (popdata$percollege*popdata$poptotal)/100
popdata$popprof = (popdata$perprof*popdata$poptotal)/100
popdata$ratioca = (popdata$popchild/popdata$popadult)
popdata$popchildpoverty = (popdata$perchildpoverty*popdata$popchild)/100
##subset
metro = subset(popdata, inmetro == 1)
rural = subset(popdata, inmetro == 0)
##Random seed
set.seed(93827161)
some.rural.poverty = rural[sample(1:nrow(rural),60,replace=FALSE),]
some.metro.poverty = metro[sample(1:nrow(metro),30,replace=FALSE),]

## Analyzing the data, plotting to check correlation between variables with a correlation matrix
continuous.rural.poverty = subset(some.rural.poverty,select=c("area","poptotal","popdensity","popwhite","popblack","popasian","popadult","popchild","percollege","perprof","perchildpoverty","perelderlypoverty","popcollege","popprof","ratioca","popchildpoverty"))
plot(continuous.rural.poverty)
xx=cor(continuous.rural.poverty)
corrplot(xx,method="circle")

#Building linear models
regout1=lm(perelderlypoverty~.-ID-county-state,data=some.rural.poverty)
summary(regout1)
regout2=lm(perelderlypoverty~perchildpoverty+popchildpoverty+area+poptotal+ratioca,data=some.rural.poverty)
summary(regout2)

##add popcollege
regout=lm(perelderlypoverty~perchildpoverty+area+poptotal+ratioca+popcollege,data=some.rural.poverty)
summary(regout)
regout=lm(perelderlypoverty~perchildpoverty+percollege+perprof+area+poptotal+popcollege,data=some.rural.poverty)
summary(regout)
regout=lm(perelderlypoverty~perchildpoverty+percollege+perprof+poptotal+popcollege,data=some.rural.poverty)
summary(regout)
##Final
regout3=lm(perelderlypoverty~perchildpoverty+perprof+popdensity+popcollege,data=some.rural.poverty)
summary(regout3)


plot(regout3)

#putting a correlation matrix into object
install.packages('corrplot')
library(corrplot)
xx=cor(continuous.rural.poverty)
corrplot(xx,method="circle")
corrplot(xx,method="number")

##substetting few columns to find correlation
d1=subset(some.rural.poverty,select=c("perelderlypoverty","perchildpoverty","perprof","popdensity","popcollege","popprof"))
d2=subset(some.rural.poverty,select=c("perelderlypoverty","perchildpoverty","perprof","popdensity","popcollege"))

yy=cor(d2)
corrplot(yy,method="number")

#Correlation matrix with p values.
install.packages('Hmisc')
library(Hmisc)
xx=rcorr(as.matrix(d2))
xx

#Verifying the r^2 value.
cor(regout$fitted.values,d2$perelderlypoverty)^2
plot(d2$perelderlypoverty,regout$fitted.values,main="Actual v. Fitted Values")

#Variance Inflation Factors (VIF)
#Measure of Multicollinearity -- correlation of independents
#How much the variance of a beta coefficient is being inflated by multicollinearity.
#Evidence of Multicollinearity.
plot(d2)
xx=cor(d2)
corrplot(xx,method="number")
corrplot(xx,method="ellipse")

#Variance Inflation Factors (VIF)
library(car)
vif(regout3)


stdresids=rstandard(regout3)
plot(regout3$fitted.values,stdresids)
abline(0,0,col="red",lwd=3)


qqnorm(regout3$residuals)
qqline(regout3$residuals)

##LINE assumptions
install.packages("ggfortify")
library(ggfortify)
autoplot(regout3)

##finding the outlier
boxplot(some.rural.poverty$perelderlypoverty)
max(some.rural.poverty$perelderlypoverty)
which(some.rural.poverty$perelderlypoverty==18.27736)

#Leverage of Points
lev=hat(model.matrix(regout3))
plot(lev,pch=19)
abline(3*mean(lev),0,col="red",lwd=3)
some.rural.poverty[lev>(3*mean(lev)),]

##Assessing how well the best fit model predicts "perelderlypoverty" when applied to the "some.metro.poverty" data frame.
predict(regout3,some.metro.poverty,interval="predict") 

predict(regout3,some.metro.poverty,interval="confidence")









