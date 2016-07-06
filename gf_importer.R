source('params.R')
library(TTR)
price <- TTR::getYahooData(ticker)

library(readxl)
contents <- read_excel(paste0(ticker,'.xls'),skip = first_row)[,1:last_col]

library(reshape2)
contents <- melt(contents,id.vars = c('Fiscal Period'))
names(contents)[1] <- 'concept'



library(ggplot2)
library(lubridate)


gplot <- ggplot(subset(contents,concept %in% important_concepts),
       aes(x = variable, y= value,group = 1)) + geom_line() +
  scale_x_discrete()+
  facet_wrap(~concept, scales = 'free_y',ncol = 2) + theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = ticker)

ggsave(filename = paste0(ticker,'.pdf'),width = 40,height = 100,units = 'cm')

library(PerformanceAnalytics)
charts.PerformanceSummary(Return.calculate(price[,'Close']), ylog = TRUE)
