FROM alpine:latest

# התקנת ffmpeg ו-python3 כדי לשמור על השרת פעיל ב-Render
RUN apk add --no-cache ffmpeg python3 bash

WORKDIR /app

# העתקת כל השירים והקבצים
COPY . .

# הפעלת שרת דמה ברקע בשביל Render, והרצת שידור הרדיו בלופ
CMD python3 -m http.server ${PORT:-10000} & \
    while true; do \
      for f in *.mp3; do \
        ffmpeg -re -i "$f" -c:a libmp3lame -b:a 128k -f mp3 "$STREAM_URL"; \
      done; \
    done
