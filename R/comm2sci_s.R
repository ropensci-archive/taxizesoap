#' Get scientific names from common names.
#'
#' @param commnames One or more common names or partial names.
#' @param db Data source, only \emph{"worms"} for now
#' @param itisby Search for common names across entire names (search, default),
#'    at beginning of names (begin), or at end of names (end).
#' @param simplify (logical) If TRUE, simplify output to a vector of names. If FALSE,
#'    return variable formats from different sources, usually a data.frame.
#' @param ... Further arguments passed on to internal methods.
#' @return A vector of names.
#' @seealso \code{\link[taxizesoap]{worms_records}}
#' @export
#' @seealso \code{\link[taxizesoap]{sci2comm}}
#' @author Scott Chamberlain (myrmecocystus@@gmail.com)
#' @examples \dontrun{
#' comm2sci_s(commnames=c('atlantic salmon','great white shark'), db='worms')
#' }

comm2sci_s <- function(commnames, db='worms', simplify=TRUE, ...)
{
  worms2sci <- function(simplify, ...){
    tmp <- worms_records(...)
    if(simplify){
      as.character(tmp$scientificname)
    } else{ tmp }
  }

  getsci <- function(nn, ...){
    switch(db,
           worms = worms2sci(common=nn, simplify))
  }
  temp <- lapply(commnames, function(x) getsci(x, ...))
  names(temp) <- commnames
  temp
}
