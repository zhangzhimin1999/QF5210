library(xts)
library(tsbox)
#read data
case_data=read.csv("new_case.csv")
government_data=read.csv("Government_Response_Index.csv")
containment_data=read.csv("Containment_Health_Index.csv")
economic_data=read.csv("Economic_Support_Index.csv")
stringency_data=read.csv("Stringency_Index.csv")


#deal and plot
case_data$Date=as.Date(case_data$Date)

t=length(case_data[,2])
case_sg=case_data[,2]
case_sg[1]=case_data[,2][1]*0.7+case_data[,2][2]*0.3
case_sg[2:(t-1)]=case_data[,2][1:(t-2)]*0.3+case_data[,2][2:(t-1)]*0.4+case_data[,2][(3:t)]*0.3
case_sg[t]=case_data[,2][t]*0.7+case_data[,2][t-1]*0.3


t=length(case_data[,3])
case_uk=case_data[,3]
case_uk[1]=case_data[,3][1]*0.7+case_data[,3][2]*0.3
case_uk[2:(t-1)]=case_data[,3][1:(t-2)]*0.3+case_data[,3][2:(t-1)]*0.4+case_data[,3][(3:t)]*0.3
case_uk[t]=case_data[,3][t]*0.7+case_data[,3][t-1]*0.3

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
