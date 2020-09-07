library(dplyr)

mtcars %>% slice(1L)

mtcars %>% slice(n())

mtcars %>% slice(5:n())

slice(mtcars, -(1:4))

mtcars %>% slice_head(n = 5)

mtcars %>% slice_tail(n = 5)

mtcars %>% slice_min(mpg, n = 5)

mtcars %>% slice_max(mpg, n = 5)