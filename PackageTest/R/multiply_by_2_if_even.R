#' multiply by 2 if even
#'
#' Takes in a value and multiplys it by 2 if the value is even.
#'
#' To check test coverage.
#' If only one of the return values is covered by a test then this will be
#' shown when looking at the `covr` report.
#' In RStudio you can view the `cover` report by calling `report()`.
#'
#' @param value value to be multiplied by 2 if even
#' @export
multiply_by_2_if_even <- function(value){
  if(value %% 2 == 0){
    return(value * 2)
  }else{
    return(value)
  }
}
