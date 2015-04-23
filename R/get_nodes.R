#' Get node ID information from node data frames
#'
#' Provides information on the node IDs from one or several node data frames.
#'
#' @param nodes_df a data frame containing, at minimum, a column that contains node IDs for the graph. Optionally, additional columns (named as Graphviz node attributes) can be included with values for the named node attribute. These data frames can be conveniently generated using the 'create_nodes' function.
#' @export get_nodes

get_nodes <- function(...){

  nodes <- list(...)

  for (i in 1:length(nodes)){

    if (i == 1) node_ID <- vector(mode = "character")

    nodes_df <- nodes[[i]]

    # Determine which column contains node ID information
    if ("node" %in% colnames(nodes_df)){
      nodes_column <- which("node" %in% colnames(nodes_df))
    } else if ("nodes" %in% colnames(nodes_df)){
      nodes_column <- which("nodes" %in% colnames(nodes_df))
    } else if ("node_id" %in% colnames(nodes_df)){
      nodes_column <- which("node_id" %in% colnames(nodes_df))
    } else {
      stop("There is no column with node ID information.")
    }

    node_ID <- c(node_ID, nodes_df[,nodes_column])
  }

  all_ID_unique <- ifelse(anyDuplicated(node_ID) == 0, TRUE, FALSE)

  if (all_ID_unique == TRUE){
    return(node_ID)
  }

}