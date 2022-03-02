#!/bin/bash
set -e
MESSAGE_UUID=$(python3 scripts/uuid4.py)
DEVICE_CONFIGURATION_UUID=$(python3 scripts/uuid4.py)
WALLET=$(python3 scripts/rand-string.py)
CAPTURE_UUID=$(python3 scripts/uuid4.py)
SESSION_UUID=$(python3 scripts/uuid4.py)
WALLET_REGISTRATION_UUID=$(python3 scripts/uuid4.py)
EPOCH=$(python3 scripts/iso8601.py)

printf "%30s %s\n" "message_id:" $MESSAGE_UUID
printf "%30s %s\n" "device_config_id:" $DEVICE_CONFIGURATION_UUID
printf "%30s %s\n" "session_id:" $SESSION_UUID
printf "%30s %s\n" "wallet_registration_id:" $WALLET_REGISTRATION_UUID
printf "%30s %s\n" "capture_id:" $CAPTURE_UUID

# prepare messages data
messageTimestamp=$(date '+%s')
sed "s/MESSAGE_UUID/$MESSAGE_UUID/" \
  template/testing-tool-messages.json \
  >prepared/$messageTimestamp-testing-tool-messages.json

sed -i'' "s/MESSAGE_TIMESTAMP/$EPOCH/" \
  prepared/$messageTimestamp-testing-tool-messages.json

sleep 1

# prepare wallet registration data
walletRegistrationTimestamp=$(date '+%s')
sed "s/WALLET_REGISTRATION_UUID/$WALLET_REGISTRATION_UUID/" \
  template/testing-tool-wallet-registrations.json \
  >prepared/$walletRegistrationTimestamp-testing-tool-wallet-registrations.json

sed -i'' "s/WALLET_REGISTRATION_TIMESTAMP/$EPOCH/" \
  prepared/$walletRegistrationTimestamp-testing-tool-wallet-registrations.json

sed -i'' "s/WALLET/$WALLET/" \
  prepared/$walletRegistrationTimestamp-testing-tool-wallet-registrations.json

sleep 1


# prepare device config data
deviceTimestamp=$(date '+%s')
sed "s/DEVICE_CONFIGURATION_UUID/$DEVICE_CONFIGURATION_UUID/" \
	template/testing-tool-device-configurations.json \
	>prepared/$deviceTimestamp-testing-tool-device-configurations.json

sed -i'' "s/DEVICE_CONFIG_TIMESTAMP/$EPOCH/" \
  prepared/$deviceTimestamp-testing-tool-device-configurations.json

sleep 1

# prepare sessions data
sessionTimestamp=$(date '+%s')
sed "s/SESSION_UUID/$SESSION_UUID/" \
  template/testing-tool-sessions.json \
  >prepared/$sessionTimestamp-testing-tool-sessions.json

sed -i'' "s/DEVICE_CONFIGURATION_UUID/$DEVICE_CONFIGURATION_UUID/" \
  prepared/$sessionTimestamp-testing-tool-sessions.json

sed -i'' "s/WALLET_REGISTRATION_UUID/$WALLET_REGISTRATION_UUID/" \
  prepared/$sessionTimestamp-testing-tool-sessions.json

sleep 1

# prepare captures data
capturesTimestamp=$(date '+%s')
sed "s/CAPTURE_UUID/$CAPTURE_UUID/" \
  template/testing-tool-captures.json \
  >prepared/$capturesTimestamp-testing-tool-captures.json

sed -i'' "s/SESSION_UUID/$SESSION_UUID/" \
  prepared/$capturesTimestamp-testing-tool-captures.json

sed -i'' "s/CAPTURE_TIMESTAMP/$EPOCH/" \
  prepared/$capturesTimestamp-testing-tool-captures.json

# upload it

echo "Sending wallet registrations data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$walletRegistrationTimestamp-testing-tool-wallet-registrations.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending device configurations data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$deviceTimestamp-testing-tool-device-configurations.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending sessions data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$sessionTimestamp-testing-tool-sessions.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending captures data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$capturesTimestamp-testing-tool-captures.json \
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

echo "waiting for cron job to finish..."
sleep 5
echo

. ./scripts/request-data.sh
