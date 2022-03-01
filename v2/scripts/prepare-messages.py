import json
import sys

messageId = sys.argv[1]
surveyId = sys.argv[2]
composedAt = sys.argv[3]

inputFile = "template/testing-tool-messages.json"
outputFile = "prepared/testing-tool-messages.json"

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["messages"]:
    message["message_uuid"] = messageId
    message["survey_id"] = surveyId
    message["composed_at"] = composedAt

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
