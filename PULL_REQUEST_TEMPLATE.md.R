## Instructions & checklist for PR author

### Description of changes
[Add a description of what they have changed]

### Refactor instructions
- [ ] Removed `exists` and `isDefined` from clientside function and add appropriate checks on server-side function
- [ ] Removed any client-side code checking whether an object has been successfully created
- [ ] Reviewed code to determine if additional refactoring could reduce calls to server-side package
- [ ] Replaced check relating to datashield connections object with `.set_datasources()` (defined in `utils.r`)
- [ ] If relevant, replaced argument check that dataset name has been provided to `.check_df_name_provided()` (defined in `utils.r`)

### Testing instructions
- [ ] Writen client-side unit tests for unhappy flow
- [ ] Run `devtools::test(filter = "smk-|disc|arg")` and check it passes
- [ ] Run `devtools::check(args = '--no-tests')` and check it passes (we run tests separately to skip performance checks)
- [ ] Run `devtools::build()` and check it builds without errors

## Instructions & checklist for PR reviewers
- [ ] Checkout this branch as well as the corresponding branch of dsBase
- [ ] Review the code and suggest any changes
- [ ] Install the dsBase branch on an Armadillo or Opal test server
- [ ] Run `devtools::test(filter = "smk-|disc|arg")` and check it passes
- [ ] Run `devtools::check(args = '--no-tests')` and check it passes (we run tests separately to skip performance checks)
- [ ] Run `devtools::build()` and check it builds without errors
