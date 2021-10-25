# unemployment
i will first show how we get our result with a specific series of premeter , and then i show how we get this premeter , and our final result.
## a workflow with known prameter
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
@import "dat.png"

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
@import "dat1.png"


we try some extrme value:
```R
t1 = 100
t2 = 0
t3 = 0
test = inter(dat,t1,t2,t3)
plot(test)
```
@import "test.png"
different parameter determine how the right terminal of the out put look like

then we do filter , on the one hand , the spectrum tell us that there is not much high frequency component , on the other hand , our input data is monthly so the micro structure in a month is meaningless , which means we need a low pass filter.
but our focus is the rightside terminal behaveiour , our requirement about spectrum transform is not that strict , but we require little anamorphic strictly during rightside terminal , which means we need to design a digital filter ourselves.
in a digital filter , the only thing we need is a trsnsform function from 0,0,0....1,0,0,0,0,..to f(t) , after that ,we can transform a input timeseries to a output one.

