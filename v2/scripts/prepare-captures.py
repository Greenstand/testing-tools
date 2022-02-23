import json
import sys

captureId = sys.argv[1]
sessionId = sys.argv[2]
composedAt = sys.argv[3]

inputFile = "template/testing-tool-captures.json"
outputFile = "prepared/testing-tool-captures.json"

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["captures"]:
    message["id"] = captureId
    message["session_id"] = sessionId
    message["created_at"] = composedAt

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
