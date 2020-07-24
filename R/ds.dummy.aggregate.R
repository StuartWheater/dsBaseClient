#'
#' @title Experimental invoker of dummyDS aggregate
#' @description Experimental invoker of dummyDS.aggregate
#' @details Experimental invoker of dummyDS.aggregate
#' @param outcome, a string, indicating the indicated outcome
#' @param datasources a list of objects obtained after login. 
#' @return a result.
#' @author Wheater, Stuart.
#' @export

ds.dummy.aggregate <- function(outcome, datasources=NULL) {

    if (is.null(datasources)) {
        datasources <- datashield.connections_find()
    }

    cally  <- call('dummyDS.aggregate', outcome)
    output <- DSI::datashield.aggregate(datasources, cally)

    return(output)
}