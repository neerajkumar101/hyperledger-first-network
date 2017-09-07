#!/bin/bash

# Exit on first error, print all commands.
set -ev
# Grab the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -rf ~/.composer-connection-profiles/hlfv1/*
# rm -rf ~/.composer-credentials/*

# copy org admin credentials into the keyValStore
# mkdir -p ~/.composer-credentials
# cp "${DIR}"/creds/* ~/.composer-credentials

# create a composer connection profile
mkdir -p ~/.composer-connection-profiles/hlfv1
cat << EOF > ~/.composer-connection-profiles/hlfv1/connection.json
{
    "type": "hlfv1",
    "orderers": [
       { "url" : "grpc://localhost:7050" }
    ],
    "ca": { "url": "http://localhost:7054", 
            "name": "ca.leftorg1.example.com"
    },
    "peers": [
        {
            "requestURL": "grpc://localhost:7051",
            "eventURL": "grpc://localhost:7053"
        },
        {
            "requestURL": "grpc://localhost:8051",
            "eventURL": "grpc://localhost:8053"
        }
    ],
    "keyValStore": "${HOME}/.composer-credentials",
    "channel": "mychannel",
    "mspID": "LeftOrg1MSP",
    "timeout": "600",
    "invokeWaitTime": "200"
}
EOF
echo "Hyperledger Composer profile has been created for the Hyperledger Fabric v1.0 instance"
