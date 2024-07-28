
<!-- README.md is generated from README.Rmd. Please edit that file -->

# AustraliaFirePredictor

<!-- badges: start -->
<!-- badges: end -->

The goal of AustraliaFirePredictor is to …

## Installation

You can install the development version of AustraliaFirePredictor from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ishancoderr/AustraliaFirePredictor")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(AustraliaFirePredictor)
## basic example code
```

Data Explanation
Latitude: Center of 1km fire pixel but not necessarily the actual location of the fire as one or more fires can be detected within the 1km pixel.
Longitude: Center of 1km fire pixel but not necessarily the actual location of the fire as one or more fires can be detected within the 1km pixel.
Brightness: Brightness temperature 21 (Kelvin): Channel 21/22 brightness temperature of the fire pixel measured in Kelvin.
Scan: Along Scan pixel size: The algorithm produces 1km fire pixels, but MODIS pixels get bigger toward the edge of scan. Scan and track reflect actual pixel size.
Track: Along Track pixel size: The algorithm produces 1km fire pixels, but MODIS pixels get bigger toward the edge of scan. Scan and track reflect actual pixel size.
Acq_date: Acquisition Date: Date of MODIS acquisition.
Acq_time: Acquisition Time: Time of acquisition/overpass of the satellite (in UTC).
Satellite: Satellite: A = Aqua and T = Terra.
Instrument: Instrument: Constant value for MODIS.
Confidence: Confidence (0-100%): This value is based on a collection of intermediate algorithm quantities used in the detection process. It is intended to help users gauge the quality of individual hotspot/fire pixels. Confidence estimates range between 0 and 100% and are assigned to one of the three fire classes (low-confidence fire, nominal-confidence fire, or high-confidence fire).
Bright_t31: Brightness temperature 31 (Kelvin): Channel 31 brightness temperature of the fire pixel measured in Kelvin.
Frp: Fire Radiative Power: Depicts the pixel-integrated fire radiative power in MW (megawatts).
Daynight: Day / Night: D = Daytime, N = Nighttime.
