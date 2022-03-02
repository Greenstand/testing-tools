#!/bin/bash
set -e
TREE_UUID=$(python3 scripts/uuid4.py)
DEVICE_IDENTIFIER=$(python3 scripts/rand-string.py)
PLANTER_IDENTIFIER=$(python3 scripts/rand-string.py)
DEVICE_UUID=$(node scripts/convert-string-to-uuid.js $DEVICE_IDENTIFIER)
SESSION_UUID=$(node scripts/convert-string-to-uuid.js $DEVICE_IDENTIFIER$PLANTER_IDENTIFIER)
TIMESTAMP=$(python3 scripts/timestamp.py)

printf "%30s %s\n" "tree_uuid:" $TREE_UUID
printf "%30s %s\n" "device_identifier:" $DEVICE_IDENTIFIER
printf "%30s %s\n" "planter_identifier:" $PLANTER_IDENTIFIER
printf "%30s %s\n" "device_uuid:" $DEVICE_UUID
printf "%30s %s\n" "session_uuid:" $SESSION_UUID

# prepare registration data
planterTimestamp=$(date '+%s')
sed "s/PLANTER_IDENTIFIER/$PLANTER_IDENTIFIER/" \
  template/testing-tool-registrations.json \
  >prepared/$planterTimestamp-testing-tool-registrations.json

sed -i'' "s/DEVICE_IDENTIFIER/$DEVICE_IDENTIFIER/" \
  prepared/$planterTimestamp-testing-tool-registrations.json

sleep 1

# prepare device config data
deviceTimestamp=$(date '+%s')
sed "s/DEVICE_IDENTIFIER/$DEVICE_IDENTIFIER/" \
	template/testing-tool-devices.json \
	>prepared/$deviceTimestamp-testing-tool-devices.json

sleep 1

# prepare trees data
treeTimestamp=$(date '+%s')
sed "s/TREE_UUID/$TREE_UUID/" \
  template/testing-tool-trees.json \
  >prepared/$treeTimestamp-testing-tool-trees.json

sed -i'' "s/DEVICE_IDENTIFIER/$DEVICE_IDENTIFIER/" \
  prepared/$treeTimestamp-testing-tool-trees.json

sed -i'' "s/PLANTER_IDENTIFIER/$PLANTER_IDENTIFIER/" \
  prepared/$treeTimestamp-testing-tool-trees.json

sed -i'' "s/TREE_TIMESTAMP/$TIMESTAMP/" \
  prepared/$treeTimestamp-testing-tool-trees.json


# upload it

echo "Sending registrations data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$planterTimestamp-testing-tool-registrations.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending device data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$deviceTimestamp-testing-tool-devices.json \
  s3://treetracker-$ENV-batch-uploads
echo

echo "Sending trees data..."
aws s3 cp --profile treetracker-$ENV-env \
  prepared/$treeTimestamp-testing-tool-trees.json \
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
