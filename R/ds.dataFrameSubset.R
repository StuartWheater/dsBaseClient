#' @title Subsetting data frames in the server-side
#'
#' @description Subsets a data frame by rows, columns or both. 
#'
#' @details \code{ds.dataFrameSubset} subsets a
#' pre-existing data frame by specifying the values of a subsetting variable
#' (subsetting by row) or by selecting columns to keep or remove (subsetting
#' by column). 
#' 
#' When subsetting by row, the resultant subset must strictly be
#' as large or larger than the disclosure trap value \code{nfilter.subset}. 
#' 
#' If you wish to keep all rows (see \strong{Example 2}) in the subset 
#' (e.g. if the primary plan is to subset by column not by row) then 
#' \code{V1.name} can be used to specify a vector of the same length
#' as the data frame to be subsetted in each study which consists entirely of 1s
#' and there are no NAs. Then if \code{V2.name} encodes the value 1 and the
#' \code{Boolean.operator = "=="} then ALL rows will be kept in the generated subset.
#' To achieve this you can easily generate your vector of 1s and declare that
#' vector as \code{V1.name}, then specify \code{V2.name = "1"} and 
#' \code{Boolean.operator = '=='}.
#' 
#' But, as a simpler alternative if either \code{keep.cols} or \code{rm.cols}
#' is non-null i.e. you are deliberately subsetting by column, 
#' if you declare \code{V1.name}, \code{V2.name}
#' and \code{Boolean.operator} all to be NULL, then the \code{ds.dataFrameSubset} function will
#' create an internal vector of 1s called \code{'ONES'} which is equal in length to
#' to the number of rows in the data frame in each source, will set both
#' \code{V1.name} and \code{V2.name} to \code{'ONES'}, and \code{Boolean.operator = "=="}. 
#' This then has precisely the same effect.
#' 
#' In the \code{datasources} parameter, if you have several data sets in the sources 
#' you are working with called \code{opals.a}, \code{opals.w2}, and \code{connection.xyz}, 
#' you can choose which of these to work with. 
#' 
#' The call \code{datashield.connections_find()} lists all of
#' the different datasets available and if one of these is called \code{default.connections}
#' that will be the dataset used by default if no other dataset is specified. If you
#' wish to change the connections you wish to use by default the call
#' \code{datashield.connections_default('opals.a')} will set \code{'default.connections'}
#' to be 'opals.a' and so in the absence of specific instructions to the contrary
#' (e.g. by specifying a particular dataset to be used via the <datasources>
#' argument) all subsequent function calls will be to the datasets held in \code{opals.a}.
#' If the \code{datasources} argument is specified, it should be set without
#' inverted commas: e.g. \code{datasources = opals.a} or 
#' \code{datasources = default.connections}.
#' 
#' The \code{datasources} argument also allows you to apply a function solely to a subset
#' of the studies/sources you are working with. For example, the second source
#' in a set of three, can be specified using a call such as \code{datasources = connection.xyz[2]}.
#' On the other hand, if you wish to specify solely the first and third sources, the
#' appropriate call will be \code{datasources = connections.xyz[c(1,3)]}.
#' 
#' Aggregate server functions called: \code{dataFrameSubsetDS1} and \code{dataFrameSubsetDS2}
#'
#' @param df.name a character string providing the name of the data frame to be subsetted.
#' @param V1.name A character string specifying the name of the vector 
#' to which the Boolean operator is to be applied to define the subset.
#' For more information see \strong{Details}. 
#' @param V2.name A character string specifying the name of the vector 
#' or scalar value to compare with \code{V1.name}.
#' @param Boolean.operator A character string specifying one of six possible Boolean operators:
#' \code{'==', '!=', '>', '>=', '<'} and \code{'<='}.
#' @param keep.cols a numeric vector specifying the numbers of the columns to be kept in the
#' final subset.
#' @param rm.cols a numeric vector specifying the numbers of the columns to be removed from 
#' the final subset.
#' @param keep.NAs logical, if TRUE the missing values are included in the subset. 
#' If FALSE or NULL all rows with at least one missing values are removed from the subset. 
#' @param newobj a character string that provides the name for the output 
#' object that is stored on the data servers. Default \code{dataframesubset.newobj}.
#' @param datasources a list of \code{\link{DSConnection-class}} objects obtained after login.
#' If the \code{datasources}
#' the default set of connections will be used: see \code{\link{datashield.connections_default}}.
#' For more see \strong{Details}.
#' @param notify.of.progress specifies if console output should be produced to indicate
#' progress. Default FALSE.
#' @return \code{ds.dataFrameSubset} returns 
#' the object specified by the \code{newobj} argument 
#' (or default name \code{dataframesubset.newobj})
#' which is written to the server-side. 
#' 
#' In addition, two validity messages are returned
#' indicating whether \code{newobj} has been created in each data source and if so whether
#' it is in a valid form. If its form is not valid in at least one study - e.g. because
#' a disclosure trap was tripped and creation of the full output object was blocked -
#' \code{ds.dataFrameSubset()} returns helpful error messages which are generated by
#' the first call to the serverside aggregate function \code{dataFrameSubsetDS1}.
#' 
#' @examples
#' \dontrun{
#' 
#'  ## Version 6, for version 5 see the Wiki
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
#'                  table = "CNSIM.CNSIM1", driver = "OpalDriver")
#'   builder$append(server = "study2", 
#'                  url = "http://192.168.56.100:8080/", 
#'                  user = "administrator", password = "datashield_test&", 
#'                  table = "CNSIM.CNSIM2", driver = "OpalDriver")
#'   builder$append(server = "study3",
#'                  url = "http://192.168.56.100:8080/", 
#'                  user = "administrator", password = "datashield_test&", 
#'                  table = "CNSIM.CNSIM3", driver = "OpalDriver")
#'   logindata <- builder$build()
#'   
#'   connections <- DSI::datashield.login(logins = logindata, assign = TRUE, symbol = "D") 
#'   
#'   # Subsetting a data frame
#'   #Example 1: Include some rows and all columns in the subset
#'   ds.dataFrameSubset(df.name = "D",
#'                      V1.name = "D$LAB_TSC",
#'                      V2.name = "D$LAB_TRIG",
#'                      Boolean.operator = ">",
#'                      keep.cols = NULL, #All columns are included in the new subset
#'                      rm.cols = NULL, #All columns are included in the new subset
#'                      keep.NAs = FALSE, #All rows with NAs are removed
#'                      newobj = "new.subset",
#'                      datasources = connections[1],#only the first server is used ("study1")
#'                      notify.of.progress = FALSE)
#'   
#'   #Example 2: Include all rows and some columns in the new subset
#'     #Select complete cases (rows without NA)
#'     ds.completeCases(x1 = "D",
#'                      newobj = "complet",
#'                      datasources = connections)
#'     #Create a vector with all ones
#'     ds.make(toAssign = "complet$LAB_TSC-complet$LAB_TSC+1",
#'             newobj = "ONES",
#'             datasources = connections) 
#'     #Subset the data
#'     ds.dataFrameSubset(df.name = "complet",
#'                        V1.name = "ONES",
#'                        V2.name = "ONES",
#'                        Boolean.operator = "==",
#'                        keep.cols = c(1:4,10), #only columns 1, 2, 3, 4 and 10 are selected
#'                        rm.cols = NULL,
#'                        keep.NAs = FALSE,
#'                        newobj = "subset.all.rows",
#'                        datasources = connections, #all servers are used
#'                        notify.of.progress = FALSE)                
#'                      
#'   # Clear the Datashield R sessions and logout                 
#'   datashield.logout(connections) 
#'
#' }
#' @author Paul Burton
#' @export

ds.dataFrameSubset<-function(df.name=NULL, V1.name=NULL, V2.name=NULL, Boolean.operator=NULL, keep.cols=NULL, rm.cols=NULL, keep.NAs=NULL, newobj=NULL, datasources=NULL, notify.of.progress=FALSE){
  
  # look for DS connections
  if(is.null(datasources)){
    datasources <- datashield.connections_find()
  }
  
  # check if user has provided the name of the data.frame to be subsetted
  if(is.null(df.name)){
    stop("Please provide the name of the data.frame to be subsetted as a character string: eg 'xxx'", call.=FALSE)
  }
  
  # check if user has provided the name of the column or scalar that holds V1
  if(is.null(V1.name)){
    stop("Please provide the name of the column or scalar that holds V1 as a character string: eg 'xxx' or '3'", call.=FALSE)
  }
  
  # check if user has provided the name of the column or scalar that holds V2
  if(is.null(V2.name)){
    stop("Please provide the name of the column or scalar that holds V2 as a character string: eg 'xxx' or '3'", call.=FALSE)
  }
  
  # check if user has provided a Boolean operator in character format: eg '==' or '>=' or '<' or '!='
  if(is.null(Boolean.operator)){
    stop("Please provide a Boolean operator in character format: eg '==' or '>=' or '<' or '!='", call.=FALSE)
  }
  
  #if keep.NAs is set as NULL convert to FALSE as otherwise the call to datashield.assign will fail
  if(is.null(keep.NAs)){
    keep.NAs<-FALSE
  }
  
  #convert Boolean operator to numeric
  
  BO.n<-0
  if(Boolean.operator == "=="){
    BO.n<-1
  }
  
  if(Boolean.operator == "!="){
    BO.n<-2
  }
  
  if(Boolean.operator == "<"){
    BO.n<-3
  }
  
  if(Boolean.operator == "<="){
    BO.n<-4
  }
  
  if(Boolean.operator == ">"){
    BO.n<-5
  }
  
  if(Boolean.operator == ">="){
    BO.n<-6
  }
  
  # if no value spcified for output object, then specify a default
  if(is.null(newobj)){
    newobj <- "dataframesubset.newobj"
  }
  
  if(!is.null(keep.cols)){
    keep.cols<-paste0(as.character(keep.cols),collapse=",")
  }
  
  if(!is.null(rm.cols)){
    rm.cols<-paste0(as.character(rm.cols),collapse=",")
  }
  
  calltext1 <- call("dataFrameSubsetDS1", df.name, V1.name, V2.name, BO.n, keep.cols, rm.cols, keep.NAs)
  return.warning.message<-DSI::datashield.aggregate(datasources, calltext1)
  
  calltext2 <- call("dataFrameSubsetDS2", df.name, V1.name, V2.name, BO.n, keep.cols, rm.cols, keep.NAs)
  DSI::datashield.assign(datasources, newobj, calltext2)
  
  numsources<-length(datasources)
  for(s in 1:numsources){
    num.messages<-length(return.warning.message[[s]])
    if (notify.of.progress)
    {
      if(num.messages==1){
        cat("\nSource",s,"\n",return.warning.message[[s]][[1]],"\n")
      }else{
        cat("\nSource",s,"\n")
        for(m in 1:(num.messages-1)){
          cat(return.warning.message[[s]][[m]],"\n")
        }
        cat(return.warning.message[[s]][[num.messages]],"\n")
      }
    }
  }
  
  #############################################################################################################
  #DataSHIELD CLIENTSIDE MODULE: CHECK KEY DATA OBJECTS SUCCESSFULLY CREATED                                  #
  #
  #SET APPROPRIATE PARAMETERS FOR THIS PARTICULAR FUNCTION                                                 	#
  test.obj.name<-newobj																					 	#
  #																											#
  #
  # CALL SEVERSIDE FUNCTION                                                                                	#
  calltext <- call("testObjExistsDS", test.obj.name)													 	#
  #
  object.info<-DSI::datashield.aggregate(datasources, calltext)												 	#
  #
  # CHECK IN EACH SOURCE WHETHER OBJECT NAME EXISTS														 	#
  # AND WHETHER OBJECT PHYSICALLY EXISTS WITH A NON-NULL CLASS											 	#
  num.datasources<-length(object.info)																	 	#
  #
  #
  obj.name.exists.in.all.sources<-TRUE																	 	#
  obj.non.null.in.all.sources<-TRUE																		 	#
  #
  for(j in 1:num.datasources){																			 	#
    if(!object.info[[j]]$test.obj.exists){																 	#
      obj.name.exists.in.all.sources<-FALSE															 	#
    }																								 	#
    if(is.null(object.info[[j]]$test.obj.class) || object.info[[j]]$test.obj.class=="ABSENT"){														 	#
      obj.non.null.in.all.sources<-FALSE																 	#
    }																								 	#
  }																									 	#
  #
  if(obj.name.exists.in.all.sources && obj.non.null.in.all.sources){										 	#
    #
    return.message<-																					 	#
      paste0("A data object <", test.obj.name, "> has been created in all specified data sources")		 	#
    #
    #
  }else{																								 	#
    #
    return.message.1<-																					 	#
      paste0("Error: A valid data object <", test.obj.name, "> does NOT exist in ALL specified data sources")	#
    #
    return.message.2<-																					 	#
      paste0("It is either ABSENT and/or has no valid content/class,see return.info above")				 	#
    #
    return.message.3<-																					 	#
      paste0("Please use ds.ls() to identify where missing")												 	#
    #
    #
    return.message<-list(return.message.1,return.message.2,return.message.3)							 	#
    #
  }																										#
  #
  calltext <- call("messageDS", test.obj.name)															#
  studyside.message<-DSI::datashield.aggregate(datasources, calltext)											#
  #
  no.errors<-TRUE																							#
  for(nd in 1:num.datasources){																			#
    if(studyside.message[[nd]]!="ALL OK: there are no studysideMessage(s) on this datasource"){			#
      no.errors<-FALSE																					#
    }																									#
  }																										#
  #
  #
  if(no.errors){																							#
    validity.check<-paste0("<",test.obj.name, "> appears valid in all sources")							    #
    return(list(is.object.created=return.message,validity.check=validity.check))						    #
  }																										#
  #
  if(!no.errors){																								#
    validity.check<-paste0("<",test.obj.name,"> invalid in at least one source. See studyside.messages:")   #
    return(list(is.object.created=return.message,validity.check=validity.check,					    		#
                studyside.messages=studyside.message))			                                            #
  }																										#
  #
  #END OF CHECK OBJECT CREATED CORECTLY MODULE															 	#
  #############################################################################################################
  
}
#ds.dataFrameSubset
