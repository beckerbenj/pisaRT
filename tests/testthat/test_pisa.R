

test_that("Wide format", {
  expect_equal(dim(pisaW), c(500, 23))
  expect_equal(names(pisaW)[c(1, 2, 13)], c("ID", "y_1", "RT_1"))
})

test_that("Long format", {
  expect_equal(dim(pisaL), c(5500, 4))
  expect_equal(names(pisaL), c("ID", "item", "y", "RT"))
})
