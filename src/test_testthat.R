# Created by: JiaweiMao
# Created on: 6/18/2020

add_one <- function(x) {
  as.integer(x) + as.integer(1)
}
testthat::expect_type(add_one(1), "integer")
testthat::expect_error(add_one("a"), "x must be an integer")