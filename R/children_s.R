#' Retrieve immediate children taxa for a given taxon name or ID.
#'
#' @export
#' @param x character; taxons to query.
#' @param db character; database to query. Only \code{worms} for now.
#' @param ... Further args passed on to \code{worms_children}.
#' @return A named list of data.frames with the children names of every supplied taxa.
#' You get an NA if there was no match in the database.
#' @examples \dontrun{
#' children_s("Aatolana", db = 'worms')
#' }

children_s <- function(...){
  UseMethod("children_s")
}

#' @export
#' @rdname children_s
children_s.default <- function(x, db = NULL, ...)
{
  if (is.null(db))
    stop("Must specify db value!")

  if (db == 'worms') {
    id <- get_wormsid(x, ...)
    out <- children_s(id, ...)
  }
  names(out) <- x
  return(out)
}

#' @export
#' @rdname children_s
children_s.wormsid <- function(x,  db = NULL, ...) {
  fun <- function(y){
    # return NA if NA is supplied
    if(is.na(y)){
      out <- NA
    } else {
      out <- worms_children(ids = y, ...)
      out <- out[,c("AphiaID","scientificname","rank","status","valid_AphiaID","valid_name","kingdom","phylum","class","order","family","genus")]
    }
    return(out)
  }
  out <- lapply(x, fun)
  class(out) <- 'children_s'
  attr(out, 'db') <- 'worms'
  return(out)
}
