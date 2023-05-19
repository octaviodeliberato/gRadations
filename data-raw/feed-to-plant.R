library(clipr)
library(dplyr)

rom <- read_clip_tbl()

rom |> dplyr::glimpse()

rom |>
  dplyr::mutate(mm = sub(",", ".", x)) |>
  dplyr::mutate(wp = sub(",", ".", y_ajus)) |>
  dplyr::mutate(across(everything(), as.numeric)) |>
  dplyr::select(mm, wp) -> rom

grad_fit_lst <- gRadations::fit_gradation(
  gradation_tbl = rom,
  sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 25.4, 19.1, 12.7,
            9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
  method = "SP",
  .interactive = FALSE
)

grad_fit_lst$data |>
  filter(stream == "fit") |>
  select(x) |>
  clipr::write_clip()

grad_fit_lst$data |>
  filter(stream == "fit") |>
  select(y) |>
  round(2) |>
  clipr::write_clip()
