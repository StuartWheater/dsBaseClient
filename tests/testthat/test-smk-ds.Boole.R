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

context("ds.Boole::smk::setup")

connect.studies.dataset.cnsim(list("LAB_TSC", "LAB_TRIG"))

test_that("setup", {
    ds_expect_variables(c("D"))
})

#
# Tests
#

context("ds.Boole::smk")
test_that("simple boole", {
    res <- ds.Boole("D$LAB_TSC", "D$LAB_TRIG", "==")

    expect_length(res, 3)
    expect_equal(res$successful, TRUE)
    expect_equal(res$outcome.message, "Success")
    expect_length(res$studyside.messages, 0)
})

#
# Done
#

context("ds.Boole::smk::shutdown")

test_that("shutdown", {
    ds_expect_variables(c("D", "boole.newobj"))
})

disconnect.studies.dataset.cnsim()

context("ds.Boole::smk::done")
