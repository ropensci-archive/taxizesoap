#' Retrieve the taxonomic hierarchy for a given taxon ID.
#'
#' @import XML RCurl plyr
#' @export
#'
#' @param x character; taxons to query.
#' @param db character; database to query. Only \code{worms} for now.
#' @param id character; identifiers, returned by \code{\link[taxizesoap]{get_wormsid}}.
#' @param callopts Curl options passed on to \code{\link[httr]{GET}}
#' @param ... Other arguments passed to \code{\link[taxizesoap]{get_wormsid}}
#'
#' @return A named list of data.frames with the taxonomic classifcation of
#'    every supplied taxa.
#' @note If IDs are supplied directly (not from the \code{get_*} functions) you
#'    must specify the type of ID. There is a timeout of 1/3 seconds between
#'    querries to NCBI.
#'
#' @seealso \code{\link[taxizesoap]{get_wormsid}}
#'
#' @examples \dontrun{
#' classification_s(x="Salvelinus fontinalis", db = 'worms')
#' classification_s(get_wormsid("Salvelinus fontinalis"))
#' }
classification_s <- function(...){
  UseMethod("classification_s")
}

#' @export
#' @rdname classification_s
classification_s.default <- function(x, db = NULL, callopts=list(), ...){
  if (is.null(db))
    stop("Must specify db!")

  if (db == 'worms') {
    id <- process_ids(x, get_wormsid, ...)
    out <- classification_s(id, callopts=callopts, ...)
    names(out) <- x
  }
  return(out)
}

#' @export
#' @rdname classification_s
classification_s.wormsid <- function(id, callopts = list(), ...) {
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
  class(out) <- 'classification_s'
  return(out)
}

process_ids <- function(input, fxn, ...){
  g <- tryCatch(as.numeric(as.character(input)), warning=function(e) e)
  if(is(g,"numeric")){
    id <- input
    class(id) <- "tsn"
  } else {
    id <- eval(fxn)(input, ...)
  }
  id
}
