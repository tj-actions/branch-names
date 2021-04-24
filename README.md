branch-names
------------

[![CI](https://github.com/tj-actions/branch-names/workflows/CI/badge.svg)](https://github.com/tj-actions/branch-names/actions?query=workflow%3ACI) [![Update release version.](https://github.com/tj-actions/branch-names/actions/workflows/sync-release-version.yml/badge.svg)](https://github.com/tj-actions/branch-names/actions/workflows/sync-release-version.yml) <a href="https://github.com/search?q=tj-actions+branch-names+path%3A.github%2Fworkflows+language%3AYAML&type=code" target="_blank" title="Public workflows that use this action."><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fapi-git-master.endbug.vercel.app%2Fapi%2Fgithub-actions%2Fused-by%3Faction%3Dtj-actions%2Fbranch-names%26badge%3Dtrue" alt="Public workflows that use this action."></a>

Get branch or tag information without the `/ref/*` prefix

## Outputs

|   Output             |    type      |  Example                    |  Description                                                      |
|:--------------------:|:------------:|:---------------------------:|:-----------------------------------------------------------------:|
|  is_default          |  `boolean`   |  `true` *OR* `false`        |  Detects wheter the action is running on a default branch         |
|  current_branch      |  `string`    |  `main` *OR* `feature/test` |  Always returns a valid branch name for a triggered workflow run. |
|  base_ref_branch     |  `string`    |  `main`                     |  The target branch of a pull request                              |
|  head_ref_branch     |  `string`    |  `feature/test`             |  The source branch of a pull request                              |
|  ref_branch          |  `string`    |  `1/merge` *OR* `main`      |  The branch that triggered the workflow run                       |
|  tag                 |  `string`    |  `v0.0.1` *OR* `0.0.1`        |  The tag that triggered the workflow run                          |


## Usage 

```yaml
...
    steps:
      - uses: actions/checkout@v2
      - name: Get branch names
        id: branch-name
        uses: tj-actions/branch-names@v3
```

## Examples

```yaml
...
    steps:
      - uses: actions/checkout@v2
      - name: Get branch names
        id: branch-name
        uses: tj-actions/branch-names@v3
        
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
        # Outputs: "main" the branch that triggered the push event.
      
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
        
      - name: Get the current tag
        if: startsWith(github.ref, 'refs/tags/')
        run: |
          echo "${{ steps.branch-name.outputs.tag }}"
        # Outputs: "v0.0.1" OR "0.0.1"
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
        uses: tj-actions/branch-names@v3
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
