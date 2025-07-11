#'
#' @title Checks that an object has the same class in all studies
#' @description This is an internal function.
#' @details In DataSHIELD an object included in analysis must be of the same type in all
#' the collaborating studies. If that is not the case the process is stopped
#' @param datasources a list of \code{\link[DSI]{DSConnection-class}} objects obtained after login. If the <datasources>
#' the default set of connections will be used: see \link[DSI]{datashield.connections_default}.
#' @param obj a string character, the name of the object to check for.
#' @keywords internal
#' @return a message or the class of the object if the object has the same class in all studies.
#'
#'
checkClass <- function(datasources=NULL, obj=NULL){
  # check the class of the input object
  cally <- call("classDS", obj)
  classesBy <- DSI::datashield.aggregate(datasources, cally, async = FALSE)
  classes <- unique(unlist(classesBy))
  for (n in names(classesBy)) {
    if (!all(classes == classesBy[[n]])) {
      message("The input data is not of the same class in all studies!")
      message("Use the function 'ds.class' to verify the class of the input object in each study.")
      stop(" End of process!", call.=FALSE)
    }
  }
  return(classes)
}
