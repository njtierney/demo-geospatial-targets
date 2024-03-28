## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

tar_plan(

  tar_terra_rast(
    example_rast,
    get_example_rast(),
  ),

  tar_terra_vect(
    example_shapefile,
    get_example_shapefile()
  ),

  country_codes = country_codes(query = "Australia"),

  tar_terra_vect(
    example_gadm,
    get_gadm_country(country_codes$ISO3)
  ),

  tar_terra_vect(
    example_gadm_multiple,
    get_gadm_country(c("Australia", "New Zealand"))
  ),

  # alternative approach to using gadm for boundaries
  tar_terra_vect(
    example_cgaz_country,
    cgaz_country("Australia")
  ),

  tar_terra_vect(
    example_cgaz_countries,
    cgaz_country(c("Australia", "New Zealand"))
  ),

  # example of using the spatvector from one target into another
  tar_terra_rast(
    example_sds_raster_oz,
    sds_gebco(country_vect = example_cgaz_country,
              resolution = 1)
  )

  # TODO
  # add China and Japan

)
