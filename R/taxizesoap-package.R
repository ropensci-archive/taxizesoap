#' Taxnomic search and phylogeny retrieval for SOAP data sources.
#'
#' Currently supported APIs are:
#' \tabular{ll}{
#' World Register of Marine Species (WoRMS) \tab worms_ \cr
#' }
#'
#' @importFrom methods is slot slotNames
#' @importFrom stats na.omit
#' @import plyr data.table httr XML
#' @name taxizesoap-package
#' @aliases taxizesoap
#' @docType package
#' @title Taxnomic search and phylogeny retrieval for SOAP data sources.
#' @keywords package
NULL

#' Stored WoRMS SOAP API interface.
#'
#' An S4 class generated from \code{worms_gen_iface}. You can navigate to each function by doing,
#' for example \code{worms_gen_iface()@@functions$getAphiaID}. Note that there will be some warnings
#' thrown, but it should still work. It is not easy to suppress those warnings as they are printed
#' with \code{cat}. You can dig into each of the below functions, explore
#' the code for each function, explore it's parameters, etc. The functions:
#'
#' \itemize{
#'  \item getAphiaID
#'  \item getAphiaRecords
#'  \item getAphiaNameByID
#'  \item getAphiaRecordByID
#'  \item getAphiaRecordByExtID
#'  \item getExtIDbyAphiaID
#'  \item getAphiaRecordsByNames
#'  \item getAphiaRecordsByVernacular
#'  \item getAphiaRecordsByDate
#'  \item getAphiaClassificationByID
#'  \item getSourcesByAphiaID
#'  \item getAphiaSynonymsByID
#'  \item getAphiaVernacularsByID
#'  \item getAphiaChildrenByID
#'  \item matchAphiaRecordsByNames
#' }
#'
#' The above functions are used internally to make more user friendly function interfaces
#' to WORMS data. See \code{worms_*} for all worms functions.
#'
#' @name worms_iface
#' @docType data
#' @keywords data
NULL

#' Stored PESI SOAP API interface.
#'
#' An S4 class generated from \code{pesi_gen_iface}. You can navigate to each function by doing,
#' for example \code{pesi_gen_iface()@@functions$getGUID}. Note that there will be some warnings
#' thrown, but it should still work. It is not easy to suppress those warnings as they are printed
#' with \code{cat}. You can dig into each of the below functions, explore
#' the code for each function, explore it's parameters, etc. The functions:
#'
#' \itemize{
#'  \item getGUID
#'  \item getPESIRecords
#'  \item getPESINameByGUID
#'  \item getPESIRecordByGUID
#'  \item getPESIRecordsByVernacular
#'  \item getPESIVernacularsByGUID
#'  \item matchTaxon
#'  \item matchTaxa
#'  \item getPESISynonymsByGUID
#'  \item getPESIDistributionsByGUID
#' }
#'
#' The above functions are used internally to make more user friendly function interfaces
#' to PESI data. See \code{pesi_*} for all pesi functions.
#'
#' @name pesi_iface
#' @docType data
#' @keywords data
NULL
