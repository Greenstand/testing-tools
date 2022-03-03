import json
import sys

captureId = sys.argv[1]
sessionId = sys.argv[2]
createdAt = sys.argv[3]
timestamp = sys.argv[4]


inputFile = "template/testing-tool-captures.json"
outputFile = f'prepared/{timestamp}-testing-tool-captures.json'

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["captures"]:
    message["id"] = captureId
    message["session_id"] = sessionId
    message["created_at"] = createdAt
    message["captured_at"] = createdAt

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
