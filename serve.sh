#!/usr/bin/env bash

# this script will install a systemd service which
# will update the content from git repo, build it
# and then publish to the web server

SERVICE_NAME="update-my-site.service"
TIMER_NAME="update-my-site.timer"
WD=$PWD/$(dirname "$0")

UPDATE_MY_SITE_SERVICE="
[Unit]

[Service]
WorkingDirectory=$WD
User=$USER
ExecStart=$WD/build.sh
Type=oneshot

"

echo "$UPDATE_MY_SITE_SERVICE" | sudo tee /etc/systemd/system/$SERVICE_NAME

UPDATE_MY_SITE_TIMER="
[Unit]

[Timer]
OnBootSec=1m
OnUnitActiveSec=1m
Unit=$SERVICE_NAME


[Install]
WantedBy=timers.target

"

echo "$UPDATE_MY_SITE_TIMER" | sudo tee /etc/systemd/system/$TIMER_NAME

sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl enable $TIMER_NAME
sudo systemctl start $TIMER_NAME
