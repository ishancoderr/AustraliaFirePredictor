library(testthat)
library(AustraliaFirePredictor)
library(ggplot2)

test_that("plot_fire_locations runs without error and returns a ggplot object", {
  expect_silent({
    p <- plot_fire_locations()
  })

  expect_true(inherits(p, "ggplot"), info = "The output should be a ggplot object")
})

test_that("plot_fire_locations produces a plot with the expected elements", {
  p <- plot_fire_locations()

  expect_true("GeomSf" %in% sapply(p$layers, function(layer) class(layer$geom)[1]),
              info = "The plot should contain a geom_sf layer")

  expect_true("ScaleContinuous" %in% sapply(p$scales$scales, function(scale) class(scale)[1]),
              info = "The plot should contain a continuous scale for color")
})
