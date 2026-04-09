#!/usr/bin/env bash
# DigitalOcean Spaces: create the bucket in the control panel, then create API keys with doctl.
#
# 1) Create a Space (bucket) in your region: https://cloud.digitalocean.com/spaces
#    Use a globally unique bucket name; set MINIO_BUCKET in .do/app-api.yaml to match.
# 2) Point MINIO_ENDPOINT to "<region>.digitaloceanspaces.com" and MINIO_REGION to that region slug (e.g. nyc3).
# 3) Create a key with read/write access to that bucket, for example:
#
#   doctl spaces keys create primerpeso-spaces-key \
#     --grants 'bucket=YOUR_BUCKET_NAME;permission=readwrite'
#
# Use the access key and secret as MINIO_ACCESS_KEY and MINIO_SECRET_KEY on the API app.
set -euo pipefail

echo "See comments in this script — Spaces buckets are created in the UI; keys use doctl spaces keys create."
