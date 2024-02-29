## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

  tar_target(
    example_rast,
    get_example_rast(),
    format = format_geotiff
  ),

  tar_target(
    example_shapefile,
    get_example_shapefile(),
    format = format_geoparquet
  ),

  country_codes = country_codes(query = "Australia"),

  tar_target(
    example_gadm,
    get_gadm_country(country_codes$ISO3),
    format = format_shapefile
  )

)
