library(MASS)
library(zoo)
library(vars)
library(tseries)
library(fGarch)
library(forecast)
library("MTS")

VARselect(total_data_sg_before_M5,lag.max=10)


model_sg_var=VAR(total_data_sg_before_M5,2)

model_sg_var=refVAR(model_sg_var,thres=1.96)

Jun_to_Sep_newcase_sg=numeric(122)

Oct_total_sg=numeric(31)
Oct_newcase_sg=numeric(31)
pred_data_sg=numeric(31)

pointer=t-123
base_sg_validation=active_sg[pointer]
total_data_sg_update=total_data_sg_before_M5

##############validation for us
for (i in c(1:122))
{
  pred_sg=VARpred(model_sg_var,1)
  total_data_sg_update=rbind(total_data_sg_update,c(total_data_sg_M6_M9[i,1:5]))
  model_sg_var$data=total_data_sg_update
  Jun_to_Sep_newcase_sg[i]=base_sg_validation*pred_sg$pred[1]
  pointer=pointer+1
  base_sg_validation=active_sg[pointer]
}

plot(case_sg,xlim=c(0,700))
lines(seq(from=t-122,by=1,length=122), Jun_to_Sep_newcase_sg,col="red")

base_sg=active_sg[pointer+1]
##############us
for (i in c(1:31))
{
  pred_sg=VARpred(model_sg_var,1)
  total_data_sg_update=rbind(total_data_sg_update,c(pred_sg$pred[1],total_data_sg_M6_M9[122,2:5]))
  model_sg_var$data=total_data_sg_update
  recover=0
  for (j in c(5:40))
  {
    recover=recover+case_sg[t+i-j]*dnorm(j,mean = 11.5, sd = 5.7, log = FALSE)
  }
  Oct_newcase_sg[i]=base_sg*pred_sg$pred[1]
  pred_data_sg[i]=pred_sg$pred[1]
  case_sg[t+i]=Oct_newcase_sg[i]
  Oct_total_sg[i]=base_sg+Oct_newcase_sg[i]-recover
  base_sg=Oct_total_sg[i]
}

plot(case_sg,xlim=c(0,700))
lines(seq(from=t,by=1,length=31), Oct_newcase_sg,col="red")

plot(increase_rate_sg,xlim=c(0,700))
lines(seq(from=t,by=1,length=31), pred_data_sg,col="red")