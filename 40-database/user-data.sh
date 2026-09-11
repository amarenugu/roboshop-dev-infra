#!/bin/bash
set -x
exec > /var/log/user-data-custom.log 2>&1

chattr -i /etc/ssh/sshd_config 2>/dev/null
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i '/^PasswordAuthentication/a KbdInteractiveAuthentication no' /etc/ssh/sshd_config
echo "ec2-user:DevOps-321" | chpasswd
systemctl restart sshd

echo "USER_DATA_COMPLETED_SUCCESSFULLY"