#!/usr/bin/env sh

NODE_DIR=${NODE_DIR:-$HOME/node}
BIN_DIR=/usr/bin
USER=$(whoami)


VALIDATOR_ADDRESS='${VALIDATOR_ADDRESS}'
mkdir -p /etc/w3fs
cat > /etc/w3fs/metadata <<EOF
VALIDATOR_ADDRESS=
EOF

cat > w3fs.service <<EOF
[Unit]
  Description=w3fs
  StartLimitIntervalSec=500
  StartLimitBurst=5
[Service]
  Restart=on-failure
  RestartSec=5s
  WorkingDirectory=$NODE_DIR
  EnvironmentFile=/etc/w3fs/metadata
  ExecStartPre=/bin/chmod +x $NODE_DIR/w3fs/start.sh
  ExecStart=/bin/bash $NODE_DIR/w3fs/start.sh $VALIDATOR_ADDRESS
  Type=simple
  User=$USER
  KillSignal=SIGINT
  TimeoutStopSec=120
[Install]
  WantedBy=multi-user.target
EOF

cat > w3fs-worker.service <<EOF
[Unit]
  Description=w3fs-worker
  StartLimitIntervalSec=500
  StartLimitBurst=5
[Service]
  Restart=on-failure
  RestartSec=5s
  WorkingDirectory=$NODE_DIR
  ExecStartPre=/bin/chmod +x $NODE_DIR/w3fs/worker.sh
  ExecStart=/bin/bash $NODE_DIR/w3fs/worker.sh
  Type=simple
  User=$USER
  KillSignal=SIGINT
  TimeoutStopSec=120
[Install]
  WantedBy=multi-user.target
EOF

cat > heimdalld.service <<EOF
[Unit]
  Description=heimdalld
[Service]
  WorkingDirectory=$NODE_DIR
  ExecStart=$BIN_DIR/heimdalld start
  Type=simple
  User=$USER
[Install]
  WantedBy=multi-user.target
EOF

cat > heimdalld-rest-server.service <<EOF
[Unit]
  Description=heimdalld-rest-server
[Service]
  WorkingDirectory=$NODE_DIR
  ExecStart=$BIN_DIR/heimdalld rest-server
  Type=simple
  User=$USER
[Install]
  WantedBy=multi-user.target
EOF

cat > w3fs-bridge.service <<EOF
[Unit]
  Description=w3fs-bridge
[Service]
  WorkingDirectory=$NODE_DIR
  ExecStart=$BIN_DIR/w3fs-bridge start --all
  Type=simple
  User=$USER
[Install]
  WantedBy=multi-user.target
EOF
