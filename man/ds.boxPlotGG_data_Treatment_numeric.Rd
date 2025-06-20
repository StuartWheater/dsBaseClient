% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ds.boxPlotGG_data_Treatment_numeric.R
\name{ds.boxPlotGG_data_Treatment_numeric}
\alias{ds.boxPlotGG_data_Treatment_numeric}
\title{Take a vector on the server side an arrange it to pass it to the boxplot function}
\usage{
ds.boxPlotGG_data_Treatment_numeric(vector, datasources = NULL)
}
\arguments{
\item{vector}{\code{character} Name of the table on the server side that holds the information to be plotted later}

\item{datasources}{a list of \code{\link[DSI]{DSConnection-class}} (default \code{NULL}) objects obtained after login}
}
\value{
Does not return nothing, it creates the table \code{"boxPlotRawDataNumeric"} on the server arranged to be passed to the
ggplot boxplot function. Structure of the created table: \cr

 Column 'x': Names on the X axis of the boxplot, aka name of the vector (vector argument) \cr
 Column 'value': Values for that variable \cr
}
\description{
Internal function
}
