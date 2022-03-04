kubectl config get-contexts
UUID=$(python scripts/uuid4.py)
kubectl -n bulk-pack-services create job --from=cronjob/bulk-pack-processor bulk-pack-processor-manual-$UUID
kubectl wait -n bulk-pack-services --for=condition=complete --timeout=60s job.batch/bulk-pack-processor-manual-$UUID
kubectl -n bulk-pack-services logs job.batch/bulk-pack-processor-manual-$UUID
