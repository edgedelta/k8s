#!/usr/bin/env bash

# This script updates helm chart yaml app and chart version as given tag parameter
export tag=$1 # export to refer in bash -c subshell below
if [ -z "$tag" ]; then
  echo "Tag parameter not given, exiting"
  exit 2
fi

# App version will be in vX.Y.Z format and refer to docker image in public repo.
# Update all {VERSION} fields in tmpl.yml files in the directory. @ is the original file name from xargs
find *.yml.tmpl | xargs -I@ bash -c '\
  tmplt="@";\
  result=${tmplt%.tmpl};\
  cat $tmplt | sed "s/{VERSION}/${tag}/g" > $result'
