# Ticker name
ticker <- 'PG'

#When you download the excel sheet from Gurufocus,
# save it as <ticker>.xls

# This mark the number of columns to import, and the rows to skip
first_row <- 20
last_col <- 22

# The list of concepts I want to plot

important_concepts <- c("eps without NRI",
                        "Free Cashflow per Share",
                        "Book Value per Share",
                        "Return on Equity %",
                        "Gross Margin %",
                        "Debt to Equity",
                        "Price-to-Free-Cash-Flow Ratio" ,
                        "EBIT per Share",
                        "Month End Stock Price",
                        "Earnings Yield (Joel Greenblatt)",
                        "Net Cash (per share)",
                        "Shiller PE Ratio",
                        "Intangible Assets",
                        "Total Assets"
)
