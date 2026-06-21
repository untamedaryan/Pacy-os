#!/bin/bash
set -e

# Create live user
useradd -m -G wheel,seat,video,input,audio -s /usr/bin/zsh liveuser 2>/dev/null || true
echo "liveuser:live" | chpasswd
passwd -d root

rm -f /usr/share/hypr/w0.png
rm -f /usr/share/hypr/w1.png
rm -f /usr/share/hypr/w2.png
rm -f /usr/share/hypr/lockdead.png
rm -f /usr/share/hypr/lockdead2.png

# Enable services
systemctl enable dbus seatd greetd



