# bitping-one-click-command-installation

## Language

[English](README.md) | [中文文档](README_zh.md)

## **Introduction**

Bitping is a platform that allows users to share traffic by sharing CPU and bandwidth for ping tests.

Your shared resources will be divided by geography, and this script supports data center network or home bandwidth.

This is the **first one-click installation script of the whole network** to automatically install dependencies and pull and install the latest docker, and the script will continue to be improved according to the platform update.

It has below features:

1. Automatically install docker based on the system, and if docker are already installed, it will not installed again.

2. Automatically select and build the pulled docker image according to the architecture, without the need for you to manually modify the official case.

3. Use Watchtower for automatic mirror update without manual update and re-entry of parameters.

(Watchtower is a utility that automates the updating of Docker images and containers. It monitors all running containers and related images, and automatically pulls the latest image and uses parameters when initially deployed to restart the corresponding container.)

## Notes

- Verified on AMD64 and ARM
- Try it if you are interested via my --> [referrals](https://app.bitping.com/?r=YIwAx_jx) <--, via my link registration will give me more motivation to perfect the installation and use of the program, and this does not affect your earnings.

## Install

### Interactive installation

Since the official default cannot perform tasks in the background, please install screen on the server in advance and enter the screen window and execute the following command. After the execution is completed, suspend the window. Otherwise, if the command window is closed, the program may be interrupted and exited.

```shell
curl -L https://raw.githubusercontent.com/spiritLHLS/bitping-one-click-command-installation/main/bitping.sh -o bitping.sh && chmod +x bitping.sh && bash ./bitping.sh
```

Since the official package does not support preset account passwords, please follow the prompts to enter the account email address and account password after running.

## Uninstall

```shell
curl -L https://raw.githubusercontent.com/spiritLHLS/bitping-one-click-command-installation/main/bitping.sh -o bitping.sh && chmod +x bitping.sh && bash ./bitping.sh -u
```

uninstall service

## Experience

The income of Southeast Asia is high, but that's it, it mainly depends on the IP segment. If each IP segment has fixed income, the income is divided according to the following geographical map. The following is the hourly income of the whole network, so the division is actually very small.

More monks and less porridge, the more people, the lower the income

![](https://github.com/spiritLHLS/bitping-one-click-command-installation/raw/main/backup/d.png)

![](https://github.com/spiritLHLS/bitping-one-click-command-installation/raw/main/backup/e.png)

![](https://github.com/spiritLHLS/bitping-one-click-command-installation/raw/main/backup/f.png)


## Disclaimer

This program is for learning purposes only, not for profit, please delete it within 24 hours after downloading, not for any commercial use. The text, data and images are copyrighted, if reproduced, please indicate the source.

Use of this program is subject to the deployment disclaimer. Use of this program is subject to the laws and regulations of the country where the server is deployed, the country where it is located, and the country where the user is located, and the author of the program is not responsible for any misconduct of the user.
