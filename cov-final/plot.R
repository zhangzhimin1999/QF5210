library(ggplot2)

uk_plot = ggplot() + 
  geom_line(aes(x = c(1:(t-1)), y = case_uk[1:(t-1)],color = "Real")) +
  geom_line(aes(x = c((t-122):(t-1)),y = Jun_to_Sep_newcase_uk,color = "Predict")) +
  scale_color_manual(name = "new cases", values = c("Real" = "darkblue", "Predict" = "red"))+
  geom_vline(xintercept = c(t-122), linetype = "longdash") +
  xlab('Dates') +
  ylab('UK new cases')+
  labs(title ="New Cases in UK M6-M9")+
  theme(plot.title = element_text(hjust = 0.5))
uk_plot

ggsave(plot = uk_plot, width = 9, height = 6, dpi = 300, filename = "uk.png")
