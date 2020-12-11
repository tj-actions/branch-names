#!/usr/bin/env bash

set -e

echo "::set-output name=base_ref_branch::${0/refs\/heads\//}"
echo "::set-output name=head_ref_branch::${1/refs\/heads\//}"
echo "::set-output name=ref_branch::${2/refs\/heads\//}"
