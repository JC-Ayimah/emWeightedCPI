data <- empirical_Data1
test_that("inflation calculates correctly using specific index", {
  inflation_value <- mvw_inflation(index = 'fisher', data = data)
  expect_equal(class(inflation_value), 'character')
})

test_that("inflation throws error message when invalid index name is provided", {
  expect_error(mvw_inflation(index = 'fish', data = data))
  expect_error(inflation())
})
