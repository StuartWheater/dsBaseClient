% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ds.reShape.R
\name{ds.reShape}
\alias{ds.reShape}
\title{ds.reShape calling assign function reShapeDS}
\usage{
ds.reShape(data.name = NULL, varying = NULL, v.names = NULL,
  timevar.name = "time", idvar.name = "id", drop = NULL,
  direction = NULL, sep = ".", newobj = "newObject",
  datasources = NULL)
}
\arguments{
\item{data.name, }{the name of the data frame to be reshaped. The user must set the name as a
character string in inverted commas. For example: data.name='data.frame.name'}

\item{varying, }{names of sets of variables in the wide format that correspond to single
variables in long format (typically what may be called 'time-varying' or
'time-dependent' variables). For example, varying=c('outcome1.1', 'outcome1.2',
'outcome1.3', 'outcome1.4', 'outcome1.5', 'outcome1.6')}

\item{v.names, }{the names of variables in the long format that correspond to multiple variables
in the wide format - for example, the single vector 'sbp' in long format may reflect
'sbp7', 'sbp11', 'sbp15' in wide format (measured systolic blood pressure
at ages 7, 11 and 15 years). In the long format these simply represent 3 different records
with the systolic bp recorded in one column (i.e. sbp) and age of measurement recorded
in another column (e.g. age). For example, v.names=c('outcome1','outcome2') specifies
that 'outcome1' and 'outcome2' in long format vary with time and may generate multiple
columns in wide format}

\item{timevar.name, }{the variable in long format that differentiates multiple
records from the same
group or individual. If more than one record matches, the first will be taken. In the example,
given under param v.names, it is the 'age' variable that discriminates the time at which 
each measurement was taken. For example, timevar.name='time.name'}

\item{idvar.name, }{names of one or more variables in long format that identify multiple
records from
the same group/individual. These variables may also be present in wide format. For example, if
there is a numeric ID, all observations for the individual with ID 23 may have the value 23
in an 'individual.ID' vector which can be declared as <idvar.name>: idvar.name='individual.ID'}

\item{drop, }{a vector of names of variables to drop before reshaping. This can simplify the
resultant output. For example,  drop=c('bmi.26','pm10.16','survtime','censor')}

\item{direction, }{a character string, partially matched to either 'wide' to reshape from 
long to wide format, or 'long' to reshape from wide to long format.}

\item{sep, }{a character vector of length 1, indicating a separating character in the variable
names in the wide format. This is used for creating good v.names and times arguments based
on the names in the <varying> argument. This is also used to create variable names
when reshaping
to wide format. For example, in long format if sep='.', and systolic blood pressure is held in 
a column 'sbp', and age is recorded in years in a vector 'age' then depending how you
set things up the column for sbp at age 7 in the wide format may be called
'sbp.7' or 'sbp.age.7'}

\item{newobj}{A character string specifying the name of the vector to which the output
vector is to be written. If no <newobj> argument is specified, the output vector defaults
to 'newObject'.}

\item{datasources}{specifies the particular opal object(s) to use. If the <datasources>
argument is not specified the default set of opals will be used. The default opals
are called default.opals and the default can be set using the function
{ds.setDefaultOpals}. If the <datasources> is to be specified, it should be set without
inverted commas: e.g. datasources=opals.em or datasources=default.opals. If you wish to
apply the function solely to e.g. the second opal server in a set of three,
the argument can be specified as: e.g. datasources=opals.em[2].
If you wish to specify the first and third opal servers in a set you specify:
e.g. datasources=opals.em[c(1,3)]}
}
\value{
a reshaped data.frame converted from long to wide format or from wide to
long format which is written to the serverside and given the name provided as the
<newobj> argument or 'newObject' if no name is specified.
In addition, two validity messages are returned to the clientside
indicating whether <newobj> has been created in each data source and if so whether
it is in a valid form. If its form is not valid in at least one study - e.g. because
a disclosure trap was tripped and creation of the full output object was blocked -
ds.dataFrame() also returns any studysideMessages that can explain the error in creating
the full output object. As well as appearing on the screen at run time,if you wish to
see the relevant studysideMessages at a later date you can use the {ds.message}
function. If you type ds.message('newobj') it will print out the relevant
studysideMessage from any datasource in which there was an error in creating <newobj>
and a studysideMessage was saved. If there was no error and <newobj> was created
without problems no studysideMessage will have been saved and ds.message('newobj')
will return the message: 'ALL OK: there are no studysideMessage(s) on this datasource'
}
\description{
Reshapes a data frame containing longitudinal or
otherwise grouped data from 'wide' to 'long' format or vice-versa
}
\details{
This function is based on the native R function \code{reshape}.
It reshapes a data frame containing longitudinal or otherwise grouped data
between 'wide' format with repeated
measurements in separate columns of the same record and 'long' format with the repeated
measurements in separate records. The reshaping can be in either direction
}
\author{
Demetris Avraam, Paul Burton for DataSHIELD Development Team
}