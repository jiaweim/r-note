dm <- data.frame(
  "grade" = 1:6,
  "trip count" = c(0, 2, 2, 3, 2, 1),
  "vaccine" = c(T, F, F, F, T, F)
)

rownames(dm) <- dm$grade
dm$grade <- NULL
print(dm)