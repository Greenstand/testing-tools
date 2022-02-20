
echo "checking api routes"
host=https://dev-k8s.treetracker.org

echo "checking capture"
curl "${host}/field-data/raw-captures/${CAPTURE_UUID}" || true
echo
echo

echo "checking dev config"
curl "${host}/field-data/device-configuration/${DEVICE_CONFIGURATION_UUID}" || true
echo
echo

echo "checking wallet reg"
curl "${host}/field-data/wallet-registration/${WALLET_REGISTRATIONS_UUID}" || true
echo
echo

echo "checking session"
curl "${host}/field-data/session/${SESSIONS_UUID}" || true
echo
echo

echo "checking message"
curl "${host}/messaging/message/${MESSAGE_UUID}" || true
echo
echo
