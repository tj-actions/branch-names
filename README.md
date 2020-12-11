branch-name
-----------

Get branch information without the `/ref/*` prefix

```yaml
...
    steps:
      - uses: actions/checkout@v2
      - name: Get branch names
        uses: tj-actions/branch-names@v1
        id: branch-names
      - name: Get Ref brach name
        run: |
          echo "${{ steps.branch-name.outputs.ref_branch }}"  #  Outputs: "main"

      - name: Get Head Ref branch name
        if: github.event_name == 'pull_request'
        run: |
          echo "${{ steps.branch-name.outputs.head_ref_branch }}"  # Outputs: "feature/test"

      - name: Get Base Ref branch name
        if: github.event_name == 'pull_request'
        run: |
          echo "${{ steps.branch-name.outputs.base_ref_branch }}"  # Outputs: "1/merge"
```


## Inputs

|   Input       |    type    |  required     |  default             | 
|:-------------:|:-----------:|:-------------:|:---------------------:|
| token         |  `string`   |    `false`    | `${{ github.token }}` |




## Outputs

|   Output             |    type     |  Example          | 
|:--------------------:|:-----------:|:-----------------:|
|  ref_branch          |  `string`   |    `main`         |
|  head_ref_branch     |  `string`   |    `feature/test` |
|  base_ref_branch     |  `string`   |    `1/merge`      |



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
