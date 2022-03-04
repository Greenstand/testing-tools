import json
import sys

treeId = sys.argv[1]
deviceIdentifier = sys.argv[2]
planterIdentifier = sys.argv[3]
treeTimestamp = sys.argv[4]
timestamp = sys.argv[5]


inputFile = "template/testing-tool-trees.json"
outputFile = f'prepared/{timestamp}-testing-tool-trees.json'

jsonFile = open(inputFile, "r")
data = json.load(jsonFile)
jsonFile.close()

for message in data["trees"]:
    message["timestamp"] = treeTimestamp
    message["device_identifier"] = deviceIdentifier
    message["planter_identifier"] = planterIdentifier
    message["uuid"] = treeId

jsonFile = open(outputFile, "w")
json.dump(data, jsonFile)
jsonFile.close()
