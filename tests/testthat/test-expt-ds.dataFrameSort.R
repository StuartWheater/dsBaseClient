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

context("ds.dataFrameSort::expt::setup")

source('connection_to_datasets/init_testing_datasets.R')
source('definition_tests/def-ds.dataFrameSort.R')

connect.all.datasets()

test_that("setup", {
    ds_expect_variables(c("D"))
})

#
# Tests
#

context("ds.dataFrameSort::expt::numeric::increasing")
test_that("combined data set",
{
  connect.all.datasets()
  .sort.numeric.increasing("D","INTEGER")
})


#
# Shutdown
#

context("ds.dataFrameSort::expt::shutdown")

test_that("shutdown", {
    ds_expect_variables(c("D"))
})

disconnect.all.datasets()

#
# Done
#

context("ds.dataFrameSort::expt::done")
