import json
import sys

id = sys.argv[1]
loggedAt = sys.argv[2]
timestamp = sys.argv[3]

inputFile = "template/testing-tool-device-configurations.json"
outputFile = f'prepared/{timestamp}-testing-tool-device-configurations.json'

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["device_configurations"]:
    message["id"] = id
    message["logged_at"] = loggedAt

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
