CI/CD
=====


Workflows
---------

- `check-all`

  Run tests on all commits

- `check`

  Run tests


Helper Actions
--------------

- `checkout`

  Checkout project code

- `status-get`

  Get commit status

- `status-set`

  Set commit status (or skip if status already set)

- `status-inherit`

  Inherit status from parent commits

- `dispatch-check`

  Dispatch `check` workflow run


Build Actions
-------------

- `make-test`

  Run tests

- `make-lint`

  Run formatters and linters
