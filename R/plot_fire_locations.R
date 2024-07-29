# R/plot_fire_locations.R

# Declare global variable to avoid check note
utils::globalVariables(c("geometry", "brightness", "acq_date"))

#' Plot Fire Locations
#'
#' This function reads fire data from a CSV file and plots fire locations on a map.
#' @return A ggplot object.
#' @import ggplot2
#' @importFrom sf st_as_sf
#' @export
plot_fire_locations <- function() {
  file_path <- system.file("extdata", "fire_data.csv", package = "AustraliaFirePredictor")

  data <- utils::read.csv(file_path)

  data <- sf::st_as_sf(data, coords = c("longitude", "latitude"), crs = 4326)

  data$acq_date <- as.Date(data$acq_date)

  p <- ggplot2::ggplot(data) +
    ggplot2::geom_sf(ggplot2::aes(geometry = geometry, color = brightness)) +
    ggplot2::scale_color_gradient(low = "yellow", high = "red", name = "Brightness") +
    ggplot2::labs(
      title = "Australian Fires: From 2019/10/01 to 2020/01/11",
      x = "Longitude",
      y = "Latitude"
    ) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 18, color = "FireBrick", hjust = 0.5)
    )

  return(p)
}
