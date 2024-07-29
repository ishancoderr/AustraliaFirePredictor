#' Predict Fire Function
#'
#' This function preprocesses input data and uses a pre-trained XGBoost model to make predictions.
#' @param input_data A data frame containing the input data.
#' @return A vector of predictions.
#' @import xgboost
#' @export
predict_fire <- function(input_data) {

  preprocess_input_data <- function(input_data) {
    input_data$satellite <- as.factor(input_data$satellite)
    input_data$instrument <- as.factor(input_data$instrument)
    input_data$daynight <- as.factor(input_data$daynight)

    input_data_numeric <- input_data
    factor_cols <- sapply(input_data_numeric, is.factor)
    input_data_numeric[factor_cols] <- lapply(input_data_numeric[factor_cols], as.numeric)

    if (any(sapply(input_data_numeric, class) != "numeric")) {
      stop("Input data contains non-numeric columns.")
    }

    return(input_data_numeric)
  }

  input_data_numeric <- preprocess_input_data(input_data)

  # Convert to DMatrix format required by XGBoost
  input_matrix <- xgboost::xgb.DMatrix(data = as.matrix(input_data_numeric))

  model_path <-  system.file("model", "firePredictorModel.xgb", package = "AustraliaFirePredictor")

  loaded_model <- xgboost::xgb.load(model_path)

  predictions <- stats::predict(loaded_model, input_matrix)

  return(predictions)
}

