library(readr)

expenditure_Data <- read_csv('data-raw/Expenditure_Data.csv',
                            col_names = F, show_col_types = F)

usethis::use_data(expenditure_Data, overwrite = TRUE)
