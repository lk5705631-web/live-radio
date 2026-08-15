#!/bin/bash

PORT_TO_USE="${PORT:-10000}"

# יצירת הגדרות לשרת Icecast המותאמות לסביבת Docker
cat << EOF > /tmp/icecast.xml

    
        100
        5
    
    
        RadioSecret123
        AdminSecret123
    
    
        ${PORT_TO_USE}
        0.0.0.0
    
    
        /tmp
        /usr/share/icecast2/web
        /usr/share/icecast2/admin
        
    
    
        nobody
        nogroup
    

EOF

# הפעלת שרת Icecast ברקע
icecast2 -c /tmp/icecast.xml &

# המתנה לטעינת השרת
sleep 5

# לולאת שידור שירים רציפה לשרת המקומי
while true; do
  for f in *.mp3; do
    if [ -f "$f" ]; then
      echo "Playing: $f"
      ffmpeg -nostdin -re -i "$f" -c:a libmp3lame -b:a 128k -content_type audio/mpeg -f mp3 "icecast://source:RadioSecret123@127.0.0.1:${PORT_TO_USE}/live"
    fi
  done
done
