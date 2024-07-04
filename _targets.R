## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

my_controller <- crew::crew_controller_local(
  name = "bananas",
  workers = 3
)
tar_option_set(
  controller = my_controller
)

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
  ),

  ## demonstration using many countries and multiple workers
  tar_target(
    some_countries,
    countrycode::codelist$iso3c[1:6]
  ),

  tar_terra_vect(
    country_shapes,
    cgaz_country(some_countries),
    pattern = map(some_countries)
  ),

  tar_target(
    my_file,
    system.file("ex/elev.tif", package="terra"),
    format = "file"
  ),
  tar_terra_rast(
    my_map,
    terra::rast(my_file)
  ),
  tar_terra_tiles(
    name = rast_split,
    raster = my_map,
    ncol = 2,
    nrow = 2
  )

  # TODO
  # add China and Japan

)
