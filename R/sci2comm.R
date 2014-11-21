#' Get common names from scientific names.
#'
#' @export
#' @param scinames character; One or more scientific names or partial names.
#' @param db character; Data source, only \emph{"worms"} for now
#' @param simplify (logical) If TRUE, simplify output to a vector of names. If FALSE,
#'    return variable formats from different sources, usually a data.frame.
#' @param ... Further arguments passed on to functions \code{\link[taxizesoap]{get_wormsid}}.
#' @param id character; identifiers, as returned by \code{\link[taxizesoap]{get_wormsid}}.
#'
#' @return List of character - vectors.
#'
#' @author Scott Chamberlain (myrmecocystus@@gmail.com)
#' @examples \dontrun{
#' sci2comm(scinames='Squatina squatina', db='worms')
#'
#' # Passing id in, works for sources: itis and ncbi
#' sci2comm(get_wormsid('Squatina squatina'))
#'
#' # Don't simplify returned
#' sci2comm(get_tsn('Helianthus annuus'), simplify=FALSE)
#' }
#' @rdname sci2comm
sci2comm <- function(...){
  UseMethod("sci2comm")
}

#' @export
#' @rdname sci2comm
sci2comm.default <- function(scinames, db='worms', simplify=TRUE, ...)
{
  worms2comm <- function(x, simplify, ...){
    wormsids <- get_wormsid(x, ...)
    if(is.na(wormsids)) {
      out <- NA
    } else {
      out <- worms_common(wormsids, ...)
      if(nrow(out) == 0)
        out <- NA
    }
    if(simplify){
      if(!is.data.frame(out)) out else as.character(out$vernacular)
    } else{ out }
  }

  getsci <- function(nn, ...){
    switch(db,
           worms = worms2comm(nn, simplify, ...))
  }
  temp <- lapply(scinames, function(x) getsci(x, ...))
  names(temp) <- scinames
  temp
}

#' @export
#' @rdname sci2comm
sci2comm.wormsid <- function(id, simplify=TRUE, ...){
  worms2comm <- function(id, ...){
    # if tsn is not found
    if(is.na(id)) {
      out <- NA
    } else {
      out <- worms_common(id)
      if(length(out) == 0)
        out <- NA
    }
    if(simplify){
      as.character(out$vernacular)
    } else{ out }
  }
  out <- lapply(id, function(x) worms2comm(x))
  names(out) <- id
  return(out)
}
