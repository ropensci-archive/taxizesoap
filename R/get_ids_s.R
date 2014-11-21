#' Retrieve taxonomic identifiers for a given taxon name.
#'
#' This is a convenience function to get identifiers across all data sources. You can
#' use other \code{get_*} functions to get identifiers from specific sources if
#' you like.
#'
#' @export
#' @param names character; Taxonomic name to query.
#' @param db character; database to query. One or  more of \code{worms} or \code{pesi}. By
#'    default db is set to search all data sources.
#' @param ... Other arguments passed to \code{\link[taxize]{get_wormsid}},
#'    \code{\link[taxize]{get_pesiid}}.
#' @return A vector of taxonomic identifiers, each retaining their respective S3
#'    classes so that each element can be passed on to another function (see e.g.'s).
#' @note There is a timeout of 1/3 seconds between queries to NCBI.
#' @seealso \code{\link[taxize]{get_wormsid}}, \code{\link[taxize]{get_pesiid}}
#' @examples \dontrun{
#' # Plug in taxon names directly
#' ## By default you get ids for all data sources
#' get_ids_s(names="Chironomus riparius")
#'
#' ## Or you can specify which source you want via the db parameter
#' get_ids_s(names="Salvelinus fontinalis", db = 'worms')
#' }

get_ids_s <- function(names, db = c('worms','pesi'), ...)
{
  if(is.null(db))
    stop("Must specify on or more values for db!")
  db <- match.arg(db, choices = c('worms','pesi'), several.ok = TRUE)

  foo <- function(x, names, ...){
    ids <- switch(x,
                  worms = get_wormsid(names, ...),
                  pesi = get_pesiid(names, ...))
    names(ids) <- names
    return( ids )
  }

  tmp <- lapply(db, function(x) foo(x, names=names, ...))
  names(tmp) <- db
  class(tmp) <- "ids"
  return( tmp )
}
