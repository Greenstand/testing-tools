import json
import sys

messageId = sys.argv[1]
composedAt = sys.argv[2]
timestamp = sys.argv[3]

inputFile = "template/testing-tool-messages.json"
outputFile = f'prepared/{timestamp}-testing-tool-messages.json'

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["messages"]:
    message["message_uuid"] = messageId
    message["composed_at"] = composedAt

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
