first_row <- 21
last_col <- 22
ticker <- 'PAYX.xls'
library(readxl)
contents <- read_excel(ticker,skip = 20)[,1:22]

library(reshape2)
contents <- melt(contents,id.vars = c('Fiscal Period'))
names(contents)[1] <- 'concept'

important_concepts <- c("eps without NRI",
                        "Free Cashflow per Share",
                        "Book Value per Share",
                        "Return on Equity %",
                        "Gross Margin %",
                        "Debt to Equity"
                        )

library(ggplot2)
library(lubridate)
contents$variable <- as.character(contents$variable)


ggplot(subset(contents,concept %in% important_concepts),
       aes(x = variable, y= value,group = 1)) + geom_line() +
  facet_wrap(~concept, scales = 'free_y') + theme_bw()
