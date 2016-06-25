context("get_wormsid")

test_that("get_wormsid basic usage works", {
  skip_on_cran()

  aa <- get_wormsid(searchterm = "Salvelinus fontinalis", verbose = FALSE)
  expect_is(aa, "wormsid")
  expect_is(aa[1], "character")
  expect_equal(length(aa), 1)
  expect_equal(attr(aa, "match"), "found")
})

test_that("get_wormsid works for multiple name inputs", {
  skip_on_cran()

  aa <- get_wormsid(c("Salvelinus fontinalis","Pomacentrus brachialis"), verbose = FALSE)
  expect_is(aa, "wormsid")
  expect_is(aa[1], "character")
  expect_is(aa[2], "character")
  expect_equal(length(aa), 2)
  expect_equal(attr(aa, "match"), c("found", "found"))
})

test_that("get_wormsid fails well", {
  skip_on_cran()

  # missing first arg, that's required
  expect_error(get_wormsid(), "argument \"searchterm\" is missing")

  # when not found, gives NA
  expect_true(is.na(get_wormsid("asdfafasdfs", verbose = FALSE)))
})
