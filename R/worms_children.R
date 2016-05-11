#' Children search of WoRMS data
#'
#' @export
#' @template worms_id
#' @param offset Starting record number, when retrieving next chunk of (50) records. Default=1.
#' @param marine_only (logical) Include results from marine taxa only. Default: TRUE.
#' @return A list of data.frame's, named by the input Aphia ids
#' @examples \dontrun{
#' worms_children(ids=106135)
#' worms_children(ids=c(106135,159283))
#' out <- worms_children(ids=c(106135,159283))
#' lapply(out, head)
#'
#' # to bind outputs together from multiple taxa
#' do.call(rbind, out)
#' ## or with plyr::rbind.fill
#' do.call(rbind.fill, out)
#' }
worms_children <- function(ids=NULL, offset=NULL, marine_only=1, opts=NULL, iface=NULL, ...) {
  server <- 'http://www.marinespecies.org/aphia.php?p=soap'
  if (!is.null(iface)) worms_iface <- iface
  fxn <- worms_get_fxn('getAphiaChildrenByID')
  res <- lapply(ids, fxn, offset = offset, marine_only = marine_only,
                server = server, .opts = opts, .convert = FALSE)
  setNames(Map(worms_parse_xml, res, aphiaid = ids), ids)
}
