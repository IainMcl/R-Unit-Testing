# Adaptation of example code from https://towardsdatascience.com/unit-testing-in-r-68ab9cc8d211

#' Increment
#'
#' Takes in a variable value and increments it by 1.
#'
#' @param value This could be anything when passes. Lets check that the desired output
#'     is recieved for a range of input types.
#' @export
increment <- function(value){
  return(value + 1)
}
