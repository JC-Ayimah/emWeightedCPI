price_data <- empirical_Data1
exp_data <- expenditure_Data
test_that("inflation produces correct output", {
  inflation_value <- eb_inflation(expenditure_data = exp_data, price_data = price_data)
  expect_equal(class(inflation_value), 'character')
})

test_that("inflation function handles edge cases", {
  inflation <- eb_inflation(expenditure_data = c(), price_data = c())
  expect_equal(inflation, 'Inflation is NA')
})
