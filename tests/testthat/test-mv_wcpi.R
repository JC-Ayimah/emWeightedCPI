data <- empirical_Data1
test_that("mvw_cpi calculates indices correctly", {
  indices <- mvw_cpi(data = data)
  expect_equal(length(indices), 4) #check if 4 indices are returned
  expect_true(all(names(indices) %in% c("mwCPI_Lasp", "mwCPI_Paas", "mwCPI_Fish", "mwCPI_Drob"))) #check if index names are correct
  expect_equal(class(indices), 'numeric') #check if returned value is numeric
})

