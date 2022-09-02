#!/bin/sh
source .env

if [[ ( -z $RPC_URL) && ( -z $PRIVATE_KEY)]]; then
    forge script ./script/$1.s.sol
else
    forge script ./script/$1.s.sol:POC --private-key ${PRIVATE_KEY} --rpc-url ${RINKEBY_RPC_URL} --broadcast -vvvv
fi