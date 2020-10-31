context("Testing code coverage from mulitply by 2 if even.")

testthat::test_that("Checks when even", {
  expect_equal(multiply_by_2_if_even(4), 8)
  expect_equal(multiply_by_2_if_even(-22), -44)
})

testthat::test_that("Checking for odd outputs", {
  expect_equal(multiply_by_2_if_even(3), 3)
})
