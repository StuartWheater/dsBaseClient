# Computes the mean and standard deviation across groups defined by one factor

This function calculates the mean and SD of a continuous variable for
each class of a single factor.

## Usage

``` r
ds.meanSdGp(
  x = NULL,
  y = NULL,
  type = "both",
  datasources = NULL,
  classConsistencyCheck = TRUE
)
```

## Arguments

- x:

  a character string specifying the name of a numeric continuous
  variable.

- y:

  a character string specifying the name of a categorical variable of
  class factor.

- type:

  a character string that represents the type of analysis to carry out.
  This can be set as: `"combine"`, `"split"` or `"both"`. Default
  `"both"`. For more information see **Details**.

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

`ds.meanSdGp` returns to the client-side the mean, SD, Nvalid and SEM
combined across studies and/or separately for each study, depending on
the argument `type`.

## Details

This function calculates the mean, standard deviation (SD), N (number of
observations) and the standard error of the mean (SEM) of a continuous
variable broken down into subgroups defined by a single factor.

`ds.meanSdGp` does not subset the data; it only calculates and reports
the statistics. To create physical subsets use `ds.dataFrameSubset`.

Only one categorising factor is allowed. If you have two factors (e.g.
sex with two levels `[0,1]` and `BMI.categorical` with three levels
`[1,2,3]`) you simply need to create a new factor that combines the two
together in a way that gives each combination of levels a different
value in the new factor. So, in the example given, the calculation
`newfactor = (3*sex) + BMI` gives you six values:  
(1) `sex = 0` and `BMI = 1` -\> `newfactor = 1`  
(2) `sex = 0` and `BMI = 2` -\> `newfactor = 2`  
(3) `sex = 0` and `BMI = 3` -\> `newfactor = 3`  
(4) `sex = 1` and `BMI = 1` -\> `newfactor = 4`  
(5) `sex = 1` and `BMI = 2` -\> `newfactor = 5`  
(6) `sex = 1` and `BMI = 3` -\> `newfactor = 6`  

The sample size reported for each group is the number of observations
that are non-missing for both the continuous variable and the factor,
because only those contribute to the group means and SDs. Missing counts
are reported only overall, as `Ntotal` and `Nmissing`.

Depending on the variable `type` can be carried out different
analysis:  
(1) `"combine"`: a pooled table of results is generated.  
(2) `"split"` a table of results is generated for each study.  
(3) `"both"` both sets of outputs are produced.

Server function called: `meanSdGpDS`

## See also

[`ds.dataFrameSubset`](ds.dataFrameSubset.md) to subset a data frame by
rows or columns.

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
                 table = "datashield/survival/EXPAND_NO_MISSING1", driver = "ArmadilloDriver")
  builder$append(server = "study2", 
                 url = "https://192.168.56.100:8443/", 
                 user = "administrator", password = "datashield_test&", 
                 table = "SURVIVAL.EXPAND_NO_MISSING2", driver = "OpalDriver",
                 options = "list(ssl_verifyhost=0, ssl_verifypeer=0)")
  logindata <- builder$build()
  
  connections <- DSI::datashield.login(logins = logindata, assign = TRUE, symbol = "D") 


  #Example 1: Calculate the mean, SD, Nvalid and SEM of the continuous variable age.60 (age in
  #years centralised at 60), broken down by time.id (a six level factor relating to survival time)
  #and report the pooled results combined across studies.
 
  ds.meanSdGp(x = "D$age.60",
              y = "D$time.id",
              type = "combine",
              datasources = connections)
              
  #Example 2: Calculate the mean, SD, Nvalid and SEM of the continuous variable age.60 (age in
  #years centralised at 60), broken down by time.id (a six level factor relating to survival time)
  #and report both study-specific results and the pooled results combined across studies.
  #Save the returned output to msg.b.
  
  ds.meanSdGp(x = "D$age.60",
              y = "D$time.id",
              type = "both",
              datasources = connections)  
             
  # clear the Datashield R sessions and logout
  datashield.logout(connections)
} # }
```
