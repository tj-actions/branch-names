branch-name
-----------

Get branch information without the `/ref/heads` prefix

```yaml
...
    steps:
      - uses: actions/checkout@v2
      - name: Get branch name
        uses: tj-actions/branch-name@v1
        id: branch-name
      - name: Get brach Names
        run: |
          echo "${{ steps.branch-name.outputs.base_ref_branch }}"
          echo "${{ steps.branch-name.outputs.head_ref_branch }}"
          echo "${{ steps.branch-name.outputs.ref_branch }}"
```


## Inputs

|   Input       |    type    |  required     |  default             | 
|:-------------:|:-----------:|:-------------:|:---------------------:|
| token         |  `string`   |    `false`    | `${{ github.token }}` |



* Free software: [MIT license](LICENSE)


Credits
-------

This package was created with [Cookiecutter](https://github.com/cookiecutter/cookiecutter).



Report Bugs
-----------

Report bugs at https://github.com/tj-actions/branch-name/issues.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your workflow that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.
