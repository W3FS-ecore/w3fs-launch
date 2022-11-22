#!/usr/bin/env sh

# set -x #echo on

W3FS_DIR=${W3FS_DIR:-~/.w3fs}
DATA_DIR=$W3FS_DIR/data
NODE_KEY=~/nodekey

# create w3fs and keystore directory
mkdir -p $W3FS_DIR $W3FS_DIR/keystore

# init w3fs
w3fs --datadir $DATA_DIR init ./multi-genesis.json

# copy peers file
cp ./static-nodes.json $DATA_DIR/w3fs/static-nodes.json

# if node key not present, create nodekey
#if [ ! -f $NODE_KEY ]; then
#  bootnode -genkey $NODE_KEY
#fi

# copy node key file
#cp $NODE_KEY $DATA_DIR/w3fs/

echo "Setup done!"
