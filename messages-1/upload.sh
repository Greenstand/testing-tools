#!/bin/bash
set -e
MESSAGE_UUID_VALUE=`python3 -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)'`
EPOCH=`date +%s`
rm prepared/*.json
sed "s/MESSAGE_UUID_VALUE/$MESSAGE_UUID_VALUE/" template/survey-message.json > prepared/$EPOCH-testing-tool-survey-message.json

MESSAGE_UUID_VALUE=`python3 -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)'`
sed "s/MESSAGE_UUID_VALUE/$MESSAGE_UUID_VALUE/" template/normal-message.json > prepared/$EPOCH-testing-tool-normal-message.json

#upload it
aws s3 cp --profile treetracker-$ENV-env prepared/$EPOCH-testing-tool-survey-message.json s3://treetracker-$ENV-batch-uploads
aws s3 cp --profile treetracker-$ENV-env prepared/$EPOCH-testing-tool-normal-message.json s3://treetracker-$ENV-batch-uploads

echo "message uuid: $MESSAGE_UUID_VALUE"

sleep 3
kubectl -n bulk-pack-services delete job bulk-pack-processor-manual-001
kubectl -n bulk-pack-services create job --from=cronjob/bulk-pack-processor bulk-pack-processor-manual-001
