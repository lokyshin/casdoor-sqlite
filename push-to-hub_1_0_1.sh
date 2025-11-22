#!/bin/bash
# 启用代理
sudo systemctl stop docker
sudo mv /etc/systemd/system/docker.service.d/http-proxy.conf.disabled /etc/systemd/system/docker.service.d/http-proxy.conf 2>/dev/null
sudo systemctl daemon-reload
sudo systemctl start docker

# 推送
sudo docker push lokyshin/casdoor-sqlite:1.0.1

# 禁用代理
sudo systemctl stop docker
sudo mv /etc/systemd/system/docker.service.d/http-proxy.conf /etc/systemd/system/docker.service.d/http-proxy.conf.disabled 2>/dev/null
sudo systemctl daemon-reload
sudo systemctl start docker

echo "✅ 推送完成！"
