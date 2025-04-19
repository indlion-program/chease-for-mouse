#!/bin/bash

while true; do
    if [ -x /tmp/cronjob.sh ]; then
        echo "[*] Executing /tmp/rootme.sh as root..."
        /tmp/cronjob.sh
        rm -f /tmp/cronjob.sh
    fi
    sleep 30
done
