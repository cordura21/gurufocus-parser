# Ticker name
ticker <- 'PG'

#When you download the excel sheet from Gurufocus,
# save it as <ticker>.xls

# This mark the number of columns to import, and the rows to skip
first_row <- 20
last_col <- 22

# The list of concepts I want to plot

important_concepts <- read.table('chart_concepts',sep = ',', header = TRUE)

