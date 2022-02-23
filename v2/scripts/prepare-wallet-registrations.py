import json
import sys

id = sys.argv[1]
deviceConfigurationId = sys.argv[2]
registeredAt = sys.argv[3]

inputFile = "template/testing-tool-wallet-registrations.json"
outputFile = "prepared/testing-tool-wallet-registrations.json"

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["wallet_registrations"]:
    message["id"] = id
    message["device_configuration_id"] = deviceConfigurationId
    message["registered_at"] = registeredAt

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
