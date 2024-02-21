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
    format = format_shapefile
  )


)
