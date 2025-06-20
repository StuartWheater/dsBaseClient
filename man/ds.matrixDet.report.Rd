% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ds.matrixDet.report.R
\name{ds.matrixDet.report}
\alias{ds.matrixDet.report}
\title{Returns matrix determinant to the client-side}
\usage{
ds.matrixDet.report(M1 = NULL, logarithm = FALSE, datasources = NULL)
}
\arguments{
\item{M1}{a character string specifying the name of the matrix.}

\item{logarithm}{logical. If TRUE the logarithm of the modulus of the determinant
is calculated. Default FALSE.}

\item{datasources}{a list of \code{\link[DSI]{DSConnection-class}} 
objects obtained after login. If the \code{datasources} argument is not specified
the default set of connections will be used: see \code{\link[DSI]{datashield.connections_default}}.}
}
\value{
\code{ds.matrixDet.report} returns to the client-side
the determinant of a matrix that is stored on the server-side.
}
\description{
Calculates the determinant of a square matrix  and returns
the result to the client-side
}
\details{
Calculates and returns to the client-side
the determinant of a square matrix on the server-side. 
This function is similar to the native R \code{determinant} function.  
This operation is only
possible if the number of columns and rows of the matrix are the same.

Server function called: \code{matrixDetDS1}
}
\examples{
\dontrun{

 ## Version 6, for version 5 see the Wiki
  
  # connecting to the Opal servers

  require('DSI')
  require('DSOpal')
  require('dsBaseClient')

  builder <- DSI::newDSLoginBuilder()
  builder$append(server = "study1", 
                 url = "http://192.168.56.100:8080/", 
                 user = "administrator", password = "datashield_test&", 
                 table = "CNSIM.CNSIM1", driver = "OpalDriver")
  builder$append(server = "study2", 
                 url = "http://192.168.56.100:8080/", 
                 user = "administrator", password = "datashield_test&", 
                 table = "CNSIM.CNSIM2", driver = "OpalDriver")
  builder$append(server = "study3",
                 url = "http://192.168.56.100:8080/", 
                 user = "administrator", password = "datashield_test&", 
                 table = "CNSIM.CNSIM3", driver = "OpalDriver")
  logindata <- builder$build()
  
  connections <- DSI::datashield.login(logins = logindata, assign = TRUE, symbol = "D") 
  
  #Create the matrix in the server-side
  
  ds.rUnif(samp.size = 9,
           min = -10.5,
           max = 10.5,
           newobj = "ss.vector.9",
           seed.as.integer = 5575,
           force.output.to.k.decimal.places = 0,
           datasources = connections)
           
  ds.matrix(mdata = "ss.vector.9",
            from = "serverside.vector",
            nrows.scalar = 9,ncols.scalar = 9,
            byrow = TRUE,
            newobj = "matrix",
            datasources = connections)
            
  #Calculate the determinant of the matrix
  
  ds.matrixDet.report(M1 = "matrix", 
                      logarithm = FALSE, 
                      datasources = connections)
  
  # clear the Datashield R sessions and logout
  datashield.logout(connections)
}
}
\author{
DataSHIELD Development Team
}
