#' htmlwidget for d3.js zoomable circle packing visualizations
#' #NOTICE: When running this program you might have to click "Show in new window" for it to print to the screen
#' \href{http://bl.ocks.org/mbostock/7607535}{Circle packing visualizations} provide
#' an interactive way of exploring hierarchical data that contains elements of different
#' sizes or magnitudes
#'
#' @param data data in the form of a hierarchical list or a nested d3 JSON hierarchy
#' @param size string representing the name of the size variable.\code{"size"} is the default. 
#' @param size string is what determines the size of the circle        
#' @param color_min string representing the minimum value of the color range for the
#'          circles. The string can be either a hexadecimal, RGB, or HSL color.
#'          \code{"hsl(152,80\%,80\%)"} is the default.
#' @param color_max string representing the maximum value of the color range for the
#'          circles. The string can be either a hexadecimal, RGB, or HSL color.
#'          \code{"hsl(228,30\%,40\%)"} is the default.
#' @param color_col string representing the name of the color column variable.  \code{"NULL"} is the default
#' @param tooltip boolean on whether to display tooltip for each node.  \code{"TRUE"} is the default.
#' @param tooltip_cols list of node property names to display in the tooltip. The default is to display all properties.
#' @param quartile_values list of the four quartile values to use as separate colors.
#' @param quartile_colors list of the four colors to use for the quartile values. Those are 0-25%, 25-50%, 50-75% and 75-100%.
#' @param id_col string representing the name fo the unique identifier column variable \code{"id_col"} is the default
#'
#' @example ./inst/examples/example.R
#'
#' @import htmlwidgets
#'
#' @export
circlepackeR <- function(data, size = "size", color_min = "hsl(152,80%,80%)",
                         color_max = "hsl(228,30%,40%)", width = NULL, height = NULL, color_col = NULL, tooltip = TRUE, tooltip_cols = NULL, quartile_values = NULL, quartile_colors = NULL, id_col="id_col") {


  # accept JSON
  if (inherits(data, c("character", "connection", "json"))) {
    data = jsonlite::toJSON(
      jsonlite::fromJSON(data),
      auto_unbox = TRUE,
      dataframe = "rows"
    )

  } else if (inherits(data, "list")) {  # accept hierarchical list
    data = jsonlite::toJSON(data, auto_unbox = TRUE)

  } else if (inherits(data, "Node")) { # accept data.tree
    if (!requireNamespace("data.tree")) stop("please install data.tree.", call. = FALSE)
    data = as.list(data, mode = "explicit", unname = TRUE)
    data = jsonlite::toJSON(data, auto_unbox = TRUE)

  } else {
    stop("Please provide a json object or list", call. = FALSE)
  }

  # create a list that contains the data
  x = list(
    data = data,
    options = list(
      size = size,
      color_min = color_min,
      color_max = color_max,
      color_col = color_col,
      id_col = id_col,
      quartile_colors = quartile_colors,
      quartile_values = quartile_values,
      tooltip_cols = tooltip_cols,
      tooltip = tooltip
    )
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'circlepackeR',
    x,
    width = width,
    height = height,
    package = 'circlepackeR'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
circlepackeROutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'circlepackeR', width, height, package = 'circlepackeR')
}

#' Widget render function for use in Shiny
#'
#' @export
renderCirclepackeR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, circlepackeROutput, env, quoted = TRUE)
}
