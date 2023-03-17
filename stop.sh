#!/bin/bash
SCRIPT_DIR=$(dirname "$0")

touch $SCRIPT_DIR/stop
notify-send "Stopping focus music" -a Fokus
