#!/bin/bash

set -e

while true
do
  ffmpeg -loglevel info -y -re \
    -f image2 -loop 1 -i bg.png \
    -f concat -safe 0 -i <((for f in ./mp3/*.mp3; do path="$PWD/$f"; echo "file ${path@Q}"; done) | shuf) \
    -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k \
    -framerate 25 -video_size 1280x720 -vf "format=yuv420p" -g 50 -shortest -strict experimental \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv rtmp://stream.odysee.com/live$481649112900f6fcc0deaf122facd8cced5716f8?d=40766568687479&s=adc2295758f5becc411f1cee76aa6336808e650e4074c8c435cc78709aa56baa0557e57aff6b6dd78b1d7d02ff4101a41ff78edd995fc05ed428cfeaf104c077&t=1662969578
done
