
# TODO

- `.github/workflows/mage-os-integration-tests.yml`

- `build_scripts/run_setup_install.sh`
- `.github/action/integration-tests-mage-os/action.yml`
    `build_scripts/build_integration_tests_config.sh`

- fix this: https://github.com/adamzero1/mageos-magento2/actions/runs/6213252740/job/16864174830
- nx clean up / refactor

# Done
- .github/action/setup-mage-os/action.yml => .github/action/setup-warden-environment/action.yml
    - `build_scripts/generate_warden_env.sh`
- .github/workflows/integration-tests.yml
- composer install test.yml
- `.github/workflows/mage-os-setup-in-warden.yml` - this looks like a "magento install test". Which is a valid test, might be better as it's own test?

## current plan

- [ ] get it working
- [ ] move all the actions to the correct locations
  - integration tests
    infra repo?

  - composer install tests
    do in another iteration
  - install tests
    do in another iteration

  - setup warden env
  - warden integration tests
  ^^ https://github.com/adamzero1/mageos-magento2/tree/nx-integration-tests/.github/action/warden
  submit to warden repo

