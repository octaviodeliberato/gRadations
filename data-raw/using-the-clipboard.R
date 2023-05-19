hseries <- clipr::read_clip_tbl()
hseries <- hseries |>
  dplyr::mutate(dplyr::across(everything(),
                              ~as.numeric(stringr::str_replace(.x, ",", "\\."))))
grads <- gRadations::size_distributions

sizes <- c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
           9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074)

wp <- gRadations::fit_gradation(
  gradation_tbl = hseries,
  sizes = sizes,
  method = "SP",
  .interactive = TRUE
)

wp$data |>
  dplyr::filter(stream == 'fit') |>
  dplyr::pull(y) |>
  as.character() |>
  stringr::str_replace(string = _, "\\.", ",") |>
  writeClipboard()
