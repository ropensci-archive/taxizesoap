context("get_pesiid")

test_that("get_pesiid basic usage works", {
  skip_on_cran()

  aa <- get_pesiid(searchterm = "Salvelinus fontinalis", verbose = FALSE)
  expect_is(aa, "pesiid")
  expect_is(aa[1], "character")
  expect_equal(length(aa), 1)
  expect_equal(attr(aa, "match"), "found")
})

test_that("get_pesiid works for multiple name inputs", {
  skip_on_cran()

  aa <- get_pesiid(c("Salvelinus fontinalis","Pomacentrus brachialis"), verbose = FALSE)
  expect_is(aa, "pesiid")
  expect_is(aa[1], "character")
  expect_is(aa[2], "character")
  expect_equal(length(aa), 2)
  expect_equal(attr(aa, "match"), c("found", "not found"))
})

test_that("get_pesiid fails well", {
  skip_on_cran()

  # missing first arg, that's required
  expect_error(get_pesiid(), "argument \"searchterm\" is missing")

  # when not found, gives NA
  expect_true(is.na(get_pesiid("asdfafasdfs", verbose = FALSE)))
})
