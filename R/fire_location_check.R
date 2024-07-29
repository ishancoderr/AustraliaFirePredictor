#' Fire Location Check
#'
#' This function reads fire data from a CSV file, preprocesses it, and performs fire prediction.
#' @param file_path A string indicating the path to the CSV file containing the fire data.
#' @param output_model_path Optional; A string indicating the path to save the trained model. If NULL, the model is not saved.
#' @return A list containing the trained model and evaluation metrics.
#' @importFrom sf st_as_sf st_drop_geometry
#' @importFrom caret createDataPartition
#' @importFrom xgboost xgb.DMatrix xgb.train xgb.save
#' @export
fire_location_check <- function(file_path, output_model_path = NULL) {

  data <- utils::read.csv(file_path)

  print("Column names after reading CSV:")
  print(names(data))

  data_sf <- sf::st_as_sf(data, coords = c("longitude", "latitude"), crs = 4326, remove = FALSE)

  data_sf$satellite <- as.factor(data_sf$satellite)
  data_sf$instrument <- as.factor(data_sf$instrument)
  data_sf$daynight <- as.factor(data_sf$daynight)
  data_sf$type <- as.factor(data_sf$type)

  data_df <- sf::st_drop_geometry(data_sf)

  print("Column names after dropping geometry:")
  print(names(data_df))

  data <- data_df[c("longitude", "latitude", "brightness", "confidence", "frp", "satellite", "instrument", "daynight", "scan", "track", "bright_t31")]

  if (all(is.na(data$confidence))) {
    stop("The 'confidence' column contains only missing values.")
  }

  data <- data[!is.na(data$confidence), ]


  if (length(unique(data$confidence)) < 2) {
    stop("The 'confidence' variable must have at least 2 unique values.")
  }

  if (nrow(data) < 10) {
    stop("The dataset must contain at least 10 rows for meaningful analysis.")
  }

  set.seed(123)  # For reproducibility
  trainIndex <- caret::createDataPartition(data$confidence, p = .8, list = FALSE)
  trainData <- data[trainIndex, ]
  testData <- data[-trainIndex, ]

  factor_columns <- sapply(trainData, is.factor)
  trainData_numeric <- trainData
  testData_numeric <- testData

  trainData_numeric[factor_columns] <- lapply(trainData_numeric[factor_columns], as.numeric)
  testData_numeric[factor_columns] <- lapply(testData_numeric[factor_columns], as.numeric)

  trainData_numeric <- trainData_numeric[, setdiff(names(trainData_numeric), "confidence")]
  testData_numeric <- testData_numeric[, setdiff(names(testData_numeric), "confidence")]

  if (any(sapply(trainData_numeric, class) != "numeric")) {
    print("Non-numeric columns in training data:")
    print(names(trainData_numeric)[sapply(trainData_numeric, class) != "numeric"])
    stop("Training data contains non-numeric columns.")
  }

  if (any(sapply(testData_numeric, class) != "numeric")) {
    print("Non-numeric columns in test data:")
    print(names(testData_numeric)[sapply(testData_numeric, class) != "numeric"])
    stop("Test data contains non-numeric columns.")
  }

  train_matrix <- xgboost::xgb.DMatrix(data = as.matrix(trainData_numeric), label = trainData$confidence)
  test_matrix <- xgboost::xgb.DMatrix(data = as.matrix(testData_numeric), label = testData$confidence)
  params <- list(
    objective = "reg:squarederror",
    eval_metric = "rmse",
    eta = 0.1,
    max_depth = 6
  )
  model <- xgboost::xgb.train(params, train_matrix, nrounds = 100)
  if (!is.null(output_model_path)) {
    xgboost::xgb.save(model, output_model_path)
  }
  predictions <- stats::predict(model, test_matrix)

  actual <- testData$confidence
  rmse <- sqrt(mean((predictions - actual)^2))
  cat("Root Mean Squared Error (RMSE):", rmse, "\n")

  return(list(model = model, rmse = rmse))
}


