#!/bin/bash

# 定义容器名
NAME='bitping'

# 自定义字体彩色，read 函数，安装依赖函数
red(){ echo -e "\033[31m\033[01m$1$2\033[0m"; }
green(){ echo -e "\033[32m\033[01m$1$2\033[0m"; }
yellow(){ echo -e "\033[33m\033[01m$1$2\033[0m"; }
reading(){ read -rp "$(green "$1")" "$2"; }

# 必须以root运行脚本
check_root(){
  [[ $(id -u) != 0 ]] && red " The script must be run as root, you can enter sudo -i and then download and run again." && exit 1
}

# 判断系统，并选择相应的指令集
check_operating_system(){
  CMD=("$(grep -i pretty_name /etc/os-release 2>/dev/null | cut -d \" -f2)"
       "$(hostnamectl 2>/dev/null | grep -i system | cut -d : -f2)"
       "$(lsb_release -sd 2>/dev/null)" "$(grep -i description /etc/lsb-release 2>/dev/null | cut -d \" -f2)"
       "$(grep . /etc/redhat-release 2>/dev/null)"
       "$(grep . /etc/issue 2>/dev/null | cut -d \\ -f1 | sed '/^[ ]*$/d')"
      )

  for i in "${CMD[@]}"; do SYS="$i" && [[ -n $SYS ]] && break; done

  REGEX=("debian" "ubuntu" "centos|red hat|kernel|oracle linux|amazon linux|alma|rocky")
  RELEASE=("Debian" "Ubuntu" "CentOS")
  PACKAGE_UPDATE=("apt -y update" "apt -y update" "yum -y update")
  PACKAGE_INSTALL=("apt -y install" "apt -y install" "yum -y install")
  PACKAGE_UNINSTALL=("apt -y autoremove" "apt -y autoremove" "yum -y autoremove")

  for ((int = 0; int < ${#REGEX[@]}; int++)); do
    [[ $(echo "$SYS" | tr '[:upper:]' '[:lower:]') =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && break
  done

  [[ -z $SYSTEM ]] && red " ERROR: The script supports Debian, Ubuntu, CentOS or Alpine systems only.\n" && exit 1
}

# 判断宿主机的 IPv4 或双栈情况,没有拉取不了 docker
check_ipv4(){
  ! curl -s4m8 ip.sb | grep -q '\.' && red " ERROR：The host must have IPv4. " && exit 1
}

# 判断 CPU 架构
check_virt(){
  ARCHITECTURE=$(uname -m)
  case "$ARCHITECTURE" in
    aarch64 ) ARCH=arm64v8;;
    x64|x86_64 ) ARCH=latest;;
    * ) red " ERROR: Unsupported architecture: $ARCHITECTURE\n" && exit 1;;
  esac
}

# 输入 bitping 的个人信息
input_token(){
  [ -z $EMAIL ] && reading " Enter your Email, if you do not find it, open https://app.bitping.com/?r=2RUmPa_f: " EMAIL 
  [ -z $PASSWORD ] && reading " Enter your Password: " PASSWORD
}

# 显示结果
result(){
  green " Finish \n"
}

# 卸载
uninstall(){
  kill -9 $(pgrep -f bitping)
  green "\n Uninstall complete.\n"
  rm -rf $HOME/.bitping/
  exit 0
}

# 传参
while getopts "UuM:m:P:p:" OPTNAME; do
  case "$OPTNAME" in
    'U'|'u' ) uninstall;;
    'M'|'m' ) EMAIL=$OPTARG;;
    'P'|'p' ) PASSWORD=$OPTARG;;
  esac
done

# 主程序
check_root
check_operating_system
check_ipv4
check_virt
input_token
ARCHH=$(uname -m)
case "$ARCHH" in
x86_64 ) ARCHITECTUREH="amd64";;
* ) ARCHITECTUREH="i386";;
esac
if [ $SYSTEM = "CentOS" ]; then
    yum update
    yum install -y wget
    if [ $ARCHITECTUREH = "amd64" ]; then
        rm -rf *bitping*
        yellow "Building"
        rm -rf bitping-node-amd64-linux*
        wget https://github.com/spiritLHLS/bitping-one-click-command-installation/raw/main/bitping-node-amd64-linux
        chmod 777 bitping-node-amd64-linux
        nohup ./bitping-node-amd64-linux --server --email "$EMAIL" --password "$PASSWORD" >/dev/null 2>&1
    else
        rm -rf *bitping*
        yellow "Building"
        rm -rf bitping-node-armv7-linux*
        wget https://github.com/spiritLHLS/bitping-one-click-command-installation/raw/main/bitping-node-armv7-linux
        chmod 777 bitping-node-armv7-linux
        nohup ./bitping-node-armv7-linux --server --email "$EMAIL" --password "$PASSWORD" >/dev/null 2>&1
    fi
else
    apt-get update
    apt-get install sudo -y
    apt-get install curl -y
    apt-get install wget -y
    if [ $ARCHITECTUREH = "amd64" ]; then
        rm -rf *bitping*
        yellow "Building"
        rm -rf bitping-node-amd64-linux*
        wget https://github.com/spiritLHLS/bitping-one-click-command-installation/raw/main/bitping-node-amd64-linux
        chmod 777 bitping-node-amd64-linux
        nohup ./bitping-node-amd64-linux --server --email "$EMAIL" --password "$PASSWORD" >/dev/null 2>&1
    else
        rm -rf *bitping*
        yellow "Building"
        rm -rf bitping-node-armv7-linux*
        wget https://github.com/spiritLHLS/bitping-one-click-command-installation/raw/main/bitping-node-armv7-linux
        chmod 777 bitping-node-armv7-linux
        nohup ./bitping-node-armv7-linux --server --email "$EMAIL" --password "$PASSWORD" >/dev/null 2>&1
    fi
    if [ $? -ne 0 ]; then
        red "NOT SUPPORT"
    else
        echo ""
    fi
fi
result
