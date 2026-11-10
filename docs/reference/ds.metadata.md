# Gets the metadata associated with a variable held on the server

This function gets the metadata of a variable stored on the server.

## Usage

``` r
ds.metadata(x = NULL, datasources = NULL)
```

## Arguments

- x:

  a character string specifying the name of the object.

- datasources:

  a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  objects obtained after login. If the `datasources` argument is not
  specified the default set of connections will be used: see
  [`datashield.connections_default`](https://datashield.github.io/DSI/reference/datashield.connections_default.html).

## Value

`ds.metadata` returns to the client-side the metadata of associated to
an object held at the server.

## Details

Server function `metadataDS` is called examines the attributes
associated with the variable which are non-disclosive.

## Author

Stuart Wheater, DataSHIELD Development Team

Tim Cadman, Genomics Coordination Centre, UMCG, Netherlands

## Examples

``` r
if (FALSE) { # \dontrun{

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
  
  # Example 1: Get the metadata associated with variable 'D'
  ds.metadata(x = 'D$LAB_TSC', datasources = connections)

  # clear the Datashield R sessions and logout
  DSI::datashield.logout(connections)
} # }
```
