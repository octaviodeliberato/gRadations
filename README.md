
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gRadations: Dealing with Size Distributions

<!-- badges: start -->

[![R-CMD-check](https://github.com/octaviodeliberato/gRadations/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/octaviodeliberato/gRadations/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of gRadations is to allow the representation of size
distributions by means of curve fitting.

## Installation

You can install the development version of gRadations from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("octaviodeliberato/gRadations")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(gRadations)

grad_lst <- size_distributions |> 
  dplyr::group_by(id, .add = TRUE) |> 
  dplyr::group_split()

grad_fit_lst <- vector(mode = "list", length = length(grad_lst))

for (i in seq_along(grad_lst)) {

  grad_fit_lst[[i]] <- fit_gradation(
    gradation_tbl = grad_lst[[i]] |> 
      dplyr::select(x, y),
    sizes = c(692, 300, 125, 88.9, 63.5, 44.4, 31.7, 19.1, 12.7,
              9.52, 6.35, 4.76, 2.38, 1.19, 0.59, 0.297, 0.149, 0.074),
    method = "SP",
    .interactive = FALSE
  )

}

grad_fit_lst[[1]][["plot_x"]]
```

<img src="man/figures/README-example-1.png" width="90%" />

``` r
grad_fit_lst[[1]][["plot_log10_x"]]
```

<img src="man/figures/README-example-2.png" width="90%" />
