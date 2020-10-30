context("Testing test-file.R. Note test- in the name.")
test_that("This file does start with 'test-'", {
  expect_equal(2+4, 6)
})
