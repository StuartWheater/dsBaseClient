% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ds.mice.R
\name{ds.mice}
\alias{ds.mice}
\title{Multivariate Imputation by Chained Equations}
\usage{
ds.mice(
  data = NULL,
  m = 5,
  maxit = 5,
  method = NULL,
  predictorMatrix = NULL,
  post = NULL,
  seed = NA,
  newobj_mids = NULL,
  newobj_df = NULL,
  datasources = NULL
)
}
\arguments{
\item{data}{a data frame or a matrix containing the incomplete data.}

\item{m}{Number of multiple imputations. The default is m=5.}

\item{maxit}{A scalar giving the number of iterations. The default is 5.}

\item{method}{Can be either a single string, or a vector of strings with length 
ncol(data), specifying the imputation method to be used for each column in data. If 
specified as a single string, the same method will be used for all blocks. The default 
imputation method (when no argument is specified) depends on the measurement level of 
the target column, as regulated by the defaultMethod argument in native R mice function. 
Columns that need not be imputed have the empty method "".}

\item{predictorMatrix}{A numeric matrix of ncol(data) rows and ncol(data) columns, 
containing 0/1 data specifying the set of predictors to be used for each target column.
Each row corresponds to a variable to be imputed. A value of 1 means that the column 
variable is used as a predictor for the target variables (in the rows). By default, the
predictorMatrix is a square matrix of ncol(data) rows and columns with all 1's, except 
for the diagonal.}

\item{post}{A vector of strings with length ncol(data) specifying expressions as strings. 
Each string is parsed and executed within the sampler() function to post-process imputed 
values during the iterations. The default is a vector of empty strings, indicating no 
post-processing. Multivariate (block) imputation methods ignore the post parameter.}

\item{seed}{either NA (default) or "fixed". If seed is set to "fixed" then a fixed
seed random number generator which is study-specific is used.}

\item{newobj_mids}{a character string that provides the name for the output mids object
that is stored on the data servers. Default \code{mids_object}.}

\item{newobj_df}{a character string that provides the name for the output dataframes 
that are stored on the data servers. Default \code{imputationSet}. For example, if m=5, and 
newobj_df="imputationSet", then five imputed dataframes are saved on the servers with names
imputationSet.1, imputationSet.2, imputationSet.3, imputationSet.4, imputationSet.5.}

\item{datasources}{a list of \code{\link[DSI]{DSConnection-class}} 
objects obtained after login. If the \code{datasources} argument is not specified
the default set of connections will be used: see \code{\link[DSI]{datashield.connections_default}}.}
}
\value{
a list with three elements: the method, the predictorMatrix and the post.
}
\description{
This function calls the miceDS that is a wrapper function of the mice 
from the mice R package. The function creates multiple imputations (replacement values)
for multivariate missing data. The method is based on Fully Conditional Specification, 
where each incomplete variable is imputed by a separate model. The MICE algorithm can
impute mixes of continuous, binary, unordered categorical and ordered categorical data.
In addition, MICE can impute continuous two-level data, and maintain consistency between
imputations by means of passive imputation. It is recommended that the imputation is
done in each datasource separately. Otherwise the user should make sure that the input 
data have the same columns in all datasources and in the same order.
}
\details{
For additional details see the help header of mice function in native R mice
package.
}
\author{
Demetris Avraam for DataSHIELD Development Team
}
