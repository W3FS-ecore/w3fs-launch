#!/usr/bin/env sh

#set -x #echo on
if [ -z "$1" ]
  then
    echo "Address private key is required as argument"
  exit 1
fi

ADDRESS_PRIVATE=$1 #0x77f403dc6ab80214d98729681d473b08947eab47b46ae7cfe1321d099dc8d115
DATA_DIR=$HOME/.eth/ganache-db
LOGS_DIR=$HOME/.eth/logs
if [ ! -d $LOGS_DIR ];then
  mkdir -p $LOGS_DIR
fi
ganache ethereum \
--miner.blockTime 5 \
--database.dbPath $DATA_DIR \
--wallet.accounts  $ADDRESS_PRIVATE,1000000000000000000000 \
--miner.coinbase $ADDRESS_PRIVATE \
--miner.blockGasLimit 8000000 \
--miner.defaultGasPrice 20 \
-p 9545 -h 0.0.0.0 \
--chain.networkId 1337 --chain.chainId 1337 > $LOGS_DIR/ganache.log 2>&1 &
