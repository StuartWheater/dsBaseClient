# Checks if an object is defined on the server-side

Looks if an R object of the given name is defined on the server-side.
This function is similar to the R function `exists`.

## Usage

``` r
ds.exists(x = NULL, datasources = NULL)
```

## Arguments

- x:

  a character string providing the name of the object to look for.

- datasources:

  a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  objects obtained after login. If the `datasources` argument is not
  specified the default set of connections will be used: see
  [`datashield.connections_default`](https://datashield.github.io/DSI/reference/datashield.connections_default.html).

## Value

`ds.exists` returns a logical object. TRUE if the object is on the
server-side and FALSE otherwise.

## Details

In DataSHIELD it is not possible to see the data on the servers of the
collaborating studies. It is only possible to get summaries of objects
stored on the server-side. It is however important to know if an object
is defined (i.e. exists) on the server-side. This function checks if an
object does exist on the server-side.

Server function called: `exists`

## See also

[`ds.class`](ds.class.md) to check the type of an object.

[`ds.length`](ds.length.md) to check the length of an object.

[`ds.dim`](ds.dim.md) to check the dimension of an object.

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
  
  # Check if the object exist in the server-side
  ds.exists(x = "D", 
            datasources = connections) #All servers are used
  ds.exists(x = "D", 
            datasources = connections[1]) #Only the first server is used (study1)
            
  # clear the Datashield R sessions and logout
  datashield.logout(connections)

} # }
```
