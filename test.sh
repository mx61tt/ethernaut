#!/bin/sh
source .env

if [[ ( -z $RINKEBY_RPC_URL) && ( -z $PRIVATE_KEY)]]; then
    echo "Set the environment variables"
else
    forge test --match-path ./test/$1.t.sol --fork-url ${RINKEBY_RPC_URL} -vvvv
fi