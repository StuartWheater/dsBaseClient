# Generates Normal distribution in the server-side

Generates normally distributed random (pseudorandom) scalar numbers.
Besides, `ds.rNorm` allows creating different vector lengths in each
server.

## Usage

``` r
ds.rNorm(
  samp.size = 1,
  mean = 0,
  sd = 1,
  newobj = "newObject",
  seed.as.integer = NULL,
  return.full.seed.as.set = FALSE,
  force.output.to.k.decimal.places = 9,
  datasources = NULL
)
```

## Arguments

- samp.size:

  an integer value or an integer vector that defines the length of the
  random numeric vector to be created in each source.

- mean:

  the mean value or vector of the Normal distribution to be created. A
  single value is used in every study; a vector must have one value per
  study, with its k-th value used in study k.

- sd:

  the standard deviation of the Normal distribution to be created. A
  single value is used in every study; a vector must have one value per
  study, with its k-th value used in study k.

- newobj:

  a character string that provides the name for the output variable that
  is stored on the data servers. Default `newObject`.

- seed.as.integer:

  an integer or a NULL value which provides the random seed in each data
  source.

- return.full.seed.as.set:

  logical, if TRUE will returns the full random number seed in each data
  source (a numeric vector of length 626). If FALSE it will only return
  the trigger seed value you have provided. Default is FALSE.

- force.output.to.k.decimal.places:

  an integer vector that forces the output random numbers vector to have
  k decimals. A single value is used in every study; a vector must have
  one value per study, with its k-th value used in study k.

- datasources:

  a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  objects obtained after login. If the `datasources` argument is not
  specified the default set of connections will be used: see
  [`datashield.connections_default`](https://datashield.github.io/DSI/reference/datashield.connections_default.html).

## Value

`ds.rNorm` writes a random number vector with a normal distribution to
the server-side in each study and returns a list to the client-side
containing `integer.seed.as.set.by.source` (the trigger seed set in each
source), `random.vector.length.by.source` (the length of the vector
created in each source) and, if `return.full.seed.as.set` is TRUE,
`full.seed.as.set` (the full 626 length random seed vector generated in
each source).

## Details

Creates a vector of pseudorandom numbers distributed with a Normal
distribution in each data source. The `ds.rNorm` function's arguments
specify the mean and the standard deviation (`sd`) of the normal
distribution and the length and the seed of the output vector in each
source.

To specify a different `mean` value in each source, you can use a
character vector `(..., mean="vector.of.means"...)` or the `datasources`
parameter to create the random vector for one source at a time, changing
the `mean` as required. Default value for `mean = 0`.

To specify different `sd` value in each source, you can use a character
vector `(..., sd="vector.of.sds"...` or the `datasources` parameter to
create the random vector for one source at a time, changing the \<mean\>
as required. Default value for `sd = 0`.

If `seed.as.integer` is an integer e.g. 5 and there is more than one
source (N) the seed is set as 5\*N. For example, in the first study the
seed is set as 938\*1, in the second as 938\*2 up to 938\*N in the Nth
study.

If `seed.as.integer` is set as 0 all sources will start with the seed
value 0 and all the random number generators will, therefore, start from
the same position. Also, to use the same starting seed in all studies
but do not wish it to be 0, you can use `datasources` argument to
generate the random number vectors one source at a time.

In `force.output.to.k.decimal.places` the range of k is 1-8 decimals. If
`k = 0` the output random numbers are forced to integer. If `k = 9`, no
rounding of output numbers occurs. The default value of
`force.output.to.k.decimal.places = 9`.

Server functions called: `rNormDS` and `setSeedDS`.

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

  # Generating the vectors in the servers

  ds.rNorm(samp.size=c(10,20), #the length of the vector created in each source is different 
           mean=c(1,6),           #the mean of the Normal distribution changes in each server
           sd=c(1,4), #the sd of the Normal distribution changes in each server
           newobj="Norm.dist",
           seed.as.integer=2345, 
           return.full.seed.as.set=FALSE,
           force.output.to.k.decimal.places=c(4,5), #output random numbers have different 
                                                      #decimal quantity in each source 
           datasources=connections) #all the servers are used, in this case 2 
                                    #(see above the connection to the servers) 
  
  ds.rNorm(samp.size=10,
           mean=1.4,
           sd=0.2, 
           newobj="Norm.dist", 
           seed.as.integer=2345,
           return.full.seed.as.set=FALSE,
           force.output.to.k.decimal.places=1,
           datasources=connections[2]) #only the second  server is used ("study2")
           
  # Clear the Datashield R sessions and logout
  datashield.logout(connections) 
} # }
```
