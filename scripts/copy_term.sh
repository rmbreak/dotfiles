#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: $0 <remote_host>"
fi

REMOTE_HOST=$1

ssh "$REMOTE_HOST" "mkdir -p ~/.terminfo/${TERM:0:1}"
scp "/usr/share/terminfo/${TERM:0:1}/$TERM" "$REMOTE_HOST:~/.terminfo/${TERM:0:1}"
