format_geoparquet <- tar_format(
  read = function(path) {
    arrow::read_parquet(path) |>
      dplyr::mutate(dplyr::across(wk::is_handleable, wk::as_wkb))
  },
  write = function(object, path) {
    arrow::write_parquet(object, path)
  },
  marshal = function(object) {
    arrow::as_arrow_table(object)
  },
  unmarshal = function(object) {
    as.data.frame(object) |>
      dplyr::mutate(dplyr::across(wk::is_handleable, wk::as_wkb))
  }
)
