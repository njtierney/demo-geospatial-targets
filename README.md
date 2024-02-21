
# demo-geospatial-targets

<!-- badges: start -->
<!-- badges: end -->

This repository has been created to demonstrate some of the issues around
using geospatial data with targets.

In particular, I cannot work out how to implement saving a shapefile in targets.

The recommendations in https://github.com/ropensci/targets/discussions/1238
provided a solution for rasters, but a similar solution, implemented in [format_shapefile]("R/format_shapefile.R") did not seem to work:

```r
format_shapefile <- tar_format(
  read = function(path) terra::vect(path),
  write = function(object, path) {
    terra::writeVector(
      x = object,
      filename = path,
      filetype = "ESRI Shapefile",
      overwrite = TRUE
    )
  },
  marshal = function(object) terra::wrap(object),
  unmarshal = function(object) terra::unwrap(object)
)
```

I got the error:

```r
tar_make(example_shapefile)
```

```
terra 1.7.55
▶ start target example_shapefile
● built target example_shapefile [0.013 seconds]
Error:
! Error running targets::tar_make()
  Error messages: targets::tar_meta(fields = error, complete_only = TRUE)
  Debugging guide: https://books.ropensci.org/targets/debugging.html
  How to ask for help: https://books.ropensci.org/targets/help.html
  Last error: the write() function in tar_format() must not create a directory. Found directories inside the data store where there should only be files: _targets/objects/example_shapefile
```

I also get the same error when I run 

```r
tar_make(example_gadm)
```

```
Loading required package: terra
terra 1.7.55
▶ start target country_codes
● built target country_codes [0.004 seconds]
▶ start target example_gadm
✖ error target example_gadm
Error:
! Error running targets::tar_make()
  Error messages: targets::tar_meta(fields = error, complete_only = TRUE)
  Debugging guide: https://books.ropensci.org/targets/debugging.html
  How to ask for help: https://books.ropensci.org/targets/help.html
  Last error: the write() function in tar_format() must not create a directory. Found directories inside the data store where there should only be files: _targets/objects/example_shapefile
```
