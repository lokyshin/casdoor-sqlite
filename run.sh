#!/bin/bash
sudo docker rm -f casdoor-sqlite 2>/dev/null
sudo docker run -d --name casdoor-sqlite \
  -p 12880:8000 \
  -e driverName=sqlite \
  -e dataSourceName=/data/casdoor.db \
  -v "$PWD/sqlite_data":/data \
  --restart always \
  casdoor-sqlite:1.0.0
sudo docker logs -f casdoor-sqlite
