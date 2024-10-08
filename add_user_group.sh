#!/bin/sh

export AWS_DEFAULT_OUTPUT=json

aws dynamodb put-item \
    --table-name stns-osuser \
    --item '{ "name": {"S": "testuser1"},"directory": {"S": "/home/testuser1"},"gecos":  {"S": "null"},"group_id":  {"S": "1010"},"id":  {"S": "1001"},"keys": {"L":[{"S": "ssh-rsa AAAXXX testuser1@stns-client.example.com"}]},"link_users":  {"L": []},"password":  {"S": "null"},"shell":  {"S": "/bin/bash"} }'

aws dynamodb put-item \
    --table-name stns-osuser \
    --item '{ "name": {"S": "testuser2"},"directory": {"S": "/home/testuser2"},"gecos":  {"S": "null"},"group_id":  {"S": "1010"},"id":  {"S": "1002"},"keys":  {"L":[{"S": "ssh-rsa AAAXXX testuser2@stns-client.example.com"}]},"link_users":  {"L": []},"password":  {"S": "null"},"shell":  {"S": "/bin/bash"} }'

aws dynamodb put-item \
    --table-name stns-osuser \
    --item '{ "name": {"S": "testuser3"},"directory": {"S": "/home/testuser3"},"gecos":  {"S": "null"},"group_id":  {"S": "1010"},"id":  {"S": "1003"},"keys":  {"L":[{"S": "ssh-rsa AAAXXX testuser3@stns-client.example.com"}]},"link_users":  {"L": []},"password":  {"S": "null"},"shell":  {"S": "/bin/sh"} }'


aws dynamodb put-item \
    --table-name stns-osgroup \
    --item '{ "name": {"S": "testgroup1"},"id": {"S": "1010"},"link_groups":  {"L": []},"users":  {"L": [{"S": "testuser1"},{"S": "testuser2"},{"S": "testuser3"}]} }'

aws dynamodb put-item \
    --table-name stns-osgroup \
    --item '{ "name": {"S": "testgroup2"},"id": {"S": "1100"},"link_groups":  {"L": []},"users":  {"L": [{"S": "testuser1"},{"S": "testuser2"},{"S": "testuser3"}]} }'


#aws dynamodb put-item \
#    --table-name stns-osuser \
#    --item '{ \
#        "name": {"S": "ore"}, \
#        "directory": {"S": "/home/ore"}, \
#        "gecos":  {"S": "null"}, \
#        "group_id":  {"S": "1002"}, \
#        "id":  {"S": "1002"}, \
#        "keys":  {"S": "\"ssh-rsa\""}, \
#        "link_users":  {"L": []}, \
#        "password":  {"S": "null"}, \
#        "shell":  {"S": "/bin/bash"} \
#	}'
#aws dynamodb put-item \
#    --table-name stns-osgroup \
#    --item '{ \
#        "name": {"S": "ore"}, \
#        "id": {"S": "1002"}, \
#        "link_groups":  {"L": []}, \
#        "users":  {"L": ["shogo"]} \
#	}'
