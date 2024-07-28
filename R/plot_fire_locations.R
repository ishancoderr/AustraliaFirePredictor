# R/plot_fire_locations.R

# Declare global variable to avoid check note
utils::globalVariables("geometry")

#' Plot Fire Locations
#'
#' This function reads fire data from a CSV file and plots fire locations on a map.
#' @return A ggplot object.
#' @import ggplot2
#' @importFrom sf st_as_sf
#' @export
plot_fire_locations <- function() {
  # Read the fire data
  file_path <- system.file("extdata", "fire_data.csv", package = "AustraliaFirePredictor")
  data <- utils::read.csv(file_path)

  # Convert the data to an sf object
  data <- sf::st_as_sf(data, coords = c("longitude", "latitude"), crs = 4326)

  # Plot the fire locations
  ggplot2::ggplot(data) +
    ggplot2::geom_sf(ggplot2::aes(geometry = geometry)) +
    ggplot2::labs(title = "Fire Locations")
}
