library(ggplot2)
Sys.setlocale("LC_TIME", "English")

jun_sep_sg=numeric(4)
jun_sep_uk=numeric(4)
jun_sep_us=numeric(4)
total_world_jun_sep=numeric(4)
jun_sep_sg[1:4]=c(sum(Jun_to_Sep_newcase_sg[4:33]),sum(Jun_to_Sep_newcase_sg[34:64]),sum(Jun_to_Sep_newcase_sg[65:95]),sum(Jun_to_Sep_newcase_sg[96:122])+sum(Oct_newcase_sg[1:3]))
jun_sep_uk[1:4]=c(sum(Jun_to_Sep_newcase_uk[4:33]),sum(Jun_to_Sep_newcase_uk[34:64]),sum(Jun_to_Sep_newcase_uk[65:95]),sum(Jun_to_Sep_newcase_uk[96:122])+sum(Oct_newcase_uk[1:3]))
jun_sep_us[1:4]=c(sum(Jun_to_Sep_newcase_us[4:33]),sum(Jun_to_Sep_newcase_us[34:64]),sum(Jun_to_Sep_newcase_us[65:95]),sum(Jun_to_Sep_newcase_us[96:122])+sum(Oct_newcase_us[1:3]))

oct_sg=sum(Oct_newcase_sg[1:31])
oct_uk=sum(Oct_newcase_uk[1:31])
oct_us=sum(Oct_newcase_us[1:31])

total_world_jun_sep[1:4]=six_nine_sg[1:4]+six_nine_uk[1:4]+six_nine_us[1:4]
total_world_oct=oct_sg+oct_uk+oct_us
date_oct=seq(as.Date("2021-10-01"),by="day",length.out=31)

#total_plot
#sg
sg_plot_total = ggplot() + 
  geom_line(aes(x = date_range, y = case_sg[1:t],color = "Real")) +
  geom_line(aes(x = date_range[(t-121):t],y = Jun_to_Sep_newcase_sg,color = "Predict for Jun to Sep")) +
  geom_line(aes(x = date_oct,y = Oct_newcase_sg,color = "Predict for Oct")) +
  geom_ribbon(aes(x = date_oct,ymin = lower_sg, ymax = upper_sg,fill = "95% CI for Oct"), alpha = 0.45) +
  scale_fill_manual(values=c("green"), name="fill")+
  scale_color_manual(name = "new cases", values = c("Real" = "darkblue", "Predict for Jun to Sep" = "red","Predict for Oct" = "darkgreen"))+
  geom_vline(xintercept = c(t-122), linetype = "longdash") +
  coord_cartesian(xlim=c(date_range[1],date_oct[31]),ylim=c(0,5000)) +
  xlab('Dates') +
  ylab('SG new cases')+
  labs(title ="New Cases in SG Total")+
  theme(plot.title = element_text(hjust = 0.5))
sg_plot_total

ggsave(plot = sg_plot_total, width = 9, height = 6, dpi = 300, filename = "sg_plot_total.png")


#uk
uk_plot_total = ggplot() + 
  geom_line(aes(x = date_range, y = case_uk[1:t],color = "Real")) +
  geom_line(aes(x = date_range[(t-121):t],y = Jun_to_Sep_newcase_uk,color = "Predict for Jun to Sep")) +
  geom_line(aes(x = date_oct,y = Oct_newcase_uk,color = "Predict for Oct")) +
  geom_ribbon(aes(x = date_oct,ymin = lower_uk, ymax = upper_uk,fill = "95% CI for Oct"), alpha = 0.45) +
  scale_fill_manual(values=c("green"), name="fill")+
  scale_color_manual(name = "new cases", values = c("Real" = "darkblue", "Predict for Jun to Sep" = "red","Predict for Oct" = "darkgreen"))+
  geom_vline(xintercept = c(t-122), linetype = "longdash") +
  coord_cartesian(xlim=c(date_range[1],date_oct[31]),ylim=c(0,60000)) +
  xlab('Dates') +
  ylab('UK new cases')+
  labs(title ="New Cases in UK Total")+
  theme(plot.title = element_text(hjust = 0.5))
uk_plot_total

ggsave(plot = uk_plot_total, width = 9, height = 6, dpi = 300, filename = "uk_plot_total.png")

#us
us_plot_total = ggplot() + 
  geom_line(aes(x = date_range, y = case_us[1:t],color = "Real")) +
  geom_line(aes(x = date_range[(t-121):t],y = Jun_to_Sep_newcase_us,color = "Predict for Jun to Sep")) +
  geom_line(aes(x = date_oct,y = Oct_newcase_us,color = "Predict for Oct")) +
  geom_ribbon(aes(x = date_oct,ymin = lower_us, ymax = upper_us,fill = "95% CI for Oct"), alpha = 0.45) +
  scale_fill_manual(values=c("green"), name="fill")+
  scale_color_manual(name = "new cases", values = c("Real" = "darkblue", "Predict for Jun to Sep" = "red","Predict for Oct" = "darkgreen"))+
  geom_vline(xintercept = c(t-122), linetype = "longdash") +
  coord_cartesian(xlim=c(date_range[1],date_oct[31]),ylim=c(0,300000)) +
  xlab('Dates') +
  ylab('US new cases')+
  labs(title ="New Cases in US Total")+
  theme(plot.title = element_text(hjust = 0.5))
us_plot_total

ggsave(plot = us_plot_total, width = 9, height = 6, dpi = 300, filename = "us_plot_total.png")

#global
global_plot_total = ggplot() + 
  geom_line(aes(x = date_range, y = case_us[1:t]+case_uk[1:t]+case_sg[1:t],color = "Real")) +
  geom_line(aes(x = date_range[(t-121):t],y = Jun_to_Sep_newcase_sg+Jun_to_Sep_newcase_uk+Jun_to_Sep_newcase_us,color = "Predict for Jun to Sep")) +
  geom_line(aes(x = date_oct,y = Oct_newcase_sg+Oct_newcase_uk+Oct_newcase_us,color = "Predict for Oct")) +
  scale_color_manual(name = "new cases", values = c("Real" = "darkblue", "Predict for Jun to Sep" = "red","Predict for Oct" = "green","Real for Oct"="orange"))+
  geom_vline(xintercept = c(t-122), linetype = "longdash") +
  coord_cartesian(xlim=c(date_range[1],date_oct[31]),ylim=c(0,300000)) +
  xlab('Dates') +
  ylab('Global new cases')+
  labs(title ="New Cases in Global Total")+
  theme(plot.title = element_text(hjust = 0.5))
global_plot_total

ggsave(plot = global_plot_total, width = 9, height = 6, dpi = 300, filename = "global_plot_total.png")

