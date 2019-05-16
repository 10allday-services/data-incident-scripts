#!/bin/bash
# affected time periods
source matchers

# generate regular expressions matching dates in the affected period
./generate_dates > dates
# list all prefixes for which data exists that needs to be deleted
./generate_candidate_prefixes < dates > candidates
# generate full listings for each relevant prefix
./generate_object_listing < candidates
# filter to appName=Firefox (where relevant)
mkdir -p filtered_fx
for file in listing/* ; do
  ./filter_fx $file > filtered_fx/$(basename ${file})
done
# filter to affected period
mkdir -p filtered_time
for file in filtered_fx/* ; do
  ./filter_time $file > filtered_time/$(basename ${file})
done
# filter to edge cases (a subset of the former, but potentially useful for
# reprocessing)
mkdir -p edge_cases
for file in filtered_time/* ; do
  ./filter_edge_cases $file > edge_cases/$(basename ${file})
done

# create api batch delete json blobs
mkdir -p deletion
for file in filtered_time/* ; do
  dir=deletion/$(basename ${file})
  mkdir -p ${dir}
  cd ${dir}
  ../../generate_batches ../../${file}
  cd ../..
done
