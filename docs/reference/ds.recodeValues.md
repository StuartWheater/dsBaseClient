# Recodes server-side variable values

This function takes specified values of elements in a vector and
converts them to a matched set of alternative specified values.

## Usage

``` r
ds.recodeValues(
  var.name = NULL,
  values2replace.vector = NULL,
  new.values.vector = NULL,
  missing = NULL,
  newobj = NULL,
  datasources = NULL,
  notify.of.progress = FALSE
)
```

## Arguments

- var.name:

  a character string providing the name of the variable to be recoded.

- values2replace.vector:

  a numeric or character vector specifying the values in the variable
  `var.name` to be replaced.

- new.values.vector:

  a numeric or character vector specifying the new values.

- missing:

  If supplied, any missing values in var.name will be replaced by this
  value. Must be of length 1. If the analyst want to recode only missing
  values then it should also specify an identical vector of values in
  both arguments `values2replace.vector` and `new.values.vector`.
  Otherwise please look the `ds.replaceNA` function.

- newobj:

  a character string that provides the name for the output object that
  is stored on the data servers. Default `recodevalues.newobj`.

- datasources:

  a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  objects obtained after login. If the `datasources` argument is not
  specified the default set of connections will be used: see
  [`datashield.connections_default`](https://datashield.github.io/DSI/reference/datashield.connections_default.html).

- notify.of.progress:

  logical. If TRUE console output should be produced to indicate
  progress. Default FALSE.

## Value

Assigns to each server a new variable with the recoded values.

## Details

This function recodes individual values with new individual values. This
can apply to numeric and character values, factor levels and NAs. One
particular use of `ds.recodeValues` is to convert NAs to an explicit
value. This value is specified in the argument `missing`. If the user
want to recode only missing values, then it should also specify an
identical vector of values in both arguments `values2replace.vector` and
`new.values.vector` (see Example 2 below). Server function called:
`recodeValuesDS`

## Author

DataSHIELD Development Team

Tim Cadman, Genomics Coordination Centre, UMCG, Netherlands

## Examples

``` r
if (FALSE) { # \dontrun{

  ## Version 6, for version 5 see the Wiki
  
  # connecting to the Armadillo/Opal servers

  require('DSI')
  require('DSMolgenisArmadillo')
  require('DSOpal')
  require('dsBaseClient')

  armadillo_url <- "http://192.168.56.100:8080/"
  token <- armadillo.get_credentials(armadillo_url)
  builder <- DSI::newDSLoginBuilder()
  builder$append(server = "study1", 
                 url = armadillo_url, 
                 token = token@access_token, 
                 table = "datashield/cnsim/CNSIM1", driver = "ArmadilloDriver")
  builder$append(server = "study2", 
                 url = "https://192.168.56.100:8443/", 
                 user = "administrator", password = "datashield_test&", 
                 table = "CNSIM.CNSIM2", driver = "OpalDriver",
                 options = "list(ssl_verifyhost=0, ssl_verifypeer=0)")
  logindata <- builder$build()
  
  connections <- DSI::datashield.login(logins = logindata, assign = TRUE, symbol = "D") 
  
  # Example 1: recode the levels of D$GENDER
  ds.recodeValues(var.name = "D$GENDER", 
                  values2replace.vector = c(0,1), 
                  new.values.vector = c(10,20),
                  newobj = 'gender_recoded',
                  datasources = connections)
                  
  # Example 2: recode NAs in D$PM_BMI_CATEGORICAL          
  ds.recodeValues(var.name = "D$PM_BMI_CATEGORICAL", 
                  values2replace.vector = c(1,2), 
                  new.values.vector = c(1,2),
                  missing = 99, 
                  newobj = 'bmi_recoded',
                  datasources = connections)
                 
  # Clear the Datashield R sessions and logout                 
  datashield.logout(connections) 
  
} # }   
```
