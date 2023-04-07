#!/usr/bin/env sh

echo $USER

while true; do
    "$@"
    sleep 60
done