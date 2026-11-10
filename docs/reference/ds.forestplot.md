# Forestplot for SLMA models

Draws a forestplot of the coefficients for Study-Level Meta-Analysis
performed with DataSHIELD

## Usage

``` r
ds.forestplot(mod, variable = NULL, method = "ML", layout = "JAMA")
```

## Arguments

- mod:

  `list` List outputted by any of the SLMA models of DataSHIELD
  (`ds.glmerSLMA`, `ds.glmSLMA`, `ds.lmerSLMA`)

- variable:

  `character` (default `NULL`) Variable to meta-analyse and visualise,
  by setting this argument to `NULL` (default) the first independent
  variable will be used.

- method:

  `character` (Default `"ML"`) Method to estimate the between study
  variance. See details from
  [`?meta::metagen`](https://rdrr.io/pkg/meta/man/metagen.html) for the
  different options.

- layout:

  `character` (default `"JAMA"`) Layout of the plot. See details from
  [`?meta::metagen`](https://rdrr.io/pkg/meta/man/metagen.html) for the
  different options.

## Value

Results a foresplot object created with \`meta::forest\`.

## Examples

``` r
if (FALSE) { # \dontrun{
  # Run a logistic regression
  
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
  
  # Fit the logistic regression model

  mod <- ds.glmSLMA(formula = "DIS_DIAB~GENDER+PM_BMI_CONTINUOUS+LAB_HDL",
                data = "D",
                family = "binomial",
                datasources = connections)
                
  # Plot the results of the model
  ds.forestplot(mod)
} # }
```
