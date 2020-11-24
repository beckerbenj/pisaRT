

test_that("Wide format", {
  expect_equal(dim(pisaW), c(500, 37))
  expect_equal(names(pisaW)[c(1, 2, 14, 26)], c("ID", "y_1", "RT_1", "log_RT_1"))
})

test_that("Long format", {
  expect_equal(dim(pisaL), c(6000, 5))
  expect_equal(names(pisaL), c("ID", "item", "y", "RT", "log_RT"))
})


test_that("Only positive response times", {
  expect_true(all(pisaL$RT > 0))
  expect_true(all(unlist(pisaW[, paste0("RT_", 1:12)]) > 0))
})

test_that("Only 0 or 1 in responses", {
  expect_true(all(pisaL$y %in% 0:1))
  expect_true(all(unlist(pisaW[, paste0("y_", 1:12)]) %in% 0:1))
})


test_that("Log response times in reasonable range", {
  expect_true(all(pisaL$log_RT > -1))
  expect_true(all(pisaL$log_RT < 8))
  expect_true(all(unlist(pisaW[, paste0("log_RT_", 1:12)]) > -1))
  expect_true(all(unlist(pisaW[, paste0("log_RT_", 1:12)]) < 8))
})
