source('params.R')
 library(TTR)
 price <- TTR::getYahooData('HIBB')

library(readxl)
contents <- read_excel(paste0(ticker,'.xls'),skip = first_row)[,1:last_col]

library(reshape2)
contents <- melt(contents,id.vars = c('Fiscal Period'))
names(contents)[1] <- 'concept'
contents <- contents %>% filter(concept %in% important_concepts$concept)


library(ggplot2)
library(lubridate)
library(directlabels)
library(dplyr)
library(scales)
contents <- merge(contents,important_concepts,by='concept')

plotTypes <- sort(unique(contents$Grouping))
for(iLoop in 1:length(plotTypes)) {
  curr_group <- plotTypes[iLoop]
  curr_plot_data <- contents %>% 
    filter(Grouping == curr_group)

gplot <- ggplot(curr_plot_data,
       aes(x = variable, y= value,group = concept, color = concept)) + geom_line() +
  scale_x_discrete() + scale_y_continuous(label = comma) +theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = ticker)
gplot <- direct.label(gplot,list("top.points", cex=1, 
                                 fontface="bold", fontfamily="serif", alpha=0.5))

ggsave(filename = paste0(ticker,'-',curr_group,'.pdf'))
}

library(PerformanceAnalytics)
chartPrices <- price[,'Close']
charts.PerformanceSummary(Return.calculate(chartPrices), ylog = TRUE)
charts.RollingPerformance(chartPrices,width = 252)
