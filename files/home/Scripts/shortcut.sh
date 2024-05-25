#!/usr/bin/env bash

# shellcheck disable=SC2015
[ -z "$1" ] && exit 1 || echo "key $1" | dotool
