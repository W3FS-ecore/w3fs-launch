#!/usr/bin/env sh
export MINER_API_INFO=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJyZWFkIiwid3JpdGUiLCJzaWduIiwiYWRtaW4iXX0.7P0POV4432WTSilkk9iRSvEb51DPED2mC-QKX-PVIn0:/ip4/127.0.0.1/tcp/2345/http
export IPFS_GATEWAY=https://proof-parameters.s3.cn-south-1.jdcloud-oss.com/ipfs/
w3fs-worker --worker-repo="$HOME/.w3fs/data/.w3fsworker" run --addpiece=false --precommit1=true --precommit2=true --commit=true --unseal=true
