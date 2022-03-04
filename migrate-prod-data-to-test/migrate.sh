#!/bin/bash
echo

# download production data 
echo "Downloading production data..."
timeout $TIMEOUT aws s3 cp s3://treetracker-production-batch-uploads ./prod/ \
    --profile $PROD_AWS_PROFILE \
    --recursive --exclude '*' --include '2022.*'

echo
echo

# send data to test environment
echo "Uploading production data to test..."
aws s3 cp --profile $TEST_AWS_PROFILE \
  prod/ s3://treetracker-test-batch-uploads --recursive

#initiate cron job
echo
echo "Create cron job..."
. create-cron-job.sh


