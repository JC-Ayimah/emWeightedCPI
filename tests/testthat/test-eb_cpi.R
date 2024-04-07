price_data <- empirical_Data1
exp_data <- expenditure_Data
test_that("eb_cpi calculates index correctly", {
  index <- eb_cpi(price_data = price_data, expenditure_data = exp_data)
  expect_equal(length(index), 1) #check if 1index value is returned
  expect_true(names(index) %in% "mwCPI_Lasp") #check if index name is correct
  expect_equal(class(index), 'numeric') #check if returned value is numeric
  expect_equal(index, c(mwCPI_Lasp = 4.6475406)) #check if answer is correct
})
