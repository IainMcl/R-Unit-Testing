context("Testing the DirectoryTest add function")
source("./../../R/add_function.R", chdir = TRUE)

test_that("Testing the add function", {
  expect_equal(add(2,6), 8)
})


