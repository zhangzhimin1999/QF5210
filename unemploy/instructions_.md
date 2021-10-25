#  unemployment
  
i will first show how we get our result with a specific series of premeter , and then i show how we get this premeter , and our final result.
##  workflow with known prameter
  
first we have a file contain 3 countries data:
```bash
(base) lys@DESKTOP-3HE5NAO:/mnt/f/学习资料/研一上/qf5210/project/git/QF5210/unempploy$ head unemployment.csv
Region,Singapore,United Kingdom,United States
01/2020,2.4,4,3.5
02/2020,2.4,4,3.5
03/2020,2.4,4,4.4
04/2020,2.6,4.1,14.8
05/2020,2.8,4.1,13.3
06/2020,2.8,4.3,11.1
07/2020,3.2,4.5,10.2
```
we load a specific country's data and call it dat:
```R
unem<-read.csv("unemployment.csv",header = TRUE)
dat = unem[1:18,4]
plot(dat)
``` 
we firstly get:
![](dat.png?0.35452653342719387 )  
  
then we use first 3 parameter to insert the dat.
for example , we used(1,1,1)
```R
#example
t1 = 1
t2 = 1
t3 = 1
#our insert function
inter = function(dat,t1,t2,t3){
    n = length(dat)
    sing = dat
    x = 1:n
    bs = t1*(sing[n]-sing[n-2])/2+t2*(sing[n]-sing[n-4])/4+t3*(sing[n]-sing[n-6])/6
    xi = seq(from=,to=n,by=0.1)
    sing1 = cubicspline(x, sing, xi , endp2nd = TRUE, der = c(0, bs))
    return(sing1)
}
#example output
library(pracma)
dat1 = inter(dat,t1,t2,t3)
plot(dat1)
``` 
dat1:
![](dat1.png?0.7920251400205605 )  
  
  
we try some extrme value:
```R
t1 = 100
t2 = 0
t3 = 0
test = inter(dat,t1,t2,t3)
plot(test)
```
![](test.png?0.3640057803993051 )  
different parameter determine how the right terminal of the out put look like
  
then we do filter , on the one hand , the spectrum tell us that there is not much high frequency component , on the other hand , our input data is monthly so the micro structure in a month is meaningless , which means we need a low pass filter.
but our focus is the rightside terminal behaveiour , our requirement about spectrum transform is not that strict , but we require little anamorphic strictly during rightside terminal , which means we need to design a digital filter ourselves.
in a digital filter , the only thing we need is a trsnsform function from 0,0,0....1,0,0,0,0,..to f(t) , after that ,we can transform a input timeseries to a output one.
here is our filter:
```R
filterabc <- function(t5,t6,t7,dat){
    n = length(dat)
    N = 1:(n+150)
    N = N * 0
    ai = 1:30
    bi = 1:90
    ci = 1:150
    for (i in 1:n){
        N[ai + i -1] = N[ai + i -1] + exp(-ai^2/100)*dat[i]*t5/sum(exp(-ai^2/100))
        N[bi + i -1] = N[bi + i -1] + exp(-bi^2/900)*dat[i]*t6/sum(exp(-bi^2/900))
        N[ci + i -1] = N[ci + i -1] + exp(-ci^2/2500)*dat[i]*t7/sum(exp(-ci^2/2500))
    }
    return (N[1:n])
}
```
i'll sohw it by these:
```R
t5 = 0.3
t6 = 0.3
t7 = 0.3
test2 = 1:100
test2 = test2*0
test2 = c(test2,1,test2)
test20 = filterabc(t5,t6,t7,test2)
par(mfrow = c(1,2))
ts.plot(test2)
ts.plot(test20)
```
![](show.png?0.7504085711986905 )  
  
we can also have a look on how the filter perform during our sample
```R
test1 = test
test10 = filterabc(t5,t6,t7,test1)
plot(test1,col = 'red')
points(1:length(test1),test10,col = 'blue')
```
![](filter.png?0.44811689085732276 )  
form this plot we find that our filter can effeciently smooth the input time series , and the right terminal don't miss alot.
  
we don't use this test , instead we use dat1:
```R
test1 = dat1
test10 = filterabc(t5,t6,t7,test1)
#plot(test1,col = 'red')
#points(1:length(test1),test10,col = 'blue')
plot(60:length(test1),test10[60:length(test1)],col = 'blue')
points(6:17 * 10 , dat[6:17])
```
here we get the filtered dat test10 , we plot it from 2020/6:
![](filtered.png?0.2868465165439871 )  
the black points is the original signal.
  
then we do the polynomial regrassion , but we prefer a more locally one , as we metioned in our model , we will give more weight to those point near the right terminal. we derive the weight by choosing the subset for regrassion skillfully:
```R
subs = function(t4,n){
    set.seed(1)
    #by our defination t4 is + and can't be too small , 
    #so we just use abs(t4)+0.1 to make sure the freedom during optimal
    a = rnorm(400,mean = n,sd=abs(t4)+0.1)
    #n is the maximum of subset
    b = which(a<=n)
    a = a[b]
    b = which(a>1)
    a = a[b]
    return(a)
}
```
as example we use`t4 = 4`
```R
dat2 = test10
n = length(dat)
a = subs(t4,n)
plot(density(a))
```
![](density.png?0.5120900537608906 )  
  
  
then we do poly regassion:
```R
polyr = function(dat,a){
    ad = floor(a*10)
    au = ad + 1
    sing1 = dat
    sing10 = (a*10-ad)/(au-ad) * sing1[au-10] + (au-a*10)/(au-ad) * sing1[ad-10]
    fit = lm(sing10~poly(a,3))
    return(fit)
}
```
  
then we predict a model
```R
  
fit = polyr(dat2,a)
#pridict model : line
time = seq(from=5,to=20,by=0.01)
dt = data.frame(a = time)
require(graphics)
pred = predict(fit,dt)
plot(time,pred,lty = 1,cex = 0.001)
#subset used for regrassion : red points
  
    ad = floor(a*10)
    au = ad + 1
    sing1 = dat2
    sing10 = (a*10-ad)/(au-ad) * sing1[au-10] + (au-a*10)/(au-ad) * sing1[ad-10]
  
points(a,sing10,col = 'red')
#original signal : blue point
points(5:18,dat[5:18],col = 'blue')
```
![](poly.png?0.31934447386898523 )  
the black line is our prediction , the blue point is the original infomation , the red points is the modified infomation point we get using this specific series of parameter.
finnaly , we plot the details of the result:
```R
plot(15:20,unem[15:20,4],col = 'blue')
time = seq(from=15,to=20,by=0.01)
dt = data.frame(a = time)
require(graphics)
pred = predict(fit,dt)
lines(time,pred,lty = 1)
  
points(a,sing10,col = 'red')
#original signal : blue point
#points(5:18,dat[5:18],col = 'blue')
  
#points(19,unem[19,4],pch = 24)
points(19,as.numeric(pred[which(time==19)]),pch = 25)
  
  
#points(20,unem[20,4],pch = 24)
points(20,as.numeric(pred[which(time==20)]),pch = 25)
```
![](result.png?0.37777825558191824 )  
this series of premeter is really suitble for america June by chance , the error is only 0.04 in July.
  
##  determine a series of parameter from a known timeseries:
  
  
  
  
  
  
  
  