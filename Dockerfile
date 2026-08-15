FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    icecast2 \
    ffmpeg \
    bash \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN chmod +x start.sh

CMD ["/bin/bash", "start.sh"]
