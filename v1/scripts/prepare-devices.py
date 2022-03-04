import json
import sys

deviceIdentifier = sys.argv[1]
timestamp = sys.argv[2]

inputFile = "template/testing-tool-devices.json"
outputFile = f'prepared/{timestamp}-testing-tool-devices.json'

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["devices"]:
    message["device_identifier"] = deviceIdentifier

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
