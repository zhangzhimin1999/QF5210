library(MASS)
library(zoo)
library(vars)
library(tseries)
library(fGarch)
library(forecast)
library("MTS")

VARselect(total_data_uk_before_M5,lag.max=10)


model_uk_var=VAR(total_data_uk_before_M5,2)

model_uk_var=refVAR(model_uk_var,thres=1.96)

Jun_to_Sep_newcase_uk=numeric(122)

Oct_total_uk=numeric(31)
Oct_newcase_uk=numeric(31)
pred_data_uk=numeric(31)

pointer=t-123
base_uk_validation=active_uk[pointer]
total_data_uk_update=total_data_uk_before_M5

##############validation for us
for (i in c(1:122))
{
  pred_uk=VARpred(model_uk_var,1)
  total_data_uk_update=rbind(total_data_uk_update,c(total_data_uk_M6_M9[i,1:5]))
  model_uk_var$data=total_data_uk_update
  Jun_to_Sep_newcase_uk[i]=base_uk_validation*pred_uk$pred[1]
  pointer=pointer+1
  base_uk_validation=active_uk[pointer]
}

plot(case_uk,xlim=c(0,700))
lines(seq(from=t-122,by=1,length=122), Jun_to_Sep_newcase_uk,col="red")

base_uk=active_uk[pointer+1]
##############us
for (i in c(1:31))
{
  pred_uk=VARpred(model_uk_var,1)
  total_data_uk_update=rbind(total_data_uk_update,c(pred_uk$pred[1],total_data_uk_M6_M9[122,2:5]))
  model_uk_var$data=total_data_uk_update
  recover=0
  for (j in c(5:40))
  {
    recover=recover+case_uk[t+i-j]*dnorm(j,mean = 11.5, sd = 5.7, log = FALSE)
  }
  Oct_newcase_uk[i]=base_uk*pred_uk$pred[1]
  pred_data_uk[i]=pred_uk$pred[1]
  case_uk[t+i]=Oct_newcase_uk[i]
  Oct_total_uk[i]=base_uk+Oct_newcase_uk[i]-recover
  base_uk=Oct_total_uk[i]
}

plot(case_uk,xlim=c(0,700))
lines(seq(from=t,by=1,length=31), Oct_newcase_uk,col="red")

plot(increase_rate_uk,xlim=c(0,700))
lines(seq(from=t,by=1,length=31), pred_data_uk,col="red")
