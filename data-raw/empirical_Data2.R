library(dplyr)
library(readr)
library(janitor)

empirical_Data2 <- read_csv('data-raw/Empirical Data_2.csv',
                            col_names = F, show_col_types = F) |>
  slice(-(1:2)) |>
  row_to_names(row_number = 1) |>
  mutate_if(is.character, as.double)

usethis::use_data(empirical_Data2, overwrite = TRUE)
