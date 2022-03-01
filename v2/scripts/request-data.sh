echo "checking api routes"
host=https://dev-k8s.treetracker.org

captures_url=${host}/field-data/raw-captures/${CAPTURE_UUID}
device_configuration_url=${host}/field-data/device-configuration/${DEVICE_CONFIGURATION_UUID}
wallet_registration_url=${host}/field-data/wallet-registration/${WALLET_REGISTRATION_UUID}
sessions_url=${host}/field-data/session/${SESSION_UUID}
message_url=${host}/messaging/message/${MESSAGE_UUID}

for url in \
  $wallet_registration_url $device_configuration_url $sessions_url $captures_url $message_url; do
  echo "route: ${url}"
  curl $url
  echo
  echo
done
