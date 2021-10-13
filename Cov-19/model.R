library(MASS)
library(tseries)
library(fGarch)
install.packages("MTS")
library("MTS")
active_sg=case_data[,5]
active_uk=case_data[,6]
active_us=case_data[,7]
t=length(case_sg)
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

plot(increase_rate_uk)
plot(government_uk,increase_rate_uk)
plot(containment_uk,increase_rate_uk)
plot(stringency_uk,increase_rate_uk)

total_data_uk=cbind(increase_rate_uk,government_uk,containment_uk,stringency_uk)

'''lm
fit_uk=lm(increase_rate_uk~government_uk+containment_uk+stringency_uk)
summary(fit_uk)
fit_uk_aic = stepAIC(fit_uk)
summary(fit_uk_aic)
plot(fit_uk_aic$residuals)

'''
'''arima
auto.arima(increase_rate_uk)
fit_uk_arima=arima(increase_rate_uk,order=c(0,0,3))
fit_uk_arima$residuals
plot(fit_uk_arima$residuals)

'''
'''garch
fit_uk_garch=garchFit(formula= ~arma(0,3) + garch(1,1),increase_rate_uk,trace = F)
plot(fit_uk_garch@residuals)

res = residuals(fit_uk_garch)
res_std = res / fit_uk_garch@sigma.t
par(mfrow=c(2,3))
plot(res)
acf(res)
acf(res^2)
plot(res_std)
acf(res_std)
acf(res_std^2)

forecast = predict(fit_uk_garch,n.ahead=30)
plot(forecast)
'''

model_uk_var=VAR(total_data_uk,30)

pred_uk=VARpred(model_uk_var,30)
N=c(0:30)
n=c(0:32)
N[1]=active_uk[t]
for (i in c(2:31))
{
  recover=0
  for (j in c(10:18))
  {
    recover=recover+case_uk[t-j]*dnorm(j,mean = 14, sd = 1, log = FALSE)
  }
  n[i]=N[i-1]*pred_uk$pred[,1][i-1]
  N[i]=N[i-1]+n[i]-recover
}

plot(n)
plot(N)
