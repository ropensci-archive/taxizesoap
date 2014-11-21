#' Retrieve synonyms from various sources given input taxonomic names or identifiers.
#'
#' @param x character; taxons to query.
#' @param db character; database to query. Only \code{worms} for now
#' @param id character; identifiers, returned by \code{\link[taxizesoap]{get_wormsid}}
#' @param ... Other passed arguments.
#'
#' @return A named list of data.frames with the synonyms of every supplied taxa.
#' @note If IDs are supplied directly (not from the \code{get_*} functions) you
#'    must specify the type of ID.
#'
#' @seealso \code{\link[taxizesoap]{get_wormsid}}
#'
#' @export
#' @examples \dontrun{
#' # Plug in taxon names directly
#' synonyms("Salvelinus fontinalis", db='worms')
#'
#' # Use methods for get_wormsid
#' synonyms(get_wormsid("Salvelinus fontinalis"))
#' }

synonyms <- function(...){
  UseMethod("synonyms")
}

#' @method synonyms default
#' @export
#' @rdname synonyms
synonyms.default <- function(x, db = NULL, ...){
  if (is.null(db))
    stop("Must specify Identifier!")

  if (db == 'worms') {
    id <- get_wormsid(x, ...)
    out <- synonyms(id, ...)
    names(out) <- x
  }
  return(out)
}

#' @method synonyms wormsid
#' @export
#' @rdname synonyms
synonyms.wormsid <- function(id, ...)
{
  fun <- function(x){
    if (is.na(x)) {
      out <- NA
    } else {
      out <- worms_synonyms(x, ...)[,c("AphiaID","scientificname","status","rank","valid_AphiaID","valid_name")]
    }
    out
  }
  tmp <- lapply(id, fun)
  names(tmp) <- id
  return(tmp)
#   return( lapply(id, fun) )
}
