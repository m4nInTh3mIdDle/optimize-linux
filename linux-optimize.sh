#!/bin/sh

# Set kernel parameters in /etc/sysctl.conf
cat << EOF > /etc/sysctl.conf
# Increase maximum number of open file descriptors
fs.file-max = 1000000

# Increase maximum number of inotify instances per user
fs.inotify.max_user_instances = 8192

# Enable TCP SYN Cookie protection against SYN flood attacks
net.ipv4.tcp_syncookies = 1

# Set TCP FIN-WAIT-2 timeout to 30 seconds
net.ipv4.tcp_fin_timeout = 30

# Enable fast reuse of TIME-WAIT sockets
net.ipv4.tcp_tw_reuse = 1

# Set local port range for ephemeral ports
net.ipv4.ip_local_port_range = 1024 65000

# Increase maximum length of the SYN backlog queue
net.ipv4.tcp_max_syn_backlog = 16384

# Increase maximum number of TIME-WAIT sockets
net.ipv4.tcp_max_tw_buckets = 6000

# Set timeout for releasing route cache entries to 100 seconds
net.ipv4.route.gc_timeout = 100

# Set number of SYN retries
net.ipv4.tcp_syn_retries = 1

# Set number of SYN-ACK retries
net.ipv4.tcp_synack_retries = 1

# Increase maximum number of connections that can be queued for acceptance
net.core.somaxconn = 32768

# Increase maximum number of packets that can be queued on the input side
net.core.netdev_max_backlog = 32768

# Disable TCP timestamps
net.ipv4.tcp_timestamps = 0

# Increase maximum number of orphaned sockets
net.ipv4.tcp_max_orphans = 32768

# Enable route_localnet to accept packets with local source addresses
net.ipv4.conf.all.route_localnet=1

# Enable IP forwarding
net.ipv4.ip_forward = 1

# Disable saving TCP metrics
net.ipv4.tcp_no_metrics_save=1

# Disable TCP ECN (Explicit Congestion Notification)
net.ipv4.tcp_ecn=0

# Disable TCP F-RTO (Forward RTO-Recovery)
net.ipv4.tcp_frto=0

# Enable TCP Fast Open (TFO)
net.ipv4.tcp_fastopen=3

# Disable TCP MTU probing
net.ipv4.tcp_mtu_probing=0

# Disable TCP RFC 1337 active refusal
net.ipv4.tcp_rfc1337=0

# Enable TCP SACK (Selective Acknowledgment)
net.ipv4.tcp_sack=1

# Enable TCP FACK (Forward Acknowledgment)
net.ipv4.tcp_fack=1

# Enable TCP window scaling
net.ipv4.tcp_window_scaling=1

# Enable TCP advanced window scaling
net.ipv4.tcp_adv_win_scale=1

# Enable automatic receive buffer moderation
net.ipv4.tcp_moderate_rcvbuf=1

# Set TCP receive buffer sizes
net.ipv4.tcp_rmem=40960 873800 167772160

# Set TCP send buffer sizes
net.ipv4.tcp_wmem=40960 163840 167772160

# Set maximum value for the receive buffer size
net.core.rmem_max=167772160

# Set maximum value for the send buffer size
net.core.wmem_max=167772160

# Set minimum UDP receive buffer size
net.ipv4.udp_rmem_min=81920

# Set minimum UDP send buffer size
net.ipv4.udp_wmem_min=81920

# Set default network queue discipline to fq (Fair Queueing)
net.core.default_qdisc=fq

# Set TCP congestion control algorithm to BBR (Bottleneck Bandwidth and RTT)
net.ipv4.tcp_congestion_control=bbr
EOF

# Set system limits in /etc/security/limits.conf
cat << EOF > /etc/security/limits.conf
# Set soft and hard limits for maximum number of open file descriptors
* soft nofile 1048576
* hard nofile 1048576

# Set soft and hard limits for maximum number of processes
* soft nproc 1048576
* hard nproc 1048576

# Set soft and hard limits for maximum core file size
* soft core 1048576
* hard core 1048576

# Set unlimited soft and hard limits for memory locking
* hard memlock unlimited
* soft memlock unlimited
EOF

# Load kernel parameters from /etc/sysctl.conf
sysctl -p 2>&1 > /dev/null

# Load system configuration
sysctl --system 2>&1 > /dev/null

#Gigih4ck
