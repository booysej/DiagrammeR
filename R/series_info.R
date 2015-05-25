#' Get detailed information on a graph series
#' Obtain a data frame with detailed information on the graphs within a graph series.
#' @param graph_series a graph series object of type \code{dgr_graph_1D}.
#' @return a data frame containing information on the graphs within the supplied graph series.
#' @export series_info

series_info <- function(graph_series){

  graphs_in_series <- graph_count(graph_series)

  series_properties <-
    as.data.frame(mat.or.vec(nr = graphs_in_series, nc = 7))
  colnames(series_properties) <-
    c("graph", "name", "date_time", "tz", "nodes", "edges", "directed")

  if (graphs_in_series == 0){

    return(series_properties)
  }

  for (i in 1:graphs_in_series){

    series_properties[i, 1] <- i

    series_properties[i, 2] <-
      graph_series$graphs[[i]]$graph_name

    series_properties[i, 3] <-
      graph_series$graphs[[i]]$graph_time

    series_properties[i, 4] <-
      graph_series$graphs[[i]]$graph_tz

    series_properties[i, 5] <- node_count(graph_series$graphs[[i]])

    series_properties[i, 6] <- edge_count(graph_series$graphs[[i]])

    series_properties[i, 7] <- is_graph_directed(graph_series$graphs[[i]])
  }

  return(series_properties)
}