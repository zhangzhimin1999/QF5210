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

case_data_sg = xts(case_data[,2],order.by = case_data[,1])
case_data_uk = xts(case_data[,3],order.by = case_data[,1])
case_data_us = xts(case_data[,4],order.by = case_data[,1])

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
plot.ts(case_plot_sg,ylab = "Singapore New cases daily",xlab="Date")
plot.ts(case_plot_uk,ylab = "United Kingdom New cases daily",xlab="Date")
plot.ts(case_plot_us,ylab = "United States New cases daily",xlab="Date")


