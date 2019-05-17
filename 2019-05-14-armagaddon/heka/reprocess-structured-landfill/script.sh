#!/bin/bash
# NOTE, need to patch
# https://github.com/mozilla-services/lua_sandbox_extensions/blob/master/moz_telemetry/io_modules/moz_telemetry/s3.lua#L169
# before running this because there's a "-" in the "host" partition for structured ingestion
set -e

# We need to run a hindsight job for each day (instead of a single hindsight
# job for all days) because the s3 output only supports writing partitions
# based on fields, and submission date (derived from Timestamp) isn't a field
# for raw messages.
for date in $(seq 20190504 20190511) ; do
  sed "s/FIXME/$date/" landfill.json.tmp > landfill.json
  sed "s/FIXME/$date/" hindsight/run/output/telemetry_s3.cfg.tmp > hindsight/run/output/telemetry_s3.cfg
  cd hindsight
  hindsight_cli hindsight.cfg 7
  cd ..
  rm -rf /media/ephemeral0/hindsight_output
  rm -f hindsight/run/input/landfill*cfg
done
# stage it somewhere
aws s3 sync /media/ephemeral0/split_out/ s3://net-mozaws-prod-us-west-2-pipeline-data-test/landfill-3/generic-incoming.telemetry.mozilla.org_other/
