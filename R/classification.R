#' Retrieve the taxonomic hierarchy for a given taxon ID.
#'
#' @import XML RCurl plyr
#' @export
#'
#' @param x character; taxons to query.
#' @param db character; database to query. Only \code{worms} for now.
#' @param id character; identifiers, returned by \code{\link[taxize]{get_wormsid}}.
#' @param callopts Curl options passed on to \code{\link[httr]{GET}}
#' @param ... Other arguments passed to \code{\link[taxize]{get_wormsid}}
#' @param start The first record to return. If omitted, the results are returned
#'   	from the first record (start=0). This is useful if the total number of
#' 		results is larger than the maximum number of results returned by a single
#' 		Web service query (currently the maximum number of results returned by a
#' 		single query is 500 for terse queries and 50 for full queries).
#' @param checklist character; The year of the checklist to query, if you want a specific
#' 		year's checklist instead of the lastest as default (numeric).
#' @param key Your API key; loads from .Rprofile.
#'
#' @return A named list of data.frames with the taxonomic classifcation of
#'    every supplied taxa.
#' @note If IDs are supplied directly (not from the \code{get_*} functions) you
#'    must specify the type of ID. There is a timeout of 1/3 seconds between
#'    querries to NCBI.
#'
#' @seealso \code{\link[taxize]{get_wormsid}}
#'
#' @examples \dontrun{
#' classification(x="Salvelinus fontinalis", db = 'worms')
#' classification(get_wormsid("Salvelinus fontinalis"))
#' }
classification <- function(...){
  UseMethod("classification")
}

#' @export
#' @rdname classification
classification.default <- function(x, db = NULL, callopts=list(), ...){
  if (is.null(db))
    stop("Must specify db!")

  if (db == 'worms') {
    id <- process_ids(x, get_wormsid, ...)
    out <- classification(id, callopts=callopts, ...)
    names(out) <- x
  }
  return(out)
}

#' @export
#' @rdname classification
classification.wormsid <- function(id, callopts = list(), ...) {
  fun <- function(x){
    if(is.na(x)) {
      out <- NA
    } else {
      out <- worms_hierarchy(x, ...)
      out <- data.frame(name=out$scientificname, rank=out$rank)
    }
    return(out)
  }
  out <- lapply(id, fun)
  names(out) <- id
  class(out) <- 'classification'
  return(out)
}
