context("print_defined")

test_that("fail when nothing is defined in a global environment", {
  expect_error(print_defined(), "Nothing is defined!")
})

test_that("see what happens", {
  a <- 1
  b <- 2
  c <- "findme"
  expect_output(print_defined(), "a\\(numeric\\): 1")
  expect_output(print_defined(), "b\\(numeric\\): 2")
  expect_output(print_defined(), "c\\(character\\): \"findme\"")
})

test_that("when opts var is present", {
  opts <- list()
  opts[["a"]] <- 1
  expect_output(print_defined(as.environment(opts)), "a\\(numeric\\): 1")
})

test_that("when opts var is present", {
  opts <- list()
  opts[["--b"]] <- 1
  expect_error(print_defined(as.environment(opts)))
})

