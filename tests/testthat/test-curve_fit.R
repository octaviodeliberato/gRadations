# sample data 1
grad_1_tbl <- dplyr::tribble(
  ~x, ~y,
  50.0, 100.0,
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

# sample data 2
grad_2_tbl <- dplyr::tribble(
  ~x, ~y,
  50.0, 100.0,
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
  0.075, 6.3
)

# sample data 3
grad_3_tbl <- dplyr::tribble(
  ~x, ~y,
  0.075, 6.3,
  0.15, 14,
  0.3, 19.6,
  0.6, 25.2,
  1.2, 33,
  2.4, 44.5,
  4.8, 62.5,
  6.3, 71.6,
  9.5, 91.6,
  12.5, 98.6,
  19.1, 100.0,
  25.4, 100.0,
  37.5, 100.0,
  50, 100.0
)

# tests
test_that("Spline works 1", {
  expect_named(
    object = fit_gradation(
      gradation_tbl = grad_1_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "SP",
      plotly = FALSE
    ),
    expected = c("data", "plot_x", "plot_log10_x")
  )
})

test_that("RR works 1", {
  expect_named(
    object = fit_gradation(
      gradation_tbl = grad_1_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "RR",
      plotly = FALSE
    ),
    expected = c("data", "plot_x", "plot_log10_x")
  )
})

test_that("Spline works 2", {
  expect_named(
    object = fit_gradation(
      gradation_tbl = grad_2_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "SP",
      plotly = FALSE
    ),
    expected = c("data", "plot_x", "plot_log10_x")
  )
})

test_that("RR works 2", {
  expect_named(
    object = fit_gradation(
      gradation_tbl = grad_2_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "RR",
      plotly = FALSE
    ),
    expected = c("data", "plot_x", "plot_log10_x")
  )
})

test_that("These should be equivalent 1", {
  expect_mapequal(
    object = fit_gradation(
      gradation_tbl = grad_3_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "SP",
      plotly = FALSE
    ),
    expected = fit_gradation(
      gradation_tbl = grad_2_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "SP",
      plotly = FALSE
    )
  )
})

test_that("These should be equivalent 2", {
  expect_mapequal(
    object = fit_gradation(
      gradation_tbl = grad_3_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "SP",
      plotly = FALSE
    ),
    expected = fit_gradation(
      gradation_tbl = grad_1_tbl,
      sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
                9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
      method = "SP",
      plotly = FALSE
    )
  )
})
