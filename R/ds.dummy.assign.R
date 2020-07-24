#'
#' @title Experimental invoker of dummyDS.assign
#' @description Experimental invoker of dummyDS.assign
#' @details Experimental invoker of dummyDS.assign
#' @param outcome, a string, indicating indicated outcome
#' @param newobj a character string that provides the name for the output 
#' object that is stored on the data servers. Default \code{dummy.newobj}.
#' @param datasources a list of objects obtained after login. 
#' @return a result.
#' @author Wheater, Stuart.
#' @export

ds.dummy.assign <- function(outcome, newobj, datasources=NULL) {

    if (is.null(datasources)) {
        datasources <- datashield.connections_find()
    }

    if (is.null(newobj)){
        newobj <- "dummy.newobj"
    }

    cally  <- call('dummyDS.assign', outcome)
    output <- DSI::datashield.assign(datasources, newobj, cally)

    return(output)
}