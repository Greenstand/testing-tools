import json
import sys

id = sys.argv[1]
wallet = sys.argv[2]
registeredAt = sys.argv[3]
timestamp = sys.argv[4]

inputFile = "template/testing-tool-wallet-registrations.json"
outputFile = f'prepared/{timestamp}-testing-tool-wallet-registrations.json'

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["wallet_registrations"]:
    message["id"] = id
    message["wallet"] = wallet
    message["registered_at"] = registeredAt

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
