library(testthat)

test_that("RMSE is within the expected range", {
  file_path <- system.file("extdata", "fire_data.csv", package = "AustraliaFirePredictor")
  output_model_path <- system.file("model", "firePredictorModel.xgb", package = "AustraliaFirePredictor")

  results <- fire_location_check(file_path, output_model_path)

  # Extract the RMSE value
  rmse_value <- results$rmse

  acceptable_range <- c(0, 20)

  expect_true(rmse_value >= acceptable_range[1] && rmse_value <= acceptable_range[2],
              info = paste("RMSE value is out of range. It is", rmse_value))
})

