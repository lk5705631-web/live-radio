FROM alpine:latest
RUN apk add --no-cache ffmpeg bash
COPY . /app
WORKDIR /app
CMD ["/bin/sh", "-c", "while true; do for f in *.mp3; do ffmpeg -re -i \"$f\" -c:a libmp3lame -b:a 128k -f mp3 \"$STREAM_URL\"; done; done"]
