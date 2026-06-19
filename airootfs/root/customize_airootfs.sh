#!/bin/bash
set -e

echo "PACY CUSTOMIZE SCRIPT RAN" > /root/pacy-debug

# Create live user
useradd -m -G wheel,seat,video,input,audio -s /usr/bin/zsh liveuser 2>/dev/null || true
echo "liveuser:live" | chpasswd
passwd -d root

# Enable services
systemctl enable seatd greetd

# Fix start-hyprland permissions
chmod +x /usr/local/bin/start-hyprland
