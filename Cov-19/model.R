library(MASS)
library(tseries)
library(fGarch)
library("MTS")
active_sg=case_data[,5]
active_uk=case_data[,6]
active_us=case_data[,7]
t=length(active_sg)
increase_rate_sg=case_sg[2:t]/active_sg[1:t-1]
increase_rate_uk=case_uk[2:t]/active_uk[1:t-1]
increase_rate_us=case_us[2:t]/active_us[1:t-1]

increase_rate_sg[is.nan(increase_rate_sg)]=0
increase_rate_uk[is.nan(increase_rate_uk)]=0
increase_rate_us[is.nan(increase_rate_us)]=0

increase_rate_sg[is.infinite(increase_rate_sg)]=0
increase_rate_uk[is.infinite(increase_rate_uk)]=0
increase_rate_us[is.infinite(increase_rate_us)]=0

government_sg = government_data[,2][1:t-1]
government_uk = government_data[,3][1:t-1]
government_us = government_data[,4][1:t-1]

containment_sg = containment_data[,2][1:t-1]
containment_uk = containment_data[,3][1:t-1]
containment_us = containment_data[,4][1:t-1]

stringency_sg = stringency_data[,2][1:t-1]
stringency_uk = stringency_data[,3][1:t-1]
stringency_us = stringency_data[,4][1:t-1]

plot(increase_rate_sg)
plot(increase_rate_uk)
plot(increase_rate_us)

total_data_sg=cbind(increase_rate_sg,government_sg,containment_sg,stringency_sg)
total_data_uk=cbind(increase_rate_uk,government_uk,containment_uk,stringency_uk)
total_data_us=cbind(increase_rate_us,government_us,containment_us,stringency_us)

model_sg_var=VAR(total_data_sg,30)
model_uk_var=VAR(total_data_uk,30)
model_us_var=VAR(total_data_us,30)

pred_sg=VARpred(model_sg_var,31)
pred_uk=VARpred(model_uk_var,31)
pred_us=VARpred(model_us_var,31)

Oct_total_sg=numeric(31)
Oct_newcase_sg=numeric(31)
Oct_total_uk=numeric(31)
Oct_newcase_uk=numeric(31)
Oct_total_us=numeric(31)
Oct_newcase_us=numeric(31)

base_sg=active_sg[t]
base_uk=active_uk[t]
base_us=active_us[t]

##############sg
for (i in c(1:31))
{
  recover=0
  for (j in c(1:40))
  {
    recover=recover+case_sg[t+i-j]*dnorm(j,mean = 11.5, sd = 5.7, log = FALSE)
  }
  Oct_newcase_sg[i]=base_sg*pred_sg$pred[,1][i]
  case_sg[t+i]=Oct_newcase_sg[i]
  Oct_total_sg[i]=base_sg+Oct_newcase_sg[i]-recover
  base_sg=Oct_total_sg[i]
}

plot(case_sg,xlim=c(0,700))
lines(seq(from=t,by=1,length=31), Oct_newcase_sg,col="red")

##############uk
for (i in c(1:31))
{
  recover=0
  for (j in c(1:40))
  {
    recover=recover+case_uk[t+i-j]*dnorm(j,mean = 11.5, sd = 5.7, log = FALSE)
  }
  Oct_newcase_uk[i]=base_uk*pred_uk$pred[,1][i]
  case_uk[t+i]=Oct_newcase_uk[i]
  Oct_total_uk[i]=base_uk+Oct_newcase_uk[i]-recover
  base_uk=Oct_total_uk[i]
}

plot(case_uk,xlim=c(0,700))
lines(seq(from=t,by=1,length=31), Oct_newcase_uk,col="red")

##############us
for (i in c(1:31))
{
  recover=0
  for (j in c(1:40))
  {
    recover=recover+case_us[t+i-j]*dnorm(j,mean = 11.5, sd = 5.7, log = FALSE)
  }
  Oct_newcase_us[i]=base_us*pred_us$pred[,1][i]
  case_us[t+i]=Oct_newcase_us[i]
  Oct_total_us[i]=base_us+Oct_newcase_us[i]-recover
  base_us=Oct_total_us[i]
}

plot(case_us,xlim=c(0,700))
lines(seq(from=t,by=1,length=31), Oct_newcase_us,col="red")
