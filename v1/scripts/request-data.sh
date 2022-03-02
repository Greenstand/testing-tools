echo "checking api routes"
host=https://$ENV-k8s.treetracker.org

captures_url=${host}/field-data/raw-captures/${TREE_UUID}
device_configuration_url=${host}/field-data/device-configuration/${DEVICE_UUID}
wallet_registration_url=${host}/field-data/wallet-registration/${SESSION_UUID}
sessions_url=${host}/field-data/session/${SESSION_UUID}

# legacy database check
v1_captures_url=${host}/webmap/tree?uuid=${TREE_UUID}

for url in \
  $wallet_registration_url $device_configuration_url $sessions_url $captures_url $v1_captures_url; do
  echo "route: ${url}"
  # return true to continue script
  curl $url
  echo
  echo
done
