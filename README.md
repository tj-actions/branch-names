## branch-names

[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge\&logo=ubuntu\&logoColor=white)](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on)
[![Mac OS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge\&logo=macos\&logoColor=F0F0F0)](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on)
[![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge\&logo=windows\&logoColor=white)](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on)
[![Public workflows that use this action.](https://img.shields.io/endpoint?style=for-the-badge\&url=https%3A%2F%2Fused-by.vercel.app%2Fapi%2Fgithub-actions%2Fused-by%3Faction%3Dtj-actions%2Fbranch-names%26badge%3Dtrue%26package_id%3DUGFja2FnZS0yOTQyNTYxMTIz)](https://github.com/search?o=desc\&q=tj-actions+branch-names+language%3AYAML\&s=\&type=Code)

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/4df2ae51586b43f1bfd26e1aedc69965)](https://app.codacy.com/gh/tj-actions/branch-names/dashboard?utm_source=gh\&utm_medium=referral\&utm_content=\&utm_campaign=Badge_grade)
[![CI](https://github.com/tj-actions/branch-names/workflows/CI/badge.svg)](https://github.com/tj-actions/branch-names/actions?query=workflow%3ACI)
[![Update release version.](https://github.com/tj-actions/branch-names/actions/workflows/sync-release-version.yml/badge.svg)](https://github.com/tj-actions/branch-names/actions/workflows/sync-release-version.yml)

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->

Get a branch or tag name without the `/ref/*` prefix.

## Table of Contents

*   [Features](#features)
*   [Usage](#usage)
*   [Inputs](#inputs)
*   [Outputs](#outputs)
*   [Events](#events)
    *   [`push*`](#push)
    *   [`pull_request*`](#pull_request)
    *   [`tag*`](#tag)
    *   [Other supported events](#other-supported-events)
    *   [Possible usage with actions/checkout](#possible-usage-with-actionscheckout)
*   [Credits](#credits)
*   [Report Bugs](#report-bugs)
*   [Contributors ✨](#contributors-)

## Features

*   Retrieve the current branch name without any prefix. (e.g. `'refs/heads/main'` -> `'main'`)
*   Retrieve the current tag with an option to strip the prefix (e.g. `v0.0.1` -> `v` -> `0.0.1`)
*   Detect actions triggered by non default branches
*   Detect actions triggered by the default branch
*   Supports all valid [git branch names](https://wincent.com/wiki/Legal_Git_branch_names)

## Usage

```yaml
...

    steps:
      - name: Get branch names.
        id: branch-names
        uses: tj-actions/branch-names@v8
        
      - name: Running on the default branch.
        if: steps.branch-names.outputs.is_default == 'true'
        run: |
          echo "Running on default: ${{ steps.branch-names.outputs.current_branch }}" 
        # Outputs: "Running on default: main"
      
      - name: Running on a pull request branch.
        if: steps.branch-names.outputs.is_default == 'false'
        run: |
          echo "Running on pr: ${{ steps.branch-names.outputs.current_branch }}"
        # Outputs: "Running on pr: feature/test"
      
      - name: Running on a pull request branch.
        if: steps.branch-names.outputs.is_default == 'false'
        run: |
          echo "Base branch: ${{ steps.branch-names.outputs.base_ref_branch }}"
        # Outputs: "Base branch: main"
        
      - name: Running on any event.
        run: |
          echo "Default branch: ${{ steps.branch-names.outputs.default_branch }}"
        # Outputs: "Default branch: main"
```

If you feel generous and want to show some extra appreciation:

Support this project with a :star:

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

[buymeacoffee]: https://www.buymeacoffee.com/jackton1

[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png

## Inputs

<!-- AUTO-DOC-INPUT:START - Do not remove or modify this section -->

```yaml
- uses: tj-actions/branch-names@v9
  id: branch-names
  with:
    # Replace forward slashes with hyphens 
    # in branch names e.g. `feature/test` 
    # -> `feature-test` 
    # Type: boolean
    # Default: "false"
    replace_slashes_with_hyphens: ''

    # The prefix that should be 
    # stripped from the branch e.g. 
    # `release/` -> with a branch 
    # `release/1.0` -> returns `1.0` 
    # Type: string
    strip_branch_prefix: ''

    # The prefix that should be 
    # stripped from the tag e.g. 
    # `v` -> with a tag 
    # `v0.0.1` -> returns `0.0.1` 
    # Type: string
    strip_tag_prefix: ''

```

<!-- AUTO-DOC-INPUT:END -->

## Outputs

<!-- AUTO-DOC-OUTPUT:START - Do not remove or modify this section -->

|                                     OUTPUT                                      |  TYPE  |                                   DESCRIPTION                                    |
|---------------------------------------------------------------------------------|--------|----------------------------------------------------------------------------------|
| <a name="output_base_ref_branch"></a>[base\_ref\_branch](#output_base_ref_branch) | string |          The target branch of a <br>pull request or tag e.g <br>`main`           |
|  <a name="output_current_branch"></a>[current\_branch](#output_current_branch)   | string | The current branch name regardless <br>of event\_type e.g `main`, `feature/test`  |
|  <a name="output_default_branch"></a>[default\_branch](#output_default_branch)   | string |               The default branch name e.g <br>`main` OR `master`                 |
| <a name="output_head_ref_branch"></a>[head\_ref\_branch](#output_head_ref_branch) | string |           The source branch of a <br>pull request e.g `feature/test`             |
|        <a name="output_is_default"></a>[is\_default](#output_is_default)         | string |  Returns `"true"` if the current <br>branch is the default else <br>`"false"`.   |
|              <a name="output_is_tag"></a>[is\_tag](#output_is_tag)               | string |     Returns `"true"` if the current <br>branch is a tag else <br>`"false"`.      |
|        <a name="output_ref_branch"></a>[ref\_branch](#output_ref_branch)         | string |      The branch that triggered the <br>workflow run. e.g `1/merge`, `main`       |
|                   <a name="output_tag"></a>[tag](#output_tag)                   | string |       The tag that triggered the <br>workflow run. e.g `v0.0.1`, `0.0.1`         |

<!-- AUTO-DOC-OUTPUT:END -->

## Events

### `push*`

```yaml
on:
  push:
    branches:
      - main

...
    steps:
      - name: Get branch names
        id: branch-names
        uses: tj-actions/branch-names@v8

      - name: Current branch names
        run: |
          echo "${{ steps.branch-names.outputs.current_branch }}"
        # Outputs: "main" the branch that triggered the push event.

      - name: Running on the default branch.
        if: steps.branch-names.outputs.is_default == 'true'
        run: |
          echo "Running on default: ${{ steps.branch-names.outputs.current_branch }}"
        # Outputs: "Running on default: main".
      
      - name: Running on the default branch (i.e non tag based branch).
        if: steps.branch-names.outputs.is_tag == 'false' && steps.branch-names.outputs.is_default == 'true'
        run: |
          echo "Running on branch: ${{ steps.branch-names.outputs.current_branch }}"
        # Outputs: "Running on branch: main".
      
      - name: Get Ref brach name
        run: |
          echo "${{ steps.branch-names.outputs.ref_branch }}"
        #  Outputs: "main"
      
      - name: Default branch name
        run: |
          echo "${{ steps.branch-names.outputs.default_branch }}"
        # Outputs: "main" the default branch.
```

### `pull_request*`

```yaml
on:
  pull_request:
    branches:
      - main

...
    steps:
      - name: Get branch names
        id: branch-names
        uses: tj-actions/branch-names@v8
      
      - name: Current branch names
        run: |
          echo "${{ steps.branch-names.outputs.current_branch }}"
        # Outputs: "feature/test" current PR branch.

      - name: Running on a non tag based branch and a PR branch.
        if: steps.branch-names.outputs.is_default == 'false'
        run: |
          echo "Running on branch: ${{ steps.branch-names.outputs.current_branch }}"
        # Outputs: "Running on branch: feature/test".
      
      - name: Running on a pull request (i.e non tag based branch).
        if: steps.branch-names.outputs.is_tag == 'false' && steps.branch-names.outputs.is_default == 'false'
        run: |
          echo "Running on branch: ${{ steps.branch-names.outputs.current_branch }}"
        # Outputs: "Running on branch: feature/test".
      
      - name: Get Ref branch name
        run: |
          echo "${{ steps.branch-names.outputs.ref_branch }}"
        #  Outputs: "1/merge"

      - name: Get Head Ref branch names (i.e The current pull request branch)
        run: |
          echo "${{ steps.branch-names.outputs.head_ref_branch }}"
        # Outputs: "feature/test" current PR branch.

      - name: Get Base Ref branch names (i.e The target of a pull request.)
        run: |
          echo "${{ steps.branch-names.outputs.base_ref_branch }}"
        # Outputs: "main".
      
      - name: Default branch names
        run: |
          echo "${{ steps.branch-names.outputs.default_branch }}"
        # Outputs: "main" the default branch.
```

### `tag*`

```yaml
on:
  push:
    tags:
      - '*'

...
    steps:
      - name: Get branch names
        id: branch-names
        uses: tj-actions/branch-names@v8
        with:
          strip_tag_prefix: v # Optionally strip the leading `v` from the tag.
     
      - name: Running on a tag branch.
        if: steps.branch-names.outputs.is_tag == 'true'
        run: |
          echo "Running on: ${{ steps.branch-names.outputs.tag }}"
        # Outputs: "Running on: 0.0.1".
        
      - name: Get the current tag
        if: steps.branch-names.outputs.is_tag == 'true'  # Replaces: startsWith(github.ref, 'refs/tags/')
        run: |
          echo "${{ steps.branch-names.outputs.tag }}"
        # Outputs: "0.0.1"
```

### Other supported events

See [.github/workflows/test.yml](https://github.com/tj-actions/branch-names/blob/main/.github/workflows/test.yml) for more examples.

### Possible usage with [actions/checkout](https://github.com/actions/checkout)

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
        uses: tj-actions/branch-names@v8
      - uses: actions/checkout@v4
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
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/loarca"><img src="https://avatars.githubusercontent.com/u/22898638?v=4?s=100" width="100px;" alt="Alejandro Loarca"/><br /><sub><b>Alejandro Loarca</b></sub></a><br /><a href="https://github.com/tj-actions/branch-names/commits?author=loarca" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://ianwoodard.me"><img src="https://avatars.githubusercontent.com/u/17186604?v=4?s=100" width="100px;" alt="Ian Woodard"/><br /><sub><b>Ian Woodard</b></sub></a><br /><a href="https://github.com/tj-actions/branch-names/commits?author=IanWoodard" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://home.boidol.dev/"><img src="https://avatars.githubusercontent.com/u/652404?v=4?s=100" width="100px;" alt="Raphael Boidol"/><br /><sub><b>Raphael Boidol</b></sub></a><br /><a href="https://github.com/tj-actions/branch-names/commits?author=boidolr" title="Documentation">📖</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->

<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
