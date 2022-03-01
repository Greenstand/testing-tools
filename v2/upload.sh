#!/bin/bash
set -e

generate_uuid() {
  echo $(python3 scripts/uuid4.py)
}

MESSAGE_UUID=$(generate_uuid)
SURVEY_UUID=$(generate_uuid)
DEVICE_CONFIGURATION_UUID=$(generate_uuid)
CAPTURE_UUID=$(generate_uuid)
SESSION_UUID=$(generate_uuid)
WALLET_REGISTRATION_UUID=$(generate_uuid)
EPOCH=$(python3 scripts/iso8601.py)

printf "%30s %s\n" "message_id:" $MESSAGE_UUID
printf "%30s %s\n" "survey_id:" $SURVEY_UUID
printf "%30s %s\n" "device_config_id:" $DEVICE_CONFIGURATION_UUID
printf "%30s %s\n" "session_id:" $SESSION_UUID
printf "%30s %s\n" "wallet_registration_id:" $WALLET_REGISTRATION_UUID
printf "%30s %s\n" "capture_id:" $CAPTURE_UUID
printf "%30s %s\n" "timestamp:" $EPOCH

# prepare messages data
python3 scripts/prepare-messages.py \
  $MESSAGE_UUID $SURVEY_UUID $EPOCH

# prepare wallet registration data
python3 scripts/prepare-wallet-registrations.py \
  $WALLET_REGISTRATION_UUID $DEVICE_CONFIGURATION_UUID $EPOCH

# prepare captures data
python3 scripts/prepare-captures.py \
  $CAPTURE_UUID $SESSION_UUID $EPOCH

# prepare device config data
python3 scripts/prepare-device-configurations.py \
  $DEVICE_CONFIGURATION_UUID $EPOCH

# prepare sessions data
python3 scripts/prepare-sessions.py \
  $SESSION_UUID $DEVICE_CONFIGURATION_UUID

# upload it
echo "Sending captures data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/testing-tool-captures.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending wallet registrations data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/testing-tool-wallet-registrations.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending device configurations data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/testing-tool-device-configurations.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending sessions data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/testing-tool-sessions.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending messages data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/testing-tool-messages.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Finished sending data to aws"

echo
. ./scripts/create-cron-job.sh
echo

echo "waiting for cron job to finish..."
sleep 5
echo

. ./scripts/request-data.sh
