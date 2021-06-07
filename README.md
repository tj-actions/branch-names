## branch-names

[![CI](https://github.com/tj-actions/branch-names/workflows/CI/badge.svg)](https://github.com/tj-actions/branch-names/actions?query=workflow%3ACI) [![Update release version.](https://github.com/tj-actions/branch-names/actions/workflows/sync-release-version.yml/badge.svg)](https://github.com/tj-actions/branch-names/actions/workflows/sync-release-version.yml) [![Public workflows that use this action.](https://img.shields.io/endpoint?url=https%3A%2F%2Fapi-tj-actions1.vercel.app%2Fapi%2Fgithub-actions%2Fused-by%3Faction%3Dtj-actions%2Fbranch-names%26badge%3Dtrue)](https://github.com/search?o=desc\&q=tj-actions+branch-names%3A.github%2Fworkflows+language%3AYAML\&s=\&type=Code)

Get branch or tag information without the `/ref/*` prefix

## Outputs

|   Output             |    type      |  Example                    |  Description                                                      |
|:--------------------:|:------------:|:---------------------------:|:-----------------------------------------------------------------:|
|  is_default          |  `boolean`   |  `true` *OR* `false`        |  Detects wheter the action is running on a default branch         |
|  is_tag              |  `boolean`   |  `true` *OR* `false`        |  Detects wheter the action is running on a tag branch             |
|  current_branch      |  `string`    |  `main` *OR* `feature/test` |  Always returns a valid branch name for a triggered workflow run. |
|  base_ref_branch     |  `string`    |  `main`                     |  The target branch of a pull request                              |
|  head_ref_branch     |  `string`    |  `feature/test`             |  The source branch of a pull request                              |
|  ref_branch          |  `string`    |  `1/merge` *OR* `main`      |  The branch that triggered the workflow run                       |
|  tag                 |  `string`    |  `v0.0.1` *OR* `0.0.1`      |  The tag that triggered the workflow run                          |

## Inputs

| Input             |   type    |  default | Description             |
|:-----------------:|:---------:|:--------:|:-----------------------:|
| strip_tag_prefix  |  `string` |    `''`  | The tag prefix to strip <br> *i.e `v0.0.1` -> `v` -> `0.0.1`*  |

## Usage

```yaml
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
      
...
    steps:
      - name: Get branch names
        id: branch-name
        uses: tj-actions/branch-names@v4.3
        
      - name: Current branch name
        if: github.event_name == 'push'
        run: |
          echo "${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "main" the branch that triggered the push event.

      - name: Current branch name
        if: github.event_name == 'pull_request'
        run: |
          echo "${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "feature/test" the current PR branch.
```

## Examples

```yaml
...
    steps:
      - name: Get branch names
        id: branch-name
        uses: tj-actions/branch-names@v4.3

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
     
      - name: Running on a tag branch.
        if: steps.branch-name.outputs.is_tag == 'true'
        run: |
          echo "Running on tag: ${{ steps.branch-name.outputs.tag }}"
        # Outputs: "Running on tag: v0.0.1".
      
      - name: Running on a non tag based branch and the default branch.
        if: steps.branch-name.outputs.is_tag == 'false' && steps.branch-name.outputs.is_default == 'true'
        run: |
          echo "Running on branch: ${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "Running on branch: main".
        
      - name: Running on a non tag based branch and a PR branch.
        if: steps.branch-name.outputs.is_tag == 'false' && steps.branch-name.outputs.is_default == 'false'
        run: |
          echo "Running on branch: ${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "Running on branch: feature/test".
      
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
        uses: tj-actions/branch-names@v4.3
      - uses: actions/checkout@v2
        with:
          ref: ${{ steps.branch-names.outputs.base_ref_branch }}
```

*   Free software: [MIT license](LICENSE)

If you feel generous and want to show some extra appreciation:

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

[buymeacoffee]: https://www.buymeacoffee.com/jackton1

[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png

## Credits

This package was created with [Cookiecutter](https://github.com/cookiecutter/cookiecutter).

## Report Bugs

Report bugs at https://github.com/tj-actions/branch-names/issues.

If you are reporting a bug, please include:

*   Your operating system name and version.
*   Any details about your workflow that might be helpful in troubleshooting.
*   Detailed steps to reproduce the bug.
