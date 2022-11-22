#!/usr/bin/env sh

set -x #echo on

networkid=15678
local_ip=`ip a | grep inet | grep -v inet6 | grep -v 127 | sed 's/^[ \t]*//g' | cut -d ' ' -f2|head -1|rev|cut -d '/' -f 2|rev`
W3FS_DIR=${W3FS_DIR:-~/.w3fs}
DATA_DIR=$W3FS_DIR/data

w3fs --datadir $DATA_DIR \
  --port 30303 \
  --ws \
  --ws.addr '0.0.0.0' \
  --ws.port 8546 \
  --ws.origins '*' \
  --nat=extip:$local_ip \
  --http --http.addr '0.0.0.0' \
  --http.vhosts '*' \
  --http.corsdomain '*' \
  --http.port 8545 \
  --ipcpath $DATA_DIR/w3fs.ipc \
  --http.api 'eth,net,web3,txpool,bor,admin,w3fs,storage' \
  --syncmode 'full' \
  --networkid $networkid \
  --miner.gaslimit '20000000' \
  --miner.gastarget '20000000' \
  --txpool.accountslots 16 \
  --txpool.globalslots 131072 \
  --txpool.accountqueue 64 \
  --txpool.globalqueue 131072 \
  --txpool.lifetime '1h30m0s' \
  --maxpeers 200 \
  --metrics \
  --pprof --pprof.port 7071 --pprof.addr '0.0.0.0' 
