#!/bin/bash

set -e

# i. e. saucy salamander
###sudo cp /etc/apt/sources.list /etc/apt/sources.list.17101
###sudo cat > /etc/apt/sources.list << EOF
## EOL upgrade sources.list
# Required
###deb http://old-releases.ubuntu.com/ubuntu/ artful main restricted universe multiverse
###deb http://old-releases.ubuntu.com/ubuntu/ artful-updates main restricted universe multiverse
###deb http://old-releases.ubuntu.com/ubuntu/ artful-security main restricted universe multiverse

# Optional
#deb http://old-releases.ubuntu.com/ubuntu/ artful-backports main restricted universe multiverse
###EOF

# Updating and Upgrading dependencies
sudo apt-get update -y -qq > /dev/null
sudo apt-get upgrade -y -qq > /dev/null

# Install necessary libraries for guest additions and Vagrant NFS Share
sudo apt-get -y -q install linux-headers-$(uname -r) build-essential dkms nfs-common

# Install necessary dependencies
sudo apt-get -y -q install curl wget git tmux vim

# Setup sudo to allow no-password sudo for "admin"
groupadd -r admin
usermod -a -G admin vagrant
cp /etc/sudoers /etc/sudoers.orig
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

