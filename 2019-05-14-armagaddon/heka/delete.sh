#!/bin/bash
# think long and hard before running this script
exec &> >(tee -a "delete.log")

find deletion -name '*.json' | \
  xargs -P16 -I {} -n1 \
  aws s3api delete-objects --bucket net-mozaws-prod-us-west-2-pipeline-data --delete file://{}
