UUID=$(python3 scripts/uuid4.py)
kubectl -n bulk-pack-services create job --from=cronjob/bulk-pack-processor bulk-pack-processor-manual-$UUID
