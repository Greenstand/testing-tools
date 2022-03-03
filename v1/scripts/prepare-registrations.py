import json
import sys

planterIdentifier = sys.argv[1]
deviceIdentifier = sys.argv[2]
timestamp = sys.argv[3]


inputFile = "template/testing-tool-registrations.json"
outputFile = f'prepared/{timestamp}-testing-tool-registrations.json'

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["registrations"]:
    message["planter_identifier"] = planterIdentifier
    message["device_identifier"] = deviceIdentifier

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
