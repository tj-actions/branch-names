#!/usr/bin/env bash

set -e

echo "::set-output name=base_ref_branch::${INPUT_BASE_REF/refs\/heads\//}"
echo "::set-output name=head_ref_branch::${INPUT_HEAD_REF/refs\/heads\//}"
echo "::set-output name=ref_branch::${INPUT_REF/refs\/heads\//}"
