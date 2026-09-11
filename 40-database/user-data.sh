#!/bin/bash
set -x
exec > /var/log/user-data-custom.log 2>&1

chattr -i /etc/ssh/sshd_config 2>/dev/null
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i '/^PasswordAuthentication/a KbdInteractiveAuthentication no' /etc/ssh/sshd_config
echo "ec2-user:DevOps-321" | chpasswd

mkdir -p /home/ec2-user/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAit92C71I6uq1egT9RRalkk6BbEglAb1uvQHOZIaJAJ ammi.mailme@gmail.com" >> /home/ec2-user/.ssh/authorized_keys
chown -R ec2-user:ec2-user /home/ec2-user/.ssh
chmod 700 /home/ec2-user/.ssh
chmod 600 /home/ec2-user/.ssh/authorized_keys

systemctl restart sshd

echo "USER_DATA_COMPLETED_SUCCESSFULLY"