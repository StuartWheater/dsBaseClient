% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ds.histogram.R
\name{ds.histogram}
\alias{ds.histogram}
\title{Generates a histogram plot}
\usage{
ds.histogram(
  x = NULL,
  type = "split",
  num.breaks = 10,
  method = "smallCellsRule",
  k = 3,
  noise = 0.25,
  vertical.axis = "Frequency",
  datasources = NULL
)
}
\arguments{
\item{x}{a character string specifying the name of a numerical vector.}

\item{type}{a character string that represents the type of graph to display.
The \code{type} argument can be set as \code{'combine'} or \code{'split'}. 
Default \code{'split'}.
For more information see \strong{Details}.}

\item{num.breaks}{a numeric specifying the number of breaks of the histogram. Default value
is \code{10}.}

\item{method}{a character string that defines which histogram will be created.
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

\item{vertical.axis, }{a character string that defines what is shown in the vertical axis of the
plot. The \code{vertical.axis} argument can be set as \code{'Frequency'} or \code{'Density'}.
Default \code{'Frequency'}. 
For more information see \strong{Details}.}

\item{datasources}{a list of \code{\link[DSI]{DSConnection-class}} objects obtained after login. 
If the \code{datasources} argument is not specified
the default set of connections will be used: see \code{\link[DSI]{datashield.connections_default}}.}
}
\value{
one or more histogram objects and plots depending on the argument \code{type}
}
\description{
\code{ds.histogram} function plots a non-disclosive histogram in the client-side.
}
\details{
\code{ds.histogram} function allows the user to plot
distinct histograms (one for each study) or a combined histogram that merges
the single plots.

In the argument \code{type} can be specified two types of graphics to display:
 \describe{
   \item{\code{'combine'}}{: a histogram that merges the single plot is displayed.} 
   \item{\code{'split'}}{: each histogram is plotted separately.}
    }
    
In the argument \code{method} can be specified 3 different histograms to be created:
 \describe{
   \item{\code{'smallCellsRule'}}{: the histogram of the actual variable is
          created but bins with low counts are removed.} 
   \item{\code{'deterministic'}}{: the histogram of the scaled centroids of each 
         \code{k} nearest neighbours of the original variable
         where the value of \code{k} is set by the user.} 
   \item{\code{'probabilistic'}}{: the histogram shows the original distribution disturbed 
         by the addition of random stochastic noise.
         The added noise follows a normal distribution with zero mean and
         variance equal to a percentage of the initial variance of the input variable. 
         This percentage is specified by the user in the argument \code{noise}.} 
 
    }


In the \code{k} argument the user can choose any value for \code{k} equal 
to or greater than the pre-specified threshold
used as a disclosure control for this method and lower than the number of observations
minus the value of this threshold. By default the value of \code{k} is set to be equal to 3
(we suggest k to be equal to, or bigger than, 3). Note that the function fails if the user
uses the default value but the study has set a bigger threshold. 
The value of \code{k} is used only if the argument 
\code{method} is set to \code{'deterministic'}. 
Any value of k is ignored if the
argument \code{method} is set to \code{'probabilistic'} or \code{'smallCellsRule'}.

In the \code{noise} argument the percentage of the initial variance 
that is used as the variance of the embedded
noise if the argument \code{method} is set to \code{'probabilistic'}. 
Any value of noise is ignored if the argument 
\code{method} is set to \code{'deterministic'} or \code{'smallCellsRule'}. 
The user can choose any value for noise equal to or greater 
than the pre-specified threshold \code{'nfilter.noise'}.
By default the value of noise is set to be equal to 0.25.

In the argument  \code{vertical.axis} can be specified two types of histograms:
\describe{
   \item{\code{'Frequency'}}{: the histogram of the frequencies
    is returned.} 
   \item{\code{'Density'}}{: the histogram of the densities
    is returned.}
    }

Server function called: \code{histogramDS2}
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
  
  # Compute the histogram
  # Example 1: generate a histogram for each study separately 
  ds.histogram(x = 'D$PM_BMI_CONTINUOUS',
              type = "split",
              datasources = connections) #all studies are used

  # Example 2: generate a combined histogram with the default small cells counts
               suppression rule
  ds.histogram(x = 'D$PM_BMI_CONTINUOUS',
               method = 'smallCellsRule',
               type = 'combine',
               datasources = connections[1]) #only the first study is used (study1)

  # Example 3: if a variable is of type factor the function returns an error
  ds.histogram(x = 'D$PM_BMI_CATEGORICAL',
               datasources = connections)

  # Example 4: generate a combined histogram with the deterministic method for k=50
  ds.histogram(x = 'D$PM_BMI_CONTINUOUS',
               k = 50, 
               method = 'deterministic',
               type = 'combine',
               datasources = connections[2])#only the second study is used (study2)


  # Example 5: create a histogram and the probability density on the plot
  hist <- ds.histogram(x = 'D$PM_BMI_CONTINUOUS',
                       method = 'probabilistic', type='combine',
                       num.breaks = 30, 
                       vertical.axis = 'Density',
                       datasources = connections)
  lines(hist$mids, hist$density)

  # clear the Datashield R sessions and logout
  datashield.logout(connections)
  }


}
\author{
DataSHIELD Development Team
}
