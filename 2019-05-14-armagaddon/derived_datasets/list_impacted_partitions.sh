#!/bin/bash
gsutil -m ls -d s3://telemetry-parquet/addons/agg/v2/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/addons/v2/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/clients_daily/v6/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/crash_summary/v1/submission_date=2019-05-{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/events/v1/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/first_shutdown_summary/v4/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/sanitized-landfill-sample/v3/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/longitudinal/v201905{04,11}
gsutil -m ls -d s3://telemetry-parquet/main_summary/v4/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-backfill/main_summary/v4/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/experiments/v1/experiment_id={activity-stream-pktnewtabH12019-release66layoutstest1,pref-flip-activity-stream-pktnewtabH12019-release66smoketest2-1539671,prefflip-webrender-v1-3-1492568,cookie-restrictions-strict-list-study@shield.mozilla.org,federated-learning-v2@shield.mozilla.org,etp-impact-on-a-custom-distribution-1543443,etp-search-volume-study@shield.mozilla.org}/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/search_clients_daily/v4/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/sync_summary/v2/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/sync_flat_summary/v1/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
gsutil -m ls -d s3://telemetry-parquet/sync_events/v1/submission_date_s3=201905{0{4,5,6,7,8,9},10,11}
