#!/bin/bash

apt update
apt install curl wget git gpg sudo -y


bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh)


read -p "请输入您的ID： " id


cat <<EOF > /etc/XrayR/config.yml
Nodes:
  -
    PanelType: "NewV2board"
    ApiConfig:
      ApiHost: "https://nya.fish"
      ApiKey: "dsaijfias545451a"
      NodeID: $id
      NodeType: V2ray
      Timeout: 30
    ControllerConfig:
      ListenIP: 0.0.0.0
      SendIP: 0.0.0.0
      UpdatePeriodic: 60
      EnableDNS: false
EOF


systemctl restart XrayR

wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -o /usr/share/keyrings/xanmod-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list
sudo apt update
sudo apt install linux-xanmod-x64v3 -y

sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf

cat >> /etc/sysctl.conf << EOF
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF
sysctl -p
