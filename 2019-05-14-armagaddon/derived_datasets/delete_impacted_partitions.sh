#!/bin/bash

## This didn't work, we don't know why
# . ./list_impacted_partitions.sh | gsutil -m rm -I

# in retrospect all of the derived datasets scripts would have been better using this
bash -ex ./list_impacted_partitions.sh > impacted_partitions.txt

## This didn't work either, also unclear why
# gsutil -m rm -r $(cat impacted_partitions.txt)

## This worked but was slower than the commands below and also suffered from leaving one file behind on first run
# cat impacted_partitions.txt | xargs -P10 -n1 gsutil -m rm -r

# This is worked best and was the final commands run
# run it multiple times because it commonly misses one file
sed 's,/$,/**,' | gsutil -m rm -I
sed 's,/$,/**,' | gsutil -m rm -I
sed 's,/$,/**,' | gsutil -m rm -I
