import json
import sys

sessionId = sys.argv[1]
deviceConfigurationId = sys.argv[2]
walletRegistrationId = sys.argv[3]
timestamp = sys.argv[4]

inputFile = "template/testing-tool-sessions.json"
outputFile = f'prepared/{timestamp}-testing-tool-sessions.json'

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["sessions"]:
    message["id"] = sessionId
    message["device_configuration_id"] = deviceConfigurationId
    message["originating_wallet_registration_id"] = walletRegistrationId

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
