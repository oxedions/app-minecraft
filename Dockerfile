FROM ubuntu:latest

RUN apt update; apt install openjdk-16-jre-headless wget;

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && chown minecraft:minecraft /home/minecraft

WORKDIR /home/minecraft/

RUN wget https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar

RUN <<xxEOFxx cat >> /home/minecraft/start.sh
#!/bin/bash
sudo -i -u minecraft bash << EOF
java -Xmx1024M -Xms1024M -jar server.jar nogui
EOF
xxEOFxx

RUN chmod +x /home/minecraft/start.sh

EXPOSE 25565/tcp