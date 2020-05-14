#-------------------------------------------------------------------------------
# Copyright (c) 2019-2020 University of Newcastle upon Tyne. All rights reserved.
#
# This program and the accompanying materials
# are made available under the terms of the GNU Public License v3.0.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------

#
# Set up
#

context("ds.reShape::smk::setup")

connect.studies.dataset.survival(list("id", "study.id", "time.id", "cens", "age.60", "female"))

test_that("setup", {
    ds_expect_variables(c("D"))
})

#
# Tests
#

context("ds.reShape::smk")
test_that("simplest ds.reShape, wide", {
    res <- ds.reShape(data.name="D", v.names="age.60", timevar.name="time.id", idvar.name="id", direction="wide", newobj="reshape1_obj")

    expect_length(res, 2)
    expect_equal(res$is.object.created, "A data object <reshape1_obj> has been created in all specified data sources")
    expect_equal(res$validity.check, "<reshape1_obj> appears valid in all sources")
})

# test_that("simplest ds.reShape, long", {
#     res <- ds.reShape(data.name="D", v.names="age.60", timevar.name="time.id", idvar.name="id", direction="long", newobj="reshape2_obj")
#
#     expect_length(res, 2)
#     expect_equal(res$is.object.created, "A data object <reshape2_obj> has been created in all specified data sources")
#     expect_equal(res$validity.check, "<reshape2_obj> appears valid in all sources")
# })

test_that("simplest ds.reShape, wide", {
    res <- ds.reShape(data.name="D", v.names="female", timevar.name="time.id", idvar.name="id", direction="wide", newobj="reshape2_obj")

    expect_length(res, 2)
    expect_equal(res$is.object.created, "A data object <reshape2_obj> has been created in all specified data sources")
    expect_equal(res$validity.check, "<reshape2_obj> appears valid in all sources")

    res.colnames <- ds.colnames("reshape2_obj")
    expect_length(res.colnames, 3)
    expect_equal(res.colnames$survival1, c("id", "study.id", "cens", "age.60", "female.1", "female.4", "female.6", "female.3", "female.2", "female.5"))
    expect_equal(res.colnames$survival2, c("id", "study.id", "cens", "age.60", "female.1", "female.3", "female.2", "female.4", "female.5", "female.6"))
    expect_equal(res.colnames$survival3, c("id", "study.id", "cens", "age.60", "female.1", "female.4", "female.2", "female.3", "female.5", "female.6"))

    res.summary.female.1 <- ds.summary("reshape2_obj$female.1")
    print(res.summary.female.1)
#    res.summary.female.2 <- ds.summary("reshape2_obj$female.2")
#    print(res.summary.female.2)
#    res.summary.female.3 <- ds.summary("reshape2_obj$female.3")
#    print(res.summary.female.3)
#    res.summary.female.4 <- ds.summary("reshape2_obj$female.4")
#    print(res.summary.female.4)
#    res.summary.female.5 <- ds.summary("reshape2_obj$female.5")
#    print(res.summary.female.5)
#    res.summary.female.6 <- ds.summary("reshape2_obj$female.6")
#    print(res.summary.female.6)
})

#
# Done
#

context("ds.reShape::smk::shutdown")

test_that("shutdown", {
    ds_expect_variables(c("D", "reshape1_obj", "reshape2_obj"))
})

disconnect.studies.dataset.survival()

context("ds.reShape::smk::done")
