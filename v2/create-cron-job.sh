kubectl -n bulk-pack-services delete job bulk-pack-processor-manual-001
kubectl -n bulk-pack-services create job --from=cronjob/bulk-pack-processor bulk-pack-processor-manual-001