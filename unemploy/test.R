unem<-read.csv("unemployment.csv",header = TRUE)
#i country
#j 789



    t3 = theta[3]
    t4 = theta[4]
    t5 = theta[5]
    t6 = theta[6]
    t7 = theta[7]
    t8 = theta[8]
    t1 = theta[1]
    t2 = theta[2]


x = 1:3
x = cbind(x,x,x,x,x,x)
x = 0*x
for (i in 1:3){
    for (j in 1:6){
        n = 21-j
        fact = unem[n+1,i+1]
        test = unem[4:n,i+1]
        x[i,j] = err(fact,test,t1,t2,t3,t4,t5,t6,t7,t8)
    }
}

