context("Testing file.R <- note no test- in the name.")
testthat("This file does not start with 'test-'", {
  expect_equal(2+4, 6)
})
