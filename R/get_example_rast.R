#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @return
#' @author njtierney
#' @export
get_example_rast <- function() {

  # Create a SpatRaster from scratch
  x <- rast(nrows=108, ncols=21, xmin=0, xmax=10)

  # Create a SpatRaster from a file
  f <- system.file("ex/elev.tif", package="terra")
  r <- rast(f)
  r

}
