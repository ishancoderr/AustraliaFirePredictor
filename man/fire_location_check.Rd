% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fire_location_check.R
\name{fire_location_check}
\alias{fire_location_check}
\title{Fire Location Check}
\usage{
fire_location_check(file_path, output_model_path = NULL)
}
\arguments{
\item{file_path}{A string indicating the path to the CSV file containing the fire data.}

\item{output_model_path}{Optional; A string indicating the path to save the trained model. If NULL, the model is not saved.}
}
\value{
A list containing the trained model and evaluation metrics.
}
\description{
This function reads fire data from a CSV file, preprocesses it, and performs fire prediction.
}
