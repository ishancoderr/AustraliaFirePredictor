library(testthat)
library(AustraliaFirePredictor)

test_that("predict_fire works", {
  input_data <- data.frame(
    longitude = -119.7,
    latitude = 34.5,
    brightness = 300.0,
    frp = 12.5,
    satellite = "Aqua",
    instrument = "MODIS",
    daynight = "D",
    scan = 1.1,
    track = 1.2,
    bright_t31 = 290.0
  )

  predictions <- predict_fire(input_data)

  # Check if the predictions are numeric
  expect_type(predictions, "double")
})

