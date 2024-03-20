test_that("inflation calculates correctly using specific index", {
  inflation_value <- inflation(weights = 'paashe')
  expect_equal(class(inflation_value), 'character')
})

test_that("inflation throws error message when invalid weight name is provided", {
  expect_error(inflation(weights = 'fish'))
  expect_error(inflation())
})
