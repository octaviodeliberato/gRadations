# sample data
grad_tbl <- dplyr::tribble(
  ~x,	~y,
  50.0,	100.0,
  37.5, 100.0,
  25.4, 100.0,
  19.1, 100.0,
  12.5, 98.6,
  9.5, 91.6,
  6.3, 71.6,
  4.8, 62.5,
  2.4, 44.5,
  1.2, 33.0,
  0.6, 25.2,
  0.3, 19.6,
  0.15, 14.0,
  0.075, 6.3,
  0, 0
)

test_that("Spline works", {
  expect_named(
    object = fit_gradation(
      gradation_tbl = grad_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "SP",
      .interactive = FALSE
    ),
    expected = c("data", "plot_x", "plot_log10_x")
  )
})

test_that("RR works", {
  expect_named(
    object = fit_gradation(
      gradation_tbl = grad_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "RR",
      .interactive = FALSE
    ),
    expected = c("data", "plot_x", "plot_log10_x")
  )
})
