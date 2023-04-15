#!/usr/bin/env bash

export DISPLAY=:0
rm -f /tmp/.X0-lock # from not cleanly stopping the container

echo -e "\n### Starting Xvfb..."
Xvfb -ac -screen 0 1920x1080x24 &

echo -e "\n### Starting fluxbox..."
fluxbox -screen 0 &> /dev/null &

echo -e "\n### Starting x11vnc..."
x11vnc -passwd ${VNC_PASSWORD:-password} -N -forever -rfbport 5900 &> /dev/null &

cd /opt/wd

echo -e "\n### done with entrypoint.sh handing over to cmd"
echo -e "\n### pwd: $(pwd)"
echo -e "\n### cmd: $@"
"$@"

echo -e "\n### cmd finished, holding container open (till x is closed)"
wait # waits for all background processes to finish (join)
