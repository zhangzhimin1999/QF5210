
#ok
library(pracma)
unem<-read.csv("unemployment.csv",header = TRUE)
options(digits = 3)
sing<-unem[6:dim(unem)[1],2]
uk<-unem[6:dim(unem)[1],3]
us<-unem[6:dim(unem)[1],4]
n=length(sing)
x<-1:n
bs<-theta1*(sing[n]-sing[n-2])/2+theta2*(sing[n]-sing[n-4])/4+theta3*(sing[n]-sing[n-6])/6
xi = seq(from=,to=n,by=0.01)
sing1<-cubicspline(x, sing, xi , endp2nd = TRUE, der = c(0, bs))
bk<-theta1*(uk[n]-uk[n-2])/2+theta2*(uk[n]-uk[n-4])/4+theta3*(uk[n]-uk[n-6])/6
uk1<-cubicspline(x, uk, xi , endp2nd = TRUE, der = c(0, bk))
bsa<-theta1*(us[n]-us[n-2])/2+theta2*(us[n]-us[n-4])/4+theta3*(us[n]-us[n-6])/6
us1<-cubicspline(x, us, xi , endp2nd = TRUE, der = c(0, bsa))

#problem
set.seed(1)
a<-rnorm(length(xi),mean = n,sd=theta4)
b<-which(a<=n)
a<-a[b]
b<-which(a>1)
a<-a[b]



ad = floor(a*10)
au = ad + 1
sing10 = (a*10-ad)/(au-ad) * sing1[au-10] + (au-a*10)/(au-ad) * sing1[ad-10]



fit1<-lm(sing10~a+I(a^2)+I(a^3))
pre = data.frame(a = 14:n+2)
pred = predict(fit,pre)
