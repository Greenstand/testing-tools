#!/bin/bash
set -e
MESSAGE_UUID=$(python scripts/uuid4.py)
SURVEY_UUID=$(python scripts/uuid4.py)
DEVICE_CONFIGURATION_UUID=$(python scripts/uuid4.py)
CAPTURE_UUID=$(python scripts/uuid4.py)
SESSION_UUID=$(python scripts/uuid4.py)
WALLET_REGISTRATION_UUID=$(python scripts/uuid4.py)
EPOCH=$(python scripts/iso8601.py)

printf "%30s %s\n" "message_id:" $MESSAGE_UUID
printf "%30s %s\n" "survey_id:" $SURVEY_UUID
printf "%30s %s\n" "device_config_id:" $DEVICE_CONFIGURATION_UUID
printf "%30s %s\n" "session_id:" $SESSION_UUID
printf "%30s %s\n" "wallet_registration_id:" $WALLET_REGISTRATION_UUID
printf "%30s %s\n" "capture_id:" $CAPTURE_UUID

# prepare messages data
sed "s/MESSAGE_UUID/$MESSAGE_UUID/" \
  template/testing-tool-messages.json \
  >prepared/testing-tool-messages.json

sed -i '' "s/SURVEY_UUID/$SURVEY_UUID/" \
  prepared/testing-tool-messages.json

sed -i '' "s/MESSAGE_TIMESTAMP/$EPOCH/" \
  prepared/testing-tool-messages.json

# prepare wallet registration data
sed "s/WALLET_REGISTRATION_UUID/$WALLET_REGISTRATION_UUID/" \
  template/testing-tool-wallet-registrations.json \
  >prepared/testing-tool-wallet-registrations.json

sed -i '' "s/WALLET_REGISTRATION_TIMESTAMP/$EPOCH/" \
  prepared/testing-tool-wallet-registrations.json

sed -i '' "s/DEVICE_CONFIGURATION_UUID/$DEVICE_CONFIGURATION_UUID/" \
	prepared/testing-tool-wallet-registrations.json

# prepare captures data
sed "s/CAPTURE_UUID/$CAPTURE_UUID/" \
  template/testing-tool-captures.json \
  >prepared/testing-tool-captures.json

sed -i '' "s/SESSION_UUID/$SESSION_UUID/" \
  prepared/testing-tool-captures.json

sed -i '' "s/CAPTURE_TIMESTAMP/$EPOCH/" \
  prepared/testing-tool-captures.json

# prepare device config data
sed "s/DEVICE_CONFIGURATION_UUID/$DEVICE_CONFIGURATION_UUID/" \
	template/testing-tool-device-configurations.json \
	>prepared/testing-tool-device-configurations.json

sed -i '' "s/DEVICE_CONFIG_TIMESTAMP/$EPOCH/" \
  prepared/testing-tool-device-configurations.json

# prepare sessions data
sed "s/SESSION_UUID/$SESSION_UUID/" \
  template/testing-tool-sessions.json \
  >prepared/testing-tool-sessions.json

<<<<<<< Updated upstream
sed -i "s/DEVICE_CONFIGURATION_UUID/$DEVICE_CONFIGURATION_UUID/" \
	prepared/testing-tool-sessions.json
=======
sed -i '' "s/DEVICE_CONFIG_UUID/$DEVICE_CONFIG_UUID/" \
  prepared/testing-tool-sessions.json
>>>>>>> Stashed changes

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

echo "Sending sessions data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/testing-tool-sessions.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending device configurations data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/testing-tool-device-configurations.json \
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
