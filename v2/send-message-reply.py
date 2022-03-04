import datetime
import requests
import sys
import json

api = 'https://dev-k8s.treetracker.org/messaging/'

# -- get optional arguments --

try:
    recipientHandle = sys.argv[1]
except:
    recipientHandle = "admin"

try:
    authorHandle = sys.argv[2]
except:
    authorHandle = "handle3"

try:
    messageBody = sys.argv[3]
except:
    messageBody = "testing-tools message body"


# -- get latest message --

getLatestMessageRoute = '{api}message?handle={author}&limit=1'.format(
    api=api,
    author=recipientHandle,
)

print("get message route:")
print(getLatestMessageRoute)

res = requests.get(getLatestMessageRoute)
print("attempting to get latest message from author: ", recipientHandle)
print("get message result: ", res.status_code)

try:
    latestMessage = res.json()['messages'][0]
except:
    print("could not find message, script is exiting")
    sys.exit()

print("message that will be replied to:")
print(json.dumps(latestMessage, indent=2, sort_keys=True))


# generate reply
message = {}
if latestMessage['survey'] is not None:
  message["survey_id"] = latestMessage['survey']['id']
message["type"] = "message"
message["recipient_handle"] = recipientHandle
message["author_handle"] = authorHandle
message["subject"] = "message subject"
message["body"] = messageBody

print("sending this message:")
print(json.dumps(message, indent=2, sort_keys=True))

# send reply

postMessageRoute = '{api}message'.format(api=api)

print("posting message route:")
print(postMessageRoute)

postRes = requests.post(postMessageRoute, json=message)
print("post message result: ", postRes.status_code)
