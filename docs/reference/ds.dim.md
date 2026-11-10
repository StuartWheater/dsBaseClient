# Retrieves the dimension of a server-side R object

Gives the dimensions of an R object on the server-side. This function is
similar to R function `dim`.

## Usage

``` r
ds.dim(
  x = NULL,
  type = "both",
  datasources = NULL,
  classConsistencyCheck = TRUE
)
```

## Arguments

- x:

  a character string providing the name of the input object.

- type:

  a character string that represents the type of analysis to carry out.
  If `type` is set to `'combine'`, `'combined'`, `'combines'` or `'c'`,
  the global dimension is returned. If `type` is set to `'split'`,
  `'splits'` or `'s'`, the dimension is returned separately for each
  study. If `type` is set to `'both'` or `'b'`, both sets of outputs are
  produced. Default `'both'`.

- datasources:

  a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  objects obtained after login. If the `datasources` argument is not
  specified the default set of connections will be used: see
  [`datashield.connections_default`](https://datashield.github.io/DSI/reference/datashield.connections_default.html).

- classConsistencyCheck:

  logical. If TRUE, checks that the input object has the same class
  across all studies. Default TRUE.

## Value

`ds.dim` retrieves to the client-side the dimension of the object in the
form of a vector where the first element indicates the number of rows
and the second element indicates the number of columns.

## Details

The function returns the dimension of the server-side input object (e.g.
array, matrix or data frame) from every single study and the pooled
dimension of the object by summing up the individual dimensions returned
from each study.

Server function called: `dimDS`

## See also

[`ds.dataFrame`](ds.dataFrame.md) to generate a table of the type data
frame.

[`ds.changeRefGroup`](ds.changeRefGroup.md) to change the reference
level of a factor.

[`ds.colnames`](ds.colnames.md) to obtain the column names of a matrix
or a data frame

[`ds.asMatrix`](ds.asMatrix.md) to coerce an object into a matrix type.

[`ds.length`](ds.length.md) to obtain the size of a vector.

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
  

  # Calculate the dimension
  ds.dim(x="D", 
         type="combine", #global dimension
         datasources = connections)#all servers are used
  ds.dim(x="D",
         type = "both",#separate dimension for each study
                       #and the pooled dimension (default) 
         datasources = connections)#all servers are used
  ds.dim(x="D", 
         type="split", #separate dimension for each study
         datasources = connections[1])#only the first server is used ("study1")

  # clear the Datashield R sessions and logout
  datashield.logout(connections)

} # }
```
