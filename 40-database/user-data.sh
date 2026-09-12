#!/bin/bash
mkdir -p /home/ec2-user/.ssh
echo "<paste your roboshop-rsa.pub content here>" >> /home/ec2-user/.ssh/authorized_keys
chown -R ec2-user:ec2-user /home/ec2-user/.ssh
chmod 700 /home/ec2-user/.ssh
chmod 600 /home/ec2-user/.ssh/authorized_keys