library(testthat)
library(DSI)
library(cli)

library(testthat)
library(mockery)
library(cli)
library(testthat)
library(mockery)
library(cli)

if (!isClass("DSConnection")) {
  setClass("DSConnection", contains = "VIRTUAL")
}

setClass("MockDSConnection", contains = "DSConnection")
mock_ds_conn <- new("MockDSConnection")

test_that(".get_datasources retrieves connections when input is NULL", {

  mock_connections <- list(
    server1 = mock_ds_conn,
    server2 = mock_ds_conn
  )

  stub(.get_datasources, "datashield.connections_find", mock_connections)

  result <- .get_datasources(NULL)

  expect_type(result, "list")
  expect_length(result, 2)
  expect_named(result, c("server1", "server2"))
  expect_true(is(result$server1, "DSConnection"))
})

test_that(".get_datasources returns input when provided", {

  input_datasources <- list(A = "connA", B = "connB")

  result <- with_mocked_bindings(
    datashield.connections_find = function() stop("Should not be called!"),
    .get_datasources(input_datasources),
    .package = "dsBaseClient"
  )

  expect_equal(result, input_datasources)
})

test_that(".verify_datasources passes with valid DSConnection list", {

  valid_datasources <- list(
    conn_list1 = mock_ds_conn,
    conn_list2 = mock_ds_conn
  )

  expect_no_error(.verify_datasources(valid_datasources))
  expect_null(.verify_datasources(valid_datasources))
})

test_that(".verify_datasources aborts with invalid object types", {

  invalid_datasources <- list(
    conn_list1 = mock_ds_conn,
    conn_list2 = "not_a_connection"
  )

  expect_error(
    .verify_datasources(invalid_datasources)
  )
})

test_that(".set_datasources works with valid input", {

  input_datasources <- list(
    mock_ds_conn
  )

  result <- with_mocked_bindings(
    .get_datasources = function(d) d,
    .verify_datasources = function(d) {},
    .set_datasources(input_datasources),
    .package = "dsBaseClient"
  )

  expect_equal(result, input_datasources)
})

test_that(".set_datasources calls .get_datasources and .verify_datasources", {

  get_called <- FALSE
  verify_called <- FALSE

  mock_get <- function(d) {
    get_called <<- TRUE
    return(list(list(mock_ds_conn)))
  }

  mock_verify <- function(d) {
    verify_called <<- TRUE
  }

  with_mocked_bindings(
    .get_datasources = mock_get,
    .verify_datasources = mock_verify,
    .set_datasources(NULL),
    .package = "dsBaseClient"
  )

  expect_true(get_called)
  expect_true(verify_called)
})

test_that(".set_datasources aborts if verification fails", {

  expect_error(
    with_mocked_bindings(
      .get_datasources = function(d) list(list("bad_conn")),
      .verify_datasources = function(d) cli::cli_abort("Verification failed mock"),
      .set_datasources(NULL),
      .package = "dsBaseClient"
    )
  )
})

test_that(".check_df_name_provided passes when df is not NULL", {

  expect_no_error(.check_df_name_provided("D"))
  expect_null(.check_df_name_provided("D"))

  expect_no_error(.check_df_name_provided(data.frame(a=1)))
})

test_that(".check_df_name_provided aborts when df is NULL", {

  expect_error(
    .check_df_name_provided(NULL)
  )
})

