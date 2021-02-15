branch-names
------------

[![CI](https://github.com/tj-actions/branch-names/workflows/CI/badge.svg)](https://github.com/tj-actions/branch-names/actions?query=workflow%3ACI)

Get branch information without the `/ref/*` prefix

## Outputs

|   Output             |    type      |  Example                    |  Description                                                      |
|:--------------------:|:------------:|:---------------------------:|:-----------------------------------------------------------------:|
|  is_default          |  `boolean`   |  `true` *OR* `false`        |  Detects wheter the action is running on a default branch         |
|  current_branch      |  `string`    |  `main` *OR* `feature/test` |  Always returns a valid branch name for a triggered workflow run. |
|  base_ref_branch     |  `string`    |  `main`                     |  The target branch of a pull request                              |
|  head_ref_branch     |  `string`    |  `feature/test`             |  The source branch of a pull request                              |
|  ref_branch          |  `string`    |  `1/merge` *OR* `main`      |  The branch that triggered the workflow run                       |


## Usage 

```yaml
...
    steps:
      - uses: actions/checkout@v2
      - name: Get branch names
        id: branch-name
        uses: tj-actions/branch-names@v2.2
        
      - name: Running on the default branch.
        if: steps.branch-name.outputs.is_default == 'true'
        run: |
          echo "Running on default: ${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "Running on default: main".
      
      - name: Running on a pull request branch.
        if: steps.branch-name.outputs.is_default == 'false'
        run: |
          echo "Running on pr: ${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "Running on pr: feature/test".
      
      - name: Current branch name
        if: github.event_name == 'pull_request'
        run: |
          echo "${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "feature/test" current PR branch.
      
      - name: Current branch name
        if: github.event_name == 'push'
        run: |
          echo "${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "main" the default branch that triggered the push event.
      
      - name: Get Ref brach name
        run: |
          echo "${{ steps.branch-name.outputs.ref_branch }}"
        #  Outputs: "main" for non PR branches | "1/merge" for a PR branch

      - name: Get Head Ref branch name
        if: github.event_name == 'pull_request'
        run: |
          echo "${{ steps.branch-name.outputs.head_ref_branch }}"
        # Outputs: "feature/test" current PR branch.

      - name: Get Base Ref branch name
        if: github.event_name == 'pull_request'
        run: |
          echo "${{ steps.branch-name.outputs.base_ref_branch }}"
        # Outputs: "main" for main <- PR branch.
      
```


### Possible usage with [actions/checkout@v2](https://github.com/actions/checkout):

```yaml
on:
  pull_request:
    branches:
      - develop
    
 jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Get branch names.
        id: branch-names
        uses: tj-actions/branch-names@v2.2
      - uses: actions/checkout@v2
        with:
          ref: ${{ steps.branch-names.outputs.base_ref_branch }}
```


* Free software: [MIT license](LICENSE)


Credits
-------

This package was created with [Cookiecutter](https://github.com/cookiecutter/cookiecutter).



Report Bugs
-----------

Report bugs at https://github.com/tj-actions/branch-names/issues.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your workflow that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.
