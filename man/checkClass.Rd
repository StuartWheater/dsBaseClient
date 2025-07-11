% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checkClass.R
\name{checkClass}
\alias{checkClass}
\title{Checks that an object has the same class in all studies}
\usage{
checkClass(datasources = NULL, obj = NULL)
}
\arguments{
\item{datasources}{a list of \code{\link[DSI]{DSConnection-class}} objects obtained after login. If the <datasources>
the default set of connections will be used: see \link[DSI]{datashield.connections_default}.}

\item{obj}{a string character, the name of the object to check for.}
}
\value{
a message or the class of the object if the object has the same class in all studies.
}
\description{
This is an internal function.
}
\details{
In DataSHIELD an object included in analysis must be of the same type in all
the collaborating studies. If that is not the case the process is stopped
}
\keyword{internal}
