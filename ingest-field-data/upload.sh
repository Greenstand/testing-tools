#!/bin/bash
set -e
CAPTURE_UUID_VALUE=`python -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)'`
REGISTRATION_UUID_VALUE=`python -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)'`
EPOCH=`date +%s`
sed "s/CAPTURE_UUID_VALUE/$CAPTURE_UUID_VALUE/" template/testing-tool-captures.json > prepared/testing-tool-captures.json
sed "s/REGISTRATION_UUID_VALUE/$REGISTRATION_UUID_VALUE/" template/testing-tool-registrations.json > prepared/testing-tool-registrations.json
sed -i .bck "s/CAPTURE_TIMESTAMP/$EPOCH/" prepared/testing-tool-captures.json

#upload it
aws s3 cp --profile treetracker-$ENV-env prepared/testing-tool-captures.json s3://treetracker-$ENV-batch-uploads
aws s3 cp --profile treetracker-$ENV-env prepared/testing-tool-registrations.json s3://treetracker-$ENV-batch-uploads

echo "capture uuid: $CAPTURE_UUID_VALUE"
echo "registration uuid: $REGISTRATION_UUID_VALUE"
