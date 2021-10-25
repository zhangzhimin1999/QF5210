payoff = function(theta){
    t3 = theta[3]
    t4 = theta[4]
    t5 = theta[5]
    t6 = theta[6]
    t7 = theta[7]
    t8 = theta[8]
    t1 = theta[1]
    t2 = theta[2]
    s = 0
    for (i in 1:5){
        n = length(dat) - i
        fact = dat[n+1]
        tast = dat[1:n]
        delta = err(fact,dat,t1,t2,t3,t4,t5,t6,t7,t8)
        s = s + delta^2
        #print(delta)
    }
    return(s) 
}

theta0 = c(1/3,1/3,1/3,4,0,0,0,1)

optim(theta0,payoff,method = 'BFGS')

theta0 = c(0.290 ,0.306, 0.313, 3.859,-0.135, 0.229 ,0.441, 0.611)