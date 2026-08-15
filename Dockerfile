FROM alpine:latest

# התקנת ffmpeg ו-python3
RUN apk add --no-cache ffmpeg python3 bash

WORKDIR /app

# העתקת השירים והקבצים
COPY . .

# הפעלת שרת דמה ברקע והרצת שידור הרדיו עם -nostdin
CMD python3 -m http.server ${PORT:-10000} & \
    while true; do \
      for f in *.mp3; do \
        ffmpeg -nostdin -re -i "$f" -c:a libmp3lame -b:a 128k -content_type audio/mpeg -f mp3 "$STREAM_URL"; \
      done; \
    done
