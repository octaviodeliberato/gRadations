#' Gaudin-Schuhmann curve
#'
#' @param x A numeric vector with the sizes.
#' @param k Gradation topsize, in the same units as \code{x}.
#' @param m An exponent.
#'
#' @return A vector of passing through percentages.
#' @export
gaudin_schuhmann <- function(x, k, m) {

  wp <- 100.0 * (x / k) ^ m

  return(wp)

}


#' Rosin-Rammler curve
#'
#' @param x A numeric vector with the sizes.
#' @param a The size in which 63.2% of the feed passes through.
#' @param b An exponent.
#'
#' @return A vector of passing through percentages.
#' @export
rosin_rammler <- function(x, a, b) {

  wp <- 100.0 - 100.0 * exp(-((x / a) ^ b))

  return(wp)

}


#' The Swebrec curve
#'
#' @param x A numeric vector with the sizes.
#' @param b An exponent.
#' @param xmax Gradation topsize, in the same units as \code{x}.
#' @param x50 Gradation P50, in the same units as \code{x}.
#'
#' @return A vector of passing through percentages.
#' @export
swebrec <- function(x, b, xmax, x50) {

  f <- ( log(xmax / x) / log(xmax / x50) ) ^ b
  return(100 / (1 + f))

  return(f)

}


#' Gradation Curve Fitting
#'
#' @param gradation_tbl Gradation table (data frame).
#' @param sizes The sizes to interpolate the % passing.
#' @param method One of "GS" (Gaudin-Schuhmann), "RR" (Rosin-Rammler), "SB" (Swebrec) or splines otherwise.
#' @param .interactive Returns either a static (ggplot2) visualization or an interactive (plotly) visualization.
#'
#' @return A list with the percentages passing through along with plots.
#' @export
fit_gradation <- function(
    gradation_tbl,
    sizes,
    method = "SP",
    .interactive = TRUE
) {

  names(gradation_tbl) <- c("x", "y")

  x_spline <- stats::splinefun(
    x = gradation_tbl$y, # % passing
    y = gradation_tbl$x, # sizes, mm
    method = "monoH.FC"
  )

  if (method == "RR") {

    a0 <- x_spline(63.2) # d_63.2 initial value

    m <- stats::nls(y ~ rosin_rammler(x, a, b),
             data = gradation_tbl, list(a = a0, b = 1))

    wp <- stats::predict(m, list(x = sizes))

  } else if (method == "GS") {

    k0 <- x_spline(99.9) # topsize initial value

    m <- stats::nls(y ~ gaudin_schuhmann(x, k, m),
             data = gradation_tbl, list(k = k0, m = 1))

    wp <- stats::predict(m, list(x = sizes))

  } else if (method == "SB") {

    m <- gslnls::gsl_nls(
      y ~ 100 / ( 1 + ( log(xmax / x) / log(xmax / x50) ) ^ b ),
      data  = gradation_tbl,
      start = c(xmax = x_spline(99.9), x50 = x_spline(50), b = 2)
    )

    wp <- stats::predict(m, newdata = data.frame(x = sizes))

  } else { # splines

    y_spline <- stats::splinefun(
      x = gradation_tbl$x, # % passing
      y = gradation_tbl$y, # sizes, mm
      method = "monoH.FC"
    )

    wp <- y_spline(sizes)
    wp <- ifelse(wp > 100, 100, wp)
    wp <- ifelse(wp < 0, 0, wp)

  }

  gradation_tbl$stream <- "meas"
  gradation_tbl |>
    dplyr::bind_rows(
      data.frame(
        x = sizes,
        y = wp,
        stream = "fit"
      )
    ) -> gradation_tbl

  max_x <- sizes[which(wp < 100)[1] - 1]

  g <- ggplot2::ggplot(gradation_tbl) +
    ggplot2::aes(x = x, y = y, colour = stream) +
    ggplot2::geom_line(size = 0.85) +
    ggplot2::scale_color_hue(direction = 1) +
    ggplot2::labs(
      x     = "sizes, mm",
      y     = "% passing",
      title = "Gradation Curve"
    ) +
    ggplot2::theme_light()

  gl  <- ggplot2::ggplot(gradation_tbl) +
    ggplot2::aes(x = x, y = y, colour = stream) +
    ggplot2::geom_line(size = 0.85) +
    ggplot2::scale_color_hue(direction = 1) +
    ggplot2::labs(
      x     = "sizes, mm",
      y     = "% passing",
      title = "Size Distribution"
    ) +
    ggplot2::theme_light() +
    ggplot2::scale_x_log10()

  if (.interactive) {

    grad <- list(data = gradation_tbl, plot_x = plotly::ggplotly(g),
                 plot_log10_x = plotly::ggplotly(gl))

  } else {

    grad <- list(data = gradation_tbl, plot_x = g, plot_log10_x = gl)

  }

  return(grad)

}
