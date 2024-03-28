#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param country
#' @param extent
#' @param resolution
#' @return
#' @author njtierney
#' @export
sds_gebco <- function(country_vect,
                      resolution = 1) {

  country_extent <- ext(country_vect)
  gebco_path <- gebco()

  r <- rast(
    x = gebco_path
  )

  template_rast <- rast(
    x = country_extent,
    res = resolution,
    crs = crs(r)
    )


  country_rast <- project(
    x = r,
    y = template_rast,
    by_util = TRUE
    )

  country_rast

}
