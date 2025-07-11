#'
#' @title Performs direct call to a server-side aggregate function
#' @description The function \code{ds.look} can be used to make a direct call to a server-side
#' aggregate function more simply than using the \code{datashield.aggregate} function. 
#' @details The \code{ds.look} and \code{datashield.aggregate} functions are generally
#' only recommended for experienced developers. For example, the \code{toAggregate} argument has to
#' be expressed in the same form that the server-side function would usually expect from its
#' client-side pair. For example: \code{ds.look("table1DDS(female)")} works. But, if you express
#' this as \code{ds.look("table1DDS('female')")} it won't work because although when
#' you call this same function using its client-side function you write \code{ds.table1D('female')}
#' the inverted commas are stripped off during processing by the client-side function so the
#' call to the server-side does not contain inverted commas. 
#' 
#' Apart from during development
#' work (e.g. before a client-side function has been written) it is almost always easier
#' and less error-prone to call a server-side function using its client-side pair.
#' 
#' The function is a wrapper for the DSI package function \code{datashield.aggregate}.
#' @param toAggregate a character string specifying the function call to be made.
#' For more information see \strong{Details}. 
#' @param checks logical. If TRUE the optional checks are undertaken. 
#' Default FALSE to save time. 
#' @param datasources a list of \code{\link[DSI]{DSConnection-class}} 
#' objects obtained after login. If the \code{datasources} argument is not specified
#' the default set of connections will be used: see \code{\link[DSI]{datashield.connections_default}}.
#' @return the output from the specified server-side aggregate function to the client-side.
#' @author DataSHIELD Development Team
#' 
#' @examples
#' \dontrun{
#' 
#'   ## Version 6, for version 5 see the Wiki
#'   
#'   # connecting to the Opal servers
#' 
#'   require('DSI')
#'   require('DSOpal')
#'   require('dsBaseClient')
#'
#'   builder <- DSI::newDSLoginBuilder()
#'   builder$append(server = "study1", 
#'                  url = "http://192.168.56.100:8080/", 
#'                  user = "administrator", password = "datashield_test&", 
#'                  table = "SURVIVAL.EXPAND_NO_MISSING1", driver = "OpalDriver")
#'   builder$append(server = "study2", 
#'                  url = "http://192.168.56.100:8080/", 
#'                  user = "administrator", password = "datashield_test&", 
#'                  table = "SURVIVAL.EXPAND_NO_MISSING2", driver = "OpalDriver")
#'   builder$append(server = "study3",
#'                  url = "http://192.168.56.100:8080/", 
#'                  user = "administrator", password = "datashield_test&", 
#'                  table = "SURVIVAL.EXPAND_NO_MISSING3", driver = "OpalDriver")
#'   logindata <- builder$build()
#'   
#'   connections <- DSI::datashield.login(logins = logindata, assign = TRUE, symbol = "D")
#'   
#'   #Calculate the length of a variable using the server-side function
#'   
#'   ds.look(toAggregate = "lengthDS(D$age.60)", 
#'           checks = FALSE,
#'           datasources = connections) 
#'           
#'   #Calculate the column names of "D" object using the server-side function
#'           
#'   ds.look(toAggregate = "colnames(D)",
#'           checks = FALSE, 
#'           datasources = connections)        
#'   
#'   # clear the Datashield R sessions and logout
#'   datashield.logout(connections)
#' }
#' @export
#' 
ds.look<-function(toAggregate=NULL, checks=FALSE, datasources=NULL){
  .Deprecated()

###################################################################################################################
#MODULE 1: IDENTIFY DEFAULT DS CONNECTIONS  													                                            #
  # look for DS connections                                                                                       #
  if(is.null(datasources)){															                                                          #
    datasources <- datashield.connections_find()												                                          #
  }																					                                                                      #
                                                                                                                  #
  # ensure datasources is a list of DSConnection-class																			                      #
  if(!(is.list(datasources) && all(unlist(lapply(datasources, function(d) {methods::is(d,"DSConnection")}))))){   #
    stop("The 'datasources' were expected to be a list of DSConnection-class objects", call.=FALSE)               #
  }																					                                                                      #
###################################################################################################################

###########################################################################################
#MODULE 3: OPTIONAL CHECKS FOR KEY DATA OBJECTS                                           #
#IN DIFFERENT SOURCES                                                                     #
if(checks==TRUE){                                                                         #
  if(is.null(toAggregate)){                                                               #
    stop("<toAggregate> missing, please give an expression/function in inverted commas\n",#
	call.=FALSE)                                                                            #
  }                                                                                       #
}                                                                                         #
###########################################################################################


  # now do the business
  output<-DSI::datashield.aggregate(datasources, as.symbol(toAggregate))
  return(list(output=output))
  }

#ds.look
