# Calculates tow matrix multiplication in the server-side

Calculates the matrix product of two matrices and writes output to the
server-side.

## Usage

``` r
ds.matrixMult(M1 = NULL, M2 = NULL, newobj = NULL, datasources = NULL)
```

## Arguments

- M1:

  a character string specifying the name of the first matrix.

- M2:

  a character string specifying the name of the second matrix.

- newobj:

  a character string that provides the name for the output variable that
  is stored on the data servers. Default `matrixmult.newobj`.

- datasources:

  a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  objects obtained after login. If the `datasources` argument is not
  specified the default set of connections will be used: see
  [`datashield.connections_default`](https://datashield.github.io/DSI/reference/datashield.connections_default.html).

## Value

`ds.matrixMult` returns to the server-side the result of the two matrix
multiplication.

## Details

Undertakes standard matrix multiplication wherewith input matrices `A`
and `B` with dimensions `A: m x n` and `B: n x p` the output matrix `C`
has dimensions `m x p`. This calculation is only valid if the number of
columns of `A` is the same as the number of rows of `B`.

Server function called: `matrixMultDS`

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
  
            
  #Example 1: Multiplicate two server-side matrix
  
  #Create the server-side vector 
  
  ds.rUnif(samp.size = 9,
           min = -10.5,
           max = 10.5,
           newobj = "ss.vector.9",
           seed.as.integer = 5575,
           force.output.to.k.decimal.places = 0,
           datasources = connections)
           
  #Create the server-side matrixes
           
  ds.matrix(mdata = "ss.vector.9",#using the created vector
            from = "serverside.vector",
            nrows.scalar = 5,
            ncols.scalar = 4,
            byrow = TRUE,
            newobj = "matrix1",
            datasources = connections)
            
   ds.matrix(mdata = 10,
             from = "clientside.scalar",
             nrows.scalar = 4,
             ncols.scalar = 6,
             byrow = TRUE,
             newobj = "matrix2",
             datasources = connections)

  #Multiplicate the matrixes
  
  ds.matrixMult(M1 = "matrix1", 
                M2 = "matrix2", 
                newobj = "matrix.mult", 
                datasources = connections)
  
  # clear the Datashield R sessions and logout
  datashield.logout(connections)
} # }
```
