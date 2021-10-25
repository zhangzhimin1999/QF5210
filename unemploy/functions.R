
inter = function(dat,t1,t2,t3){
    n = length(dat)
    sing = dat
    x = 1:n
    bs = t1*(sing[n]-sing[n-2])/2+t2*(sing[n]-sing[n-4])/4+t3*(sing[n]-sing[n-6])/6
    xi = seq(from=,to=n,by=0.1)
    sing1 = cubicspline(x, sing, xi , endp2nd = TRUE, der = c(0, bs))
    return(sing1)
}

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

subs = function(t4,n){
    set.seed(1)
    a = rnorm(200,mean = n,sd=abs(t4)+0.1)
    b = which(a<=n)
    a = a[b]
    b = which(a>1)
    a = a[b]
    return(a)
}

polyr = function(dat,a){
    ad = floor(a*10)
    au = ad + 1
    sing1 = dat
    sing10 = (a*10-ad)/(au-ad) * sing1[au-10] + (au-a*10)/(au-ad) * sing1[ad-10]
    fit = lm(sing10~poly(a,3))
    return(fit)
}

pre = function(dat,fit){
    n = length(dat)
    pr = predict(fit,data.frame(a = n+1))
    return(pr)
}


err = function(fact,dat,t1,t2,t3,t4,t5,t6,t7,t8,n){
    dat1 = inter(dat,t1,t2,t3)
    dat2 = filterabc(t5,t6,t7,dat1)
    dat2 = dat2 + t8*dat1
    a = subs(dat2,t4,n)
    fit = polyr(dat2,a)
    pred = pre(dat,fit)
    pred = as.numeric(pred)
    return(fact-pred)
}


t1 = 1
t2 = 1
t3 = 1
t4 = 2
t5 = 0
t6 = 0
t7 = 0
t8 = 1
optmize