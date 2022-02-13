## branch-names

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/36f9e8c5e9664e0bacc7df558c13f349)](https://app.codacy.com/gh/tj-actions/branch-names?utm_source=github.com\&utm_medium=referral\&utm_content=tj-actions/branch-names\&utm_campaign=Badge_Grade_Settings)
[![CI](https://github.com/tj-actions/branch-names/workflows/CI/badge.svg)](https://github.com/tj-actions/branch-names/actions?query=workflow%3ACI) [![Update release version.](https://github.com/tj-actions/branch-names/actions/workflows/sync-release-version.yml/badge.svg)](https://github.com/tj-actions/branch-names/actions/workflows/sync-release-version.yml) [![Public workflows that use this action.](https://img.shields.io/endpoint?url=https%3A%2F%2Fused-by.vercel.app%2Fapi%2Fgithub-actions%2Fused-by%3Faction%3Dtj-actions%2Fbranch-names%26badge%3Dtrue)](https://github.com/search?o=desc\&q=tj-actions+branch-names+language%3AYAML\&s=\&type=Code)

[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?logo=ubuntu\&logoColor=white)](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on)
[![Mac OS](https://img.shields.io/badge/mac%20os-000000?logo=macos\&logoColor=F0F0F0)](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on)
[![Windows](https://img.shields.io/badge/Windows-0078D6?logo=windows\&logoColor=white)](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on)

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->

Get branch or tag information without the `/ref/*` prefix

## Features

*   Retrieve the current branch name without any prefix. (e.g. `'refs/heads/main'` -> `'main'`)
*   Retrieve the current tag with an option to strip the "v" prefix (e.g. `'refs/tags/v1.0.0'` -> `'v1.0.0'` OR `'1.0.0'`)
*   Detect actions triggered by non default branches
*   Detect actions triggered by the default branch
*   Supports all valid [git branch names](https://wincent.com/wiki/Legal_Git_branch_names)

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
      - name: Get branch name
        id: branch-name
        uses: tj-actions/branch-names@v5.1
        
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
```

If you feel generous and want to show some extra appreciation:

Support this project with a :star:

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

[buymeacoffee]: https://www.buymeacoffee.com/jackton1

[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png

## Outputs

|   Output             |    type      |  Example                    |  Description                                                      |
|:--------------------:|:------------:|:---------------------------:|:-----------------------------------------------------------------:|
|  is\_default          |  `boolean`   |  `true` *OR* `false`        |  Detects wheter the workflow is running on a default branch         |
|  is\_tag              |  `boolean`   |  `true` *OR* `false`        |  Detects wheter the workflow is running on a tag branch             |
|  current\_branch      |  `string`    |  `main` *OR* `feature/test` *OR* `v0.0.1` |  Always returns a valid branch name for a triggered workflow run. |
|  base\_ref\_branch     |  `string`    |  `main`                     |  The target branch of a pull request                              |
|  head\_ref\_branch     |  `string`    |  `feature/test`             |  The source branch of a pull request                              |
|  ref\_branch          |  `string`    |  `1/merge` *OR* `main`      |  The branch that triggered the workflow run                       |
|  tag                 |  `string`    |  `v0.0.1` *OR* `0.0.1`      |  The tag that triggered the workflow run                          |

## Inputs

| Input             |   type    |  default | Description             |
|:-----------------:|:---------:|:--------:|:-----------------------:|
| strip\_tag\_prefix  |  `string` |    `''`  | The tag prefix to strip <br> *i.e `v0.0.1` -> `v` -> `0.0.1`*  |

## Events

*   `push*`

```yaml
on:
  push:
    branches:
      - main

...
    steps:
      - name: Get branch names
        id: branch-name
        uses: tj-actions/branch-names@v5.1

      - name: Current branch name
        run: |
          echo "${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "main" the branch that triggered the push event.

      - name: Running on the default branch.
        if: steps.branch-name.outputs.is_default == 'true'
        run: |
          echo "Running on default: ${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "Running on default: main".
      
      - name: Running on the default branch (i.e non tag based branch).
        if: steps.branch-name.outputs.is_tag == 'false' && steps.branch-name.outputs.is_default == 'true'
        run: |
          echo "Running on branch: ${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "Running on branch: main".
      
      - name: Get Ref brach name
        run: |
          echo "${{ steps.branch-name.outputs.ref_branch }}"
        #  Outputs: "main"
```

*   `pull_request*`

```yaml
on:
  pull_request:
    branches:
      - main

...
    steps:
      - name: Get branch names
        id: branch-name
        uses: tj-actions/branch-names@v5.1
      
      - name: Current branch name
        run: |
          echo "${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "feature/test" current PR branch.

      - name: Running on a non tag based branch and a PR branch.
        if: steps.branch-name.outputs.is_default == 'false'
        run: |
          echo "Running on branch: ${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "Running on branch: feature/test".
      
      - name: Running on a pull request (i.e non tag based branch).
        if: steps.branch-name.outputs.is_tag == 'false' && steps.branch-name.outputs.is_default == 'false'
        run: |
          echo "Running on branch: ${{ steps.branch-name.outputs.current_branch }}"
        # Outputs: "Running on branch: feature/test".
      
      - name: Get Ref brach name
        run: |
          echo "${{ steps.branch-name.outputs.ref_branch }}"
        #  Outputs: "1/merge"

      - name: Get Head Ref branch name (i.e The current pull request branch)
        run: |
          echo "${{ steps.branch-name.outputs.head_ref_branch }}"
        # Outputs: "feature/test" current PR branch.

      - name: Get Base Ref branch name (i.e The target of a pull request.)
        run: |
          echo "${{ steps.branch-name.outputs.base_ref_branch }}"
        # Outputs: "main".
```

*   `tag*`

```yaml
on:
  push:
    tags:
      - '*'

...
    steps:
      - name: Get branch names
        id: branch-name
        uses: tj-actions/branch-names@v5.1
     
      - name: Running on a tag branch.
        if: steps.branch-name.outputs.is_tag == 'true'
        run: |
          echo "Running on: ${{ steps.branch-name.outputs.tag }}"
        # Outputs: "Running on: v0.0.1".
        
      - name: Get the current tag
        if: steps.branch-name.outputs.is_tag == 'true'  # Replaces: startsWith(github.ref, 'refs/tags/')
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
        uses: tj-actions/branch-names@v5.1
      - uses: actions/checkout@v2
        with:
          ref: ${{ steps.branch-names.outputs.head_ref_branch }}
```

*   Free software: [MIT license](LICENSE)

## Credits

This package was created with [Cookiecutter](https://github.com/cookiecutter/cookiecutter).

## Report Bugs

Report bugs at https://github.com/tj-actions/branch-names/issues.

If you are reporting a bug, please include:

*   Your operating system name and version.
*   Any details about your workflow that might be helpful in troubleshooting.
*   Detailed steps to reproduce the bug.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->

<!-- prettier-ignore-start -->

<!-- markdownlint-disable -->

<table>
  <tr>
    <td align="center"><a href="https://github.com/loarca"><img src="https://avatars.githubusercontent.com/u/22898638?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Alejandro Loarca</b></sub></a><br /><a href="https://github.com/tj-actions/branch-names/commits?author=loarca" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->

<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
