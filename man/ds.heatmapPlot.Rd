% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ds.heatmapPlot.R
\name{ds.heatmapPlot}
\alias{ds.heatmapPlot}
\title{Generates a Heat Map plot}
\usage{
ds.heatmapPlot(
  x = NULL,
  y = NULL,
  type = "combine",
  show = "all",
  numints = 20,
  method = "smallCellsRule",
  k = 3,
  noise = 0.25,
  datasources = NULL
)
}
\arguments{
\item{x}{a character string specifying the name of a numerical vector.}

\item{y}{a character string specifying the name of a numerical vector.}

\item{type}{a character string that represents the type of graph to display.
\code{type} argument can be set as \code{'combine'} or \code{'split'}. 
Default \code{'combine'}.
For more information see \strong{Details}.}

\item{show}{a character string that represents where the plot should be focused. 
\code{show} argument can be set as \code{'all'} or \code{'zoomed'}. 
Default \code{'all'}. 
For more information see \strong{Details}.}

\item{numints}{the number of intervals for a density grid object. 
Default \code{numints} value is \code{20}.}

\item{method}{a character string that defines which heat map will be created. 
The \code{method} argument can be set as \code{'smallCellsRule'}, 
\code{'deterministic'} or \code{'probabilistic'}. 
Default \code{'smallCellsRule'}. 
For more information see \strong{Details}.}

\item{k}{the number of the nearest neighbours for which their centroid is calculated. 
Default \code{k} value is \code{3}. 
For more information see \strong{Details}.}

\item{noise}{the percentage of the initial variance that is used as the variance of the embedded
noise if the argument \code{method} is set to \code{'probabilistic'}. 
Default \code{noise} value is  \code{0.25}.
For more information see \strong{Details}.}

\item{datasources}{a list of \code{\link[DSI]{DSConnection-class}} objects obtained after login. 
If the \code{datasources} argument is not specified
the default set of connections will be used: see \code{\link[DSI]{datashield.connections_default}}.}
}
\value{
\code{ds.heatmapPlot} returns to the client-side a heat map plot and a message specifying 
the number of invalid cells in each study.
}
\description{
Generates a heat map plot of the pooled data or one plot for each dataset.
}
\details{
The \code{ds.heatmapPlot} function first generates a density grid 
and uses it to plot the graph.
Cells of the grid density matrix that hold a count of less than the filter set by
DataSHIELD (usually 5) are considered invalid and turned into 0 to avoid potential
disclosure. A message is printed to inform the user about the number of invalid cells.
The ranges returned by each study and used in the process of getting the grid density matrix
are not the exact minimum and maximum values but rather close approximates of the real
minimum and maximum value. This was done to reduce the risk of potential disclosure.

In the argument \code{type} can be specified two types of graphics to display:
 \describe{
   \item{\code{'combine'}}{: a combined heat map plot is displayed} 
   \item{\code{'split'}}{: each heat map is plotted separately}
    }

In the argument \code{show} can be specified two options:
 \describe{
   \item{\code{'all'}}{: the ranges of the variables are used as plot limits} 
   \item{\code{'zoomed'}}{: the plot is zoomed to the region where the actual data are}
    }

In the argument \code{method} can be specified 3 different heat map to be created:
 \describe{
   \item{\code{'smallCellsRule'}}{: the heat map of the actual variables is
    created but grids with low counts are replaced with grids with zero counts} 
   \item{\code{'deterministic'}}{: the heat map of the scaled centroids of each 
         \code{k} nearest neighbours of the
        original variables are created, where the value of \code{k} is set by the user} 
   \item{\code{'probabilistic'}}{:  the heat map of \code{'noisy'} variables is generated. 
          The added noise follows a normal distribution with 
          zero mean and variance equal to a percentage of
          the initial variance of each input variable. 
          This percentage is specified by the user in the
          argument \code{noise}} 
 
    }

In the \code{k} argument the user can choose any value for 
\code{k} equal to or greater than the pre-specified threshold
used as a disclosure control for this method and lower than the number of observations
minus the value of this threshold. By default the value of \code{k} is set to be equal to 3
(we suggest k to be equal to, or bigger than, 3). Note that the function fails if the user
uses the default value but the study has set a bigger threshold. 
The value of \code{k} is used only
if the argument \code{method} is set to \code{'deterministic'}. 
Any value of \code{k} is ignored if the
argument \code{method} is set to \code{'probabilistic'} or \code{'smallCellsRule'}.


The value of \code{noise} is used only if the argument 
\code{method} is set to \code{'probabilistic'}.
Any value of \code{noise} is ignored if the argument 
\code{method} is set to \code{'deterministic'} or \code{'smallCellsRule'}. 
The user can choose any value for \code{noise} equal 
to or greater than the pre-specified threshold \code{'nfilter.noise'}.

Server function called: \code{heatmapPlotDS}
}
\examples{
\dontrun{

## Version 6, for version 5 see the Wiki
  # Connecting to the Opal servers

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
  
  # Log onto the remote Opal training servers
  connections <- DSI::datashield.login(logins = logindata, assign = TRUE, symbol = "D") 
  
  # Compute the heat map plot 
  # Example 1: Plot a combined (default) heat map plot of the variables 'LAB_TSC'
  # and 'LAB_HDL' using the method 'smallCellsRule' (default)
  ds.heatmapPlot(x = 'D$LAB_TSC',
                 y = 'D$LAB_HDL',
                 datasources = connections) #all servers are used
                 
  # Example 2: Plot a split heat map  plot of the variables 'LAB_TSC'
  # and 'LAB_HDL' using the method 'smallCellsRule' (default)
  ds.heatmapPlot(x = 'D$LAB_TSC', 
                 y = 'D$LAB_HDL',
                 method = 'smallCellsRule', 
                 type = 'split',
                 datasources = connections[1]) #only the first server is used (study1)
                 
  # Example 3: Plot a combined heat map plot using the method 'deterministic' centroids of each 
  k = 7 nearest neighbours for numints = 40
  ds.heatmapPlot(x = 'D$LAB_TSC',
                 y = 'D$LAB_HDL', 
                 numints = 40, 
                 method = 'deterministic',
                 k = 7,
                 type = 'split',
                 datasources = connections[2]) #only the second server is used (study2)


  # clear the Datashield R sessions and logout
  datashield.logout(connections)

}

}
\author{
DataSHIELD Development Team
}
