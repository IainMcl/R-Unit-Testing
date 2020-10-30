# Adaptation of example code from https://towardsdatascience.com/unit-testing-in-r-68ab9cc8d211
context("Increment function")

test_that("Integer single number", {
  expect_equal(increment(5), 6)
  expect_equal(increment(-3), -2)
  expect_equal(increment(0), 1)
})

test_that("Floats", {
  expect_equal(increment(4.5), 5.5)
})

test_that("Vector inputs", {
  expect_equal(increment(c(3, 4)), c(4, 5))
  expect_equal(increment(c(3.14, 0)), c(4.14, 1))
})

test_that("Empty vectors", {
  # Incrementing an empty vector gives numeric(0)
  # Since this is maybe not obveous this could be caught in the function its self and
  # handled there.
  expect_equal(increment(c()), numeric(0))
})

test_that("NA", {
  expect_true(is.na(increment(NA)))
})
