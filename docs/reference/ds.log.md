# Computes logarithms in the server-side

Computes the logarithms for a specified numeric vector. This function is
similar to the R `log` function. by default natural logarithms.

## Usage

``` r
ds.log(x = NULL, base = exp(1), newobj = NULL, datasources = NULL)
```

## Arguments

- x:

  a character string providing the name of a numerical vector.

- base:

  a positive number, the base for which logarithms are computed. Default
  `exp(1)`.

- newobj:

  a character string that provides the name for the output variable that
  is stored on the server-side. Default `log.newobj`.

- datasources:

  a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  objects obtained after login. If the `datasources` argument is not
  specified the default set of connections will be used: see
  [`datashield.connections_default`](https://datashield.github.io/DSI/reference/datashield.connections_default.html).

## Value

`ds.log` returns a vector for each study of the transformed values for
the numeric vector specified in the argument `x`. The created vectors
are stored in the server-side.

## Details

Server function called: `logDS`

## Author

DataSHIELD Development Team

Tim Cadman, Genomics Coordination Centre, UMCG, Netherlands

## Examples

``` r
if (FALSE) { # \dontrun{

  ## Version 6, for version 5 see the Wiki 
  # Connecting to the Armadillo/Opal servers

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
  
  # Log onto the remote Armadillo/Opal training servers
  connections <- DSI::datashield.login(logins = logindata, assign = TRUE, symbol = "D") 
  
  # Calculating the log value of the 'PM_BMI_CONTINUOUS' variable
  
  ds.log(x = "D$PM_BMI_CONTINUOUS",
         base = exp(2),
         newobj = "log.PM_BMI_CONTINUOUS",
         datasources = connections[1]) #only the first server is used (study1)

  # clear the Datashield R sessions and logout
  datashield.logout(connections) 
} # }
```
