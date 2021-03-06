source("connection_to_datasets/init_testing_datasets.R")
source("definition_tests/def-ds.var.R")


context("ds.var::expt::multiple")
test_that("combined data set",
{
  connect.all.datasets()
  .test.var.combined('D$INTEGER',ds.test_env$local.values[,'INTEGER'])
  .test.var.combined('D$NON_NEGATIVE_INTEGER',ds.test_env$local.values[,'NON_NEGATIVE_INTEGER'])
  .test.var.combined('D$POSITIVE_INTEGER',ds.test_env$local.values[,'POSITIVE_INTEGER'])
  .test.var.combined('D$NEGATIVE_INTEGER',ds.test_env$local.values[,'NEGATIVE_INTEGER']) 
  .test.var.combined('D$NUMERIC',ds.test_env$local.values[,'NUMERIC'])
  .test.var.combined('D$NON_NEGATIVE_NUMERIC',ds.test_env$local.values[,'NON_NEGATIVE_NUMERIC'])
  .test.var.combined('D$POSITIVE_NUMERIC',ds.test_env$local.values[,'POSITIVE_NUMERIC'])
  .test.var.combined('D$NEGATIVE_NUMERIC',ds.test_env$local.values[,'NEGATIVE_NUMERIC']) 
})

context("ds.var::expt::single")
test_that("split data set",
{
  connect.all.datasets()
  .test.var.split('D$INTEGER',ds.test_env$local.values.1[,'INTEGER'],ds.test_env$local.values.2[,'INTEGER'],ds.test_env$local.values.3[,'INTEGER'])
  .test.var.split('D$NON_NEGATIVE_INTEGER',ds.test_env$local.values.1[,'NON_NEGATIVE_INTEGER'],ds.test_env$local.values.2[,'NON_NEGATIVE_INTEGER'],ds.test_env$local.values.3[,'NON_NEGATIVE_INTEGER'])
  .test.var.split('D$POSITIVE_INTEGER',ds.test_env$local.values.1[,'POSITIVE_INTEGER'],ds.test_env$local.values.2[,'POSITIVE_INTEGER'],ds.test_env$local.values.3[,'POSITIVE_INTEGER'])
  .test.var.split('D$NEGATIVE_INTEGER',ds.test_env$local.values.1[,'NEGATIVE_INTEGER'],ds.test_env$local.values.2[,'NEGATIVE_INTEGER'],ds.test_env$local.values.3[,'NEGATIVE_INTEGER'])
  .test.var.split('D$NUMERIC',ds.test_env$local.values.1[,'NUMERIC'],ds.test_env$local.values.2[,'NUMERIC'],ds.test_env$local.values.3[,'NUMERIC'])
  .test.var.split('D$NON_NEGATIVE_NUMERIC',ds.test_env$local.values.1[,'NON_NEGATIVE_NUMERIC'],ds.test_env$local.values.2[,'NON_NEGATIVE_NUMERIC'],ds.test_env$local.values.3[,'NON_NEGATIVE_NUMERIC'])
  .test.var.split('D$POSITIVE_NUMERIC',ds.test_env$local.values.1[,'POSITIVE_NUMERIC'],ds.test_env$local.values.2[,'POSITIVE_NUMERIC'],ds.test_env$local.values.3[,'POSITIVE_NUMERIC'])
  .test.var.split('D$NEGATIVE_NUMERIC',ds.test_env$local.values.1[,'NEGATIVE_NUMERIC'],ds.test_env$local.values.2[,'NEGATIVE_NUMERIC'],ds.test_env$local.values.3[,'NEGATIVE_NUMERIC'])
})

context("ds.var::expt::large_values::multiple")
test_that("large values",
{
  connect.all.datasets()
  .test.variance.large('D$INTEGER',ds.test_env$local.values[,'INTEGER'])
  .test.variance.large('D$NON_NEGATIVE_INTEGER',ds.test_env$local.values[,'NON_NEGATIVE_INTEGER'])
  .test.variance.large('D$POSITIVE_INTEGER',ds.test_env$local.values[,'POSITIVE_INTEGER'])
  .test.variance.large('D$NEGATIVE_INTEGER',ds.test_env$local.values[,'NEGATIVE_INTEGER']) 
  .test.variance.large('D$NUMERIC',ds.test_env$local.values[,'NUMERIC'])
  .test.variance.large('D$NON_NEGATIVE_NUMERIC',ds.test_env$local.values[,'NON_NEGATIVE_NUMERIC'])
  .test.variance.large('D$POSITIVE_NUMERIC',ds.test_env$local.values[,'POSITIVE_NUMERIC'])
  .test.variance.large('D$NEGATIVE_NUMERIC',ds.test_env$local.values[,'NEGATIVE_NUMERIC']) 
})

context("ds.var::expt::large_values::single")
test_that("large values",
{
  connect.dataset.1()
  .test.variance.large('D$INTEGER',ds.test_env$local.values.1[,'INTEGER'])
  .test.variance.large('D$NON_NEGATIVE_INTEGER',ds.test_env$local.values.1[,'NON_NEGATIVE_INTEGER'])
  .test.variance.large('D$POSITIVE_INTEGER',ds.test_env$local.values.1[,'POSITIVE_INTEGER'])
  .test.variance.large('D$NEGATIVE_INTEGER',ds.test_env$local.values.1[,'NEGATIVE_INTEGER'])
  .test.variance.large('D$NUMERIC',ds.test_env$local.values.1[,'NUMERIC'])
  .test.variance.large('D$NON_NEGATIVE_NUMERIC',ds.test_env$local.values.1[,'NON_NEGATIVE_NUMERIC'])
  .test.variance.large('D$POSITIVE_NUMERIC',ds.test_env$local.values.1[,'POSITIVE_NUMERIC'])
  .test.variance.large('D$NEGATIVE_NUMERIC',ds.test_env$local.values.1[,'NEGATIVE_NUMERIC']) 
})


