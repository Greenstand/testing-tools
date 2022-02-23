import json
import sys

sessionId = sys.argv[1]
deviceConfigurationId = sys.argv[2]

inputFile = "template/testing-tool-sessions.json"
outputFile = "prepared/testing-tool-sessions.json"

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["sessions"]:
    message["id"] = sessionId
    message["device_configuration_id"] = deviceConfigurationId

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
