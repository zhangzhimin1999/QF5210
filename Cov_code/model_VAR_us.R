library(MASS)
library(zoo)
library(vars)
library(tseries)
library(fGarch)
library(forecast)

VARselect(total_data_us_before_M5,lag.max=10)

detach(package:vars,unload = T)
library("MTS")

model_us_var=VAR(total_data_us_before_M5,10)

model_us_var=refVAR(model_us_var,thres=1.96)

Jun_to_Sep_newcase_us=numeric(122)

Oct_total_us=numeric(31)
Oct_newcase_us=numeric(31)
pred_data_us=numeric(31)

pointer=t-123
base_us_validation=active_us[pointer]
total_data_us_update=total_data_us_before_M5

##############validation for us
for (i in c(1:122))
{
  pred_us=VARpred(model_us_var,1)
  total_data_us_update=rbind(total_data_us_update,c(total_data_us_M6_M9[i,1:5]))
  model_us_var$data=total_data_us_update
  Jun_to_Sep_newcase_us[i]=base_us_validation*pred_us$pred[1]
  pointer=pointer+1
  base_us_validation=active_us[pointer]
}

upper_us = numeric(31)
lower_us = numeric(31)
errors = 0
base_us=active_us[pointer+1]
##############us
for (i in c(1:31))
{
  pred_us=VARpred(model_us_var,1)
  total_data_us_update=rbind(total_data_us_update,c(pred_us$pred[1],total_data_us_M6_M9[122,2:5]))
  model_us_var$data=total_data_us_update
  recover=0
  for (j in c(5:40))
  {
    recover=recover+case_us[t+i-j]*dnorm(j,mean = 11.5, sd = 5.7, log = FALSE)
  }
  Oct_newcase_us[i]=base_us*pred_us$pred[1]
  errors = errors^2+1.96*pred_us$se.err[1]^2
  upper_us[i]=base_us*(pred_us$pred[1]+sqrt(errors))
  lower_us[i]=base_us*(pred_us$pred[1]-sqrt(errors))
  pred_data_us[i]=pred_us$pred[1]
  case_us[t+i]=Oct_newcase_us[i]
  Oct_total_us[i]=base_us+Oct_newcase_us[i]-recover
  base_us=Oct_total_us[i]
}
plot(increase_rate_us,xlim=c(0,700))
lines(seq(from=t,by=1,length=31), pred_data_us,col="red")