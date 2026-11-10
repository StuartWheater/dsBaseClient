# Calculates de determinant of a matrix in the server-side

Calculates the determinant of a square matrix that is written on the
server-side. This operation is only possible if the number of columns
and rows of the matrix are the same.

## Usage

``` r
ds.matrixDet(M1 = NULL, newobj = NULL, logarithm = FALSE, datasources = NULL)
```

## Arguments

- M1:

  a character string specifying the name of the matrix.

- newobj:

  a character string that provides the name for the output variable that
  is stored on the data servers. Default `matrixdet.newobj`.

- logarithm:

  logical. If TRUE the logarithm of the modulus of the determinant is
  calculated. Default FALSE.

- datasources:

  a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  objects obtained after login. If the `datasources` argument is not
  specified the default set of connections will be used: see
  [`datashield.connections_default`](https://datashield.github.io/DSI/reference/datashield.connections_default.html).

## Value

`ds.matrixDet` returns the determinant of an existing matrix on the
server-side. The created new object is stored on the server-side.

## Details

Calculates the determinant of a square matrix on the server-side. This
function is similar to the native R `determinant` function.

Server function called: `matrixDetDS2`

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
  
  #Create the matrix in the server-side
  
  ds.rUnif(samp.size = 9,
           min = -10.5,
           max = 10.5,
           newobj = "ss.vector.9",
           seed.as.integer = 5575,
           force.output.to.k.decimal.places = 0,
           datasources = connections)
           
  ds.matrix(mdata = "ss.vector.9",
            from = "serverside.vector",
            nrows.scalar = 9,ncols.scalar = 9,
            byrow = TRUE,
            newobj = "matrix",
            datasources = connections)
            
  #Calculate the determinant of the matrix
  
  ds.matrixDet(M1 = "matrix", 
               newobj = "matrixDet", 
               logarithm = FALSE, 
               datasources = connections)
  

  
  # clear the Datashield R sessions and logout
  datashield.logout(connections)
} # }
```
