# Transposes a server-side matrix

Transposes a matrix and writes the output to the server-side

## Usage

``` r
ds.matrixTranspose(M1 = NULL, newobj = NULL, datasources = NULL)
```

## Arguments

- M1:

  a character string specifying the name of the matrix.

- newobj:

  a character string that provides the name for the output variable that
  is stored on the data servers. Default `matrixtranspose.newobj`.

- datasources:

  a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  objects obtained after login. If the `datasources` argument is not
  specified the default set of connections will be used: see
  [`datashield.connections_default`](https://datashield.github.io/DSI/reference/datashield.connections_default.html).

## Value

`ds.matrixTranspose` returns to the server-side the transpose matrix.

## Details

This operation converts matrix `A` to matrix `C` where element `C[i,j]`
of matrix `C` equals element `A[j,i]` of matrix `A`. Matrix `A`,
therefore, has the same number of rows as matrix `C` has columns and
vice versa.

Server function called: `matrixTransposeDS`

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
  
            
  #Example 1: Transpose the server-side matrix
  
  #Create the server-side vector 
  
  ds.rUnif(samp.size = 9,
           min = -10.5,
           max = 10.5,
           newobj = "ss.vector.9",
           seed.as.integer = 5575,
           force.output.to.k.decimal.places = 0,
           datasources = connections)
           
  #Create the server-side matrix
           
  ds.matrix(mdata = "ss.vector.9",
            from = "serverside.vector",
            nrows.scalar = 3,
            ncols.scalar = 4,
            byrow = TRUE,
            newobj = "matrix",
            datasources = connections)
   
  #Transpose the matrix
  
  ds.matrixTranspose(M1 = "matrix",
                     newobj = "matrix.transpose",
                     datasources = connections)
  
  # clear the Datashield R sessions and logout
  datashield.logout(connections)
} # }
```
