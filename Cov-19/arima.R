library("tseries")
library(forecast)
acf(case_data_sg)
adf.test(case_data_sg)
diff_sg=diff(case_data_sg)
diff_sg[1]=0
acf(diff_sg)
auto.arima(case_data_sg)
fit = arima(case_data_sg,order=c(5,2,1))
pred = predict(fit, n.ahead = 30, se.fit = TRUE)
pred$pred
plot(pred$pred)
pacf(case_data_sg)
