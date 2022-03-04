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
WALLET=$(python3 scripts/rand-string.py)

printf "%30s %s\n" "message_id:" $MESSAGE_UUID
printf "%30s %s\n" "device_config_id:" $DEVICE_CONFIGURATION_UUID
printf "%30s %s\n" "session_id:" $SESSION_UUID
printf "%30s %s\n" "wallet_registration_id:" $WALLET_REGISTRATION_UUID
printf "%30s %s\n" "capture_id:" $CAPTURE_UUID
printf "%30s %s\n" "wallet:" $WALLET
printf "%30s %s\n" "timestamp:" $EPOCH

# prepare messages data
messageTimestamp=$(date '+%s')
python3 scripts/prepare-messages.py \
  $MESSAGE_UUID $EPOCH $messageTimestamp

sleep 1

# prepare wallet registration data
walletRegistrationTimestamp=$(date '+%s')
python3 scripts/prepare-wallet-registrations.py \
  $WALLET_REGISTRATION_UUID $WALLET $EPOCH $walletRegistrationTimestamp

sleep 1


# prepare device config data
deviceConfigTimestamp=$(date '+%s')
python3 scripts/prepare-device-configurations.py \
  $DEVICE_CONFIGURATION_UUID $EPOCH $deviceConfigTimestamp

sleep 1

# prepare sessions data
sessionTimestamp=$(date '+%s')
python3 scripts/prepare-sessions.py \
  $SESSION_UUID $DEVICE_CONFIGURATION_UUID $WALLET_REGISTRATION_UUID $sessionTimestamp

sleep 1

# prepare captures data
captureTimestamp=$(date '+%s')
python3 scripts/prepare-captures.py \
  $CAPTURE_UUID $SESSION_UUID $EPOCH $captureTimestamp

# upload it
echo "Sending wallet registrations data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$walletRegistrationTimestamp-testing-tool-wallet-registrations.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending device configurations data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$deviceConfigTimestamp-testing-tool-device-configurations.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending sessions data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$sessionTimestamp-testing-tool-sessions.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending captures data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$captureTimestamp-testing-tool-captures.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending messages data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$messageTimestamp-testing-tool-messages.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Finished sending data to aws"

echo
. ./scripts/create-cron-job.sh
echo

. ./scripts/request-data.sh
