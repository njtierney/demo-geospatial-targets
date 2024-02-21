#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @return
#' @author njtierney
#' @export
get_example_shapefile <- function() {

  f <- system.file("ex/lux.shp", package="terra")
  v <- vect(f)
  v

}
