sed -i '/net.ipv6.conf.all.disable_ipv6/d' /etc/sysctl.conf
cat >> /etc/sysctl.conf << EOF
net.ipv6.conf.all.disable_ipv6=1
EOF
sysctl -p
