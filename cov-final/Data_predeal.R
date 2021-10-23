library(xts)
library(tseries)
library(tsbox)
#read data
case_data=read.csv("new_case.csv")
government_data=read.csv("Government_Response_Index.csv")
containment_data=read.csv("Containment_Health_Index.csv")
economic_data=read.csv("Economic_Support_Index.csv")
stringency_data=read.csv("Stringency_Index.csv")
vaccine_data=read.csv("vaccine_index.csv")


#deal and plot
case_data$Date=as.Date(case_data$Date)

t=length(case_data[,2])
case_sg=case_data[,2]
for (i in (c(8:t)))
{
  case_sg[i]=mean(case_data[,2][(i-7):i])
}
# case_sg[1]=case_data[,2][1]*0.7+case_data[,2][2]*0.3
# case_sg[2:(t-1)]=case_data[,2][1:(t-2)]*0.3+case_data[,2][2:(t-1)]*0.4+case_data[,2][(3:t)]*0.3
# case_sg[t]=case_data[,2][t]*0.7+case_data[,2][t-1]*0.3
# 

t=length(case_data[,3])
case_uk=case_data[,3]

for (i in (c(8:t)))
{
  case_uk[i]=mean(case_data[,3][(i-7):i])
}

# case_uk[1]=case_data[,3][1]*0.7+case_data[,3][2]*0.3
# case_uk[2:(t-1)]=case_data[,3][1:(t-2)]*0.3+case_data[,3][2:(t-1)]*0.4+case_data[,3][(3:t)]*0.3
# case_uk[t]=case_data[,3][t]*0.7+case_data[,3][t-1]*0.3

t=length(case_data[,4])

case_us=case_data[,4]
for (i in (c(8:t)))
{
case_us[i]=mean(case_data[,4][(i-7):i])
}


case_data_sg = xts(case_sg,order.by = case_data[,1])
case_data_uk = xts(case_uk,order.by = case_data[,1])
case_data_us = xts(case_us,order.by = case_data[,1])
active_case_sg=xts(case_data[,5],order.by = case_data[,1])
active_case_uk=xts(case_data[,6],order.by = case_data[,1])
active_case_us=xts(case_data[,7],order.by = case_data[,1])

government_data$Date=as.Date(government_data$Date)

government_data_sg = xts(government_data[,2],order.by = government_data[,1])
government_data_uk = xts(government_data[,3],order.by = government_data[,1])
government_data_us = xts(government_data[,4],order.by = government_data[,1])

containment_data$Date=as.Date(containment_data$Date)

containment_data_sg = xts(containment_data[,2],order.by = containment_data[,1])
containment_data_uk = xts(containment_data[,3],order.by = containment_data[,1])
containment_data_us = xts(containment_data[,4],order.by = containment_data[,1])

economic_data$Date=as.Date(economic_data$Date)

economic_data_sg = xts(economic_data[,2],order.by = economic_data[,1])
economic_data_uk = xts(economic_data[,3],order.by = economic_data[,1])
economic_data_us = xts(economic_data[,4],order.by = economic_data[,1])

stringency_data$Date=as.Date(stringency_data$Date)

stringency_data_sg = xts(stringency_data[,2],order.by = stringency_data[,1])
stringency_data_uk = xts(stringency_data[,3],order.by = stringency_data[,1])
stringency_data_us = xts(stringency_data[,4],order.by = stringency_data[,1])

vaccine_data$Date=as.Date(vaccine_data$Date)
vaccine_data_sg = xts(vaccine_data[,2],order.by = vaccine_data[,1])
vaccine_data_uk = xts(vaccine_data[,3],order.by = vaccine_data[,1])
vaccine_data_us = xts(vaccine_data[,4],order.by = vaccine_data[,1])

case_plot_sg=ts_ts(case_data_sg)
case_plot_uk=ts_ts(case_data_uk)
case_plot_us=ts_ts(case_data_us)
case_plot_active_sg=ts_ts(active_case_sg)
case_plot_active_uk=ts_ts(active_case_uk)
case_plot_active_us=ts_ts(active_case_us)
plot.ts(case_plot_sg,ylab = "Singapore New cases daily",xlab="Date")
plot.ts(case_plot_uk,ylab = "United Kingdom New cases daily",xlab="Date")
plot.ts(case_plot_us,ylab = "United States New cases daily",xlab="Date")
plot.ts(case_plot_active_sg,ylab = "Singapore Active cases",xlab="Date")
plot.ts(case_plot_active_uk,ylab = "United Kingdom Active cases",xlab="Date")
plot.ts(case_plot_active_us,ylab = "United States Active cases",xlab="Date")

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

government_sg = government_data[,2][2:t]
government_uk = government_data[,3][2:t]
government_us = government_data[,4][2:t]

containment_sg = containment_data[,2][2:t]
containment_uk = containment_data[,3][2:t]
containment_us = containment_data[,4][2:t]

stringency_sg = stringency_data[,2][2:t]
stringency_uk = stringency_data[,3][2:t]
stringency_us = stringency_data[,4][2:t]

vaccine_sg = vaccine_data[,2][2:t]
vaccine_uk = vaccine_data[,3][2:t]
vaccine_us = vaccine_data[,4][2:t]

plot(increase_rate_sg)
plot(increase_rate_uk)
plot(increase_rate_us)

total_data_sg_before_M5=cbind(increase_rate_sg[1:(t-123)],government_sg[1:(t-123)],containment_sg[1:(t-123)],stringency_sg[1:(t-123)],vaccine_sg[1:(t-123)])
total_data_uk_before_M5=cbind(increase_rate_uk[1:(t-123)],government_uk[1:(t-123)],containment_uk[1:(t-123)],stringency_uk[1:(t-123)],vaccine_uk[1:(t-123)])
total_data_us_before_M5=cbind(increase_rate_us[1:(t-123)],government_us[1:(t-123)],containment_us[1:(t-123)],stringency_us[1:(t-123)],vaccine_us[1:(t-123)])

active_sg_M6_M9=active_sg[(t-121):t-1]
active_uk_M6_M9=active_uk[(t-121):t-1]
active_us_M6_M9=active_us[(t-121):t-1]

total_data_sg_M6_M9=cbind(increase_rate_sg[(t-121):t-1],government_sg[(t-121):t-1],containment_sg[(t-121):t-1],stringency_sg[(t-121):t-1],vaccine_sg[(t-121):t-1])
total_data_uk_M6_M9=cbind(increase_rate_uk[(t-121):t-1],government_uk[(t-121):t-1],containment_uk[(t-121):t-1],stringency_uk[(t-121):t-1],vaccine_uk[(t-121):t-1])
total_data_us_M6_M9=cbind(increase_rate_us[(t-121):t-1],government_us[(t-121):t-1],containment_us[(t-121):t-1],stringency_us[(t-121):t-1],vaccine_us[(t-121):t-1])


