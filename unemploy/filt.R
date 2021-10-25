# 0:10 means a month or insert 9 point every month
filterabc <- function(a,b,c,dat){
    n = length(dat)
    N = 1:(n+150)
    N = N * 0
    ai = 1:30
    bi = 1:90
    ci = 1:150
    for (i in 1:n){
        N[ai + i -1] = N[ai + i -1] + exp(-ai^2/100)*dat[i]*a/sum(exp(-ai^2/100))
        N[bi + i -1] = N[bi + i -1] + exp(-bi^2/900)*dat[i]*b/sum(exp(-bi^2/900))
        N[ci + i -1] = N[ci + i -1] + exp(-ci^2/2500)*dat[i]*c/sum(exp(-ci^2/2500))
    }
    return (N[1:n])
}
dat1 = filterabc(a,b,c,dat)