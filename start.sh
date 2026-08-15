#!/bin/bash
python3 -m http.server ${PORT:-10000} &

while true; do
  for f in *.mp3; do
    echo "Now playing: $f"
    ffmpeg -nostdin -re -i "$f" -c:a libmp3lame -b:a 96k -content_type audio/mpeg -f mp3 icecast://source:uTdAsJFD49@sapircast.caster.fm:13652/Drgtd
  done
done
