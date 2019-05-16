#!/bin/bash

. ./list_impacted_partitions.sh | gsutil -m rm -Ir
