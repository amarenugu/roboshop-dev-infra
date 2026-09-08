#!/bin/bash
chattr -i /etc/ssh/sshd_config 2>/dev/null
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i '/^PasswordAuthentication/a KbdInteractiveAuthentication no' /etc/ssh/sshd_config
systemctl restart sshd