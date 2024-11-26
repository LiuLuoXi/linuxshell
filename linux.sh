#!/bin/bash

# @QiuNing

# 函数：显示主菜单
main_menu() {
    clear
    echo "=== XFYShell终端 ==="
    server_ip=$(curl -s ifconfig.me)
    echo "服务器IP地址: $server_ip"
    echo "1. 系统操作菜单"
    echo "2. 网络操作菜单"
    echo "3. 其他操作菜单"
    echo "q. 退出"
    echo "======================="
    read -p "请输入选项: " choice
    case $choice in
        1) system_menu ;;
        2) network_menu ;;
        3) other_menu ;;
        q) exit ;;
        *) echo "无效的选项，请重新输入" ;;
    esac
    main_menu
}

# 函数：系统操作菜单
system_menu() {
    clear
    echo "=== 系统操作菜单 ==="
    echo "1. 一键重启服务器"
    echo "2. 一键修改密码"
    echo "3. 一键同步上海时间"
    echo "4. 一键更新CentOS最新版系统"
    echo "5. 一键更新Ubuntu最新版系统"
    echo "6. 一键更新Debian最新版系统"
    echo "7. 一键安装firewalld防火墙"
    echo "8. 一键重载firewalld防火墙"
    echo "9. 一键关闭firewalld防火墙"
    echo "10. 永久关闭firewalld防火墙"
    echo "11. 一键更换CentOS yum 源"
    echo "12. 一键更换Ubuntu apt 源"
    echo "13. 一键更换Debian apt 源"
    echo "14. 一键挂载数据盘"
    echo "q. 返回上级菜单"
    echo "===================="
    read -p "请输入选项: " option
    case $option in
        1) reboot_server ;;
        2) change_password ;;
        3) sync_time ;;
        4) update_centos ;;
        5) update_ubuntu ;;
        6) update_debian ;;
        7) install_firewalld ;;
        8) Reboot_firewalld ;;
        9) off_firewalld ;;
        10) foreveroff_firewalld ;;
        11) change_CentOS_source ;;
        12) change_Ubuntu _source ;;
        13) change_debian_source ;;
        14) mount_data_disk ;;
        q) main_menu ;;
        *) echo "无效的选项，请重新输入" ;;
    esac
    system_menu
}

# 函数：一键重启服务器
reboot_server() {
    read -p "确认要重启服务器吗？(y/n): " choice
    if [ "$choice" = "y" ]; then
        echo "正在重启服务器..."
        sudo reboot
    else
        echo "取消重启操作"
    fi
    system_menu
}

# 函数：一键修改密码
change_password() {
    echo "正在执行更改用户 root 的密码"
    
    # 循环直到密码一致为止
    while true; do
        read -s -p "新的密码: " new_password
        echo
        read -s -p "重新输入新的密码: " confirm_password
        echo

        if [ "$new_password" = "$confirm_password" ]; then
            echo "$new_password" | sudo passwd --stdin root
            echo "密码已成功修改"
            echo "正在重启服务器..."
            sudo reboot
            break
        else
            echo "两次输入的密码不一致，请重新输入。"
        fi
    done
}

# 函数：一键同步上海时间
sync_time() {
    install_ntpdate
    echo "正在同步上海时间..."
    sudo timedatectl set-timezone Asia/Shanghai
    sudo ntpdate cn.pool.ntp.org
    echo "时间同步完成。"
    read -p "按回车键继续..."
    system_menu
}

# 检查并安装ntpdate
install_ntpdate() {
    if ! command -v ntpdate &> /dev/null; then
        echo "正在安装ntpdate..."
        if [ -f /etc/redhat-release ]; then
            sudo yum install -y ntpdate
        elif [ -f /etc/debian_version ]; then
            sudo apt-get install -y ntpdate
        else
            echo "不支持的操作系统类型。"
            exit 1
        fi
        echo "ntpdate安装完成。"
    fi
}

# 函数：一键更新CentOS最新版系统
update_centos() {
    read -p "确认要更新 CentOS 最新版系统吗？(y/n): " choice
    if [ "$choice" = "y" ]; then
        echo "正在更新 CentOS 最新版系统..."
        sudo yum update -y
        echo "CentOS 最新版系统更新完成。"
        
        read -p "更新完成，是否重启服务器？(y/n): " reboot_choice
        if [ "$reboot_choice" = "y" ]; then
            sudo reboot
        else
            echo "取消重启服务器。"
        fi
    else
        echo "取消更新操作"
    fi
    read -p "按回车键继续..."
    system_menu
}

# 函数：一键更新Ubuntu最新版系统
update_ubuntu() {
    read -p "确认要更新 Ubuntu 最新版系统吗？(y/n): " choice
    if [ "$choice" = "y" ]; then
        echo "正在更新 Ubuntu 最新版系统..."
        sudo apt update
        sudo apt upgrade -y
        echo "Ubuntu 最新版系统更新完成。"
        
        read -p "更新完成，是否重启服务器？(y/n): " reboot_choice
        if [ "$reboot_choice" = "y" ]; then
            sudo reboot
        else
            echo "取消重启服务器。"
        fi
    else
        echo "取消更新操作"
    fi
    read -p "按回车键继续..."
    system_menu
}

# 函数：一键更新Debian最新版系统
update_debian() {
    read -p "确认要更新 Debian 最新版系统吗？(y/n): " choice
    if [ "$choice" = "y" ]; then
        echo "正在更新 Debian 最新版系统..."
        sudo apt update
        sudo apt upgrade -y
        echo "Debian 最新版系统更新完成。"
        
        read -p "更新完成，是否重启服务器？(y/n): " reboot_choice
        if [ "$reboot_choice" = "y" ]; then
            sudo reboot
        else
            echo "取消重启服务器。"
        fi
    else
        echo "取消更新操作"
    fi
    read -p "按回车键继续..."
    system_menu
}

# 函数：一键安装防火墙
install_firewalld() {
    read -p "确认要安装 firewalld 防火墙吗？(y/n): " choice
    if [ "$choice" = "y" ]; then
        echo "正在安装 firewalld 防火墙..."
        sudo yum install firewalld
        echo "firewalld 防火墙安装完成。"
    else
        echo "取消安装操作"
    fi
    read -p "按回车键继续..."
    system_menu
}

# 函数：一键重载防火墙
Reboot_firewalld() {
    read -p "确认要重载 firewalld 防火墙吗？(y/n): " choice
    if [ "$choice" = "y" ]; then
        echo "正在重载 firewalld 防火墙..."
        sudo firewall-cmd --reload
        echo "firewalld 防火墙重载完成。"
    else
        echo "取消重载操作"
    fi
    read -p "按回车键继续..."
    system_menu
}

# 函数：一键关闭防火墙
off_firewalld() {
    read -p "确认要关闭 firewalld 防火墙吗？(y/n):" choice
    if [ "$choice" = "y" ]; then
        echo "正在关闭 firewalld 防火墙..."
        sudo systemctl stop firewalld
        echo "firewalld 防火墙已关闭。"
    else
        echo "取消关闭操作"
    fi
    read -p "按回车键继续..."
    system_menu
}

# 函数：永久关闭防火墙
foreveroff_firewalld() {
    read -p "确认要永久关闭 firewalld 防火墙吗？(y/n): " choice
    if [ "$choice" = "y" ]; then
        echo "正在永久关闭 firewalld 防火墙..."
        sudo systemctl disable firewalld
        echo "firewalld 防火墙已永久关闭。"
    else
        echo "取消永久关闭操作"
    fi
    read -p "按回车键继续..."
    system_menu
}

# 函数：一键更换CentOS yum源
change_CentOS_source() {
    echo "正在更换 CentOS yum 源..."
    sudo yum install -y epel-release
    sudo yum install -y wget
    sudo wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
    sudo yum clean all
    sudo yum makecache
    echo "CentOS yum 源已成功更换为阿里云源"
    read -p "按回车键继续..."
    system_menu
}

# 函数：一键更换Ubuntu apt源
change_Ubuntu_source() {
    echo "正在更换 Ubuntu apt 源..."
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
    sudo apt update
    echo "Ubuntu apt 源已成功更换为阿里云源"
    read -p "按回车键继续..."
    system_menu
}

# 函数：一键更换Debian apt源
change_debian_source() {
    echo "正在更换 Debian apt 源..."
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo sed -i 's/http:\/\/deb.debian.org/http:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list
    sudo apt update
    echo "Debian apt 源已成功更换为阿里云源"
    read -p "按回车键继续..."
    system_menu
}

# 挂载数据盘
mount_data_disk() {
    # 确定数据盘设备名
    read -p "请输入数据盘设备名[默认：/dev/vdb1]: " disk_device
    disk_device=${disk_device:-"/dev/vdb1"}

    # 确定挂载点目录
    read -p "请输入挂载点目录[默认：/data]: " mount_point
    mount_point=${mount_point:-"/data"}

    # 检查挂载点目录是否存在
    if [ ! -d "$mount_point" ]; then
        # 挂载点目录不存在，创建目录
        sudo mkdir "$mount_point"
    fi

    # 检查数据盘是否已经被挂载
    if grep -qs "$disk_device" /proc/mounts; then
        echo "数据盘 $disk_device 已经被挂载"
        return
    fi

    # 检查数据盘是否存在
    if [ ! -e "$disk_device" ]; then
        echo "数据盘 $disk_device 不存在"
        return
    fi

    # 挂载数据盘
    sudo mount "$disk_device" "$mount_point"
    echo "数据盘 $disk_device 成功挂载到 $mount_point"
    
    # 将数据盘添加到 /etc/fstab 实现开机自动挂载
    echo "$mount_path $mount_point ext4 defaults 0 2" | sudo tee -a /etc/fstab

    echo "数据盘已成功挂载到 $mount_point，并已设置为开机自动挂载。"
    read -p "按回车键继续..."
    system_menu
}

# 函数：网络操作菜单
network_menu() {
    clear
    echo "=== 网络操作菜单 ==="
    echo "1. 一键重启网卡"
    echo "2. 一键开启/关闭Ping"
    echo "3. 一键查看服务器地理位置"
    echo "4. 一键查看服务器IP原生地址"
    echo "5. 一键查看服务器配置信息"
    echo "6. 一键检测服务器是否屏蔽UDP"
    echo "q. 返回上级菜单"
    echo "===================="
    read -p "请输入选项: " option
    case $option in
        1) reboot_network ;;
        2) toggle_ping ;;
        3) check_geo_location ;;
        4) check_ip_address ;;
        5) check_server_info ;;
        6) check_udp_block ;;
        q) main_menu ;;
        *) echo "无效的选项，请重新输入" ;;
    esac
    network_menu
}

# 函数：一键重启网卡
reboot_network() {
    echo "正在重启网卡..."
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        os=$ID
    elif [ -f /etc/centos-release ]; then
        os="centos"
    else
        echo "Unsupported operating system."
        return
    fi

    if [ "$os" == "debian" ]; then
        sudo systemctl restart networking
    elif [ "$os" == "ubuntu" ]; then
        sudo systemctl restart networkd-dispatcher
    elif [ "$os" == "centos" ]; then
        sudo service network restart
    else
        echo "Unsupported operating system."
        return
    fi

    echo "网卡已重启"
    read -p "按回车键继续..."
    network_menu
}

# 函数：一键开启/关闭Ping
toggle_ping() {
    read -p "开启或关闭Ping？(1(开启)/0(关闭)): " choice
    if [ "$choice" = "1" ]; then
        if [ "$(sysctl -n net.ipv4.icmp_echo_ignore_all)" = "1" ]; then
            echo "正在开启Ping..."
            sudo sysctl -w net.ipv4.icmp_echo_ignore_all=0
            echo "已开启Ping。"
        else
            echo "Ping已经处于开启状态。"
        fi
    elif [ "$choice" = "0" ]; then
        if [ "$(sysctl -n net.ipv4.icmp_echo_ignore_all)" = "0" ]; then
            echo "正在关闭Ping..."
            sudo sysctl -w net.ipv4.icmp_echo_ignore_all=1
            echo "已关闭Ping。"
        else
            echo "Ping已经处于关闭状态。"
        fi
    else
        echo "无效的选项，请重新输入。"
    fi
    read -p "按回车键继续..."
    network_menu
}

# 函数：一键查看服务器地理位置
check_geo_location() {
    echo "正在查看服务器地理位置..."
    curl iplark.com
    read -p "按回车键继续..."
    network_menu
}

# 函数：一键查看服务器IP原生地址
check_ip_address() {
    echo "正在查看服务器IP原生地址..."
    curl  -w "\n" ifconfig.me
    read -p "按回车键继续..."
    network_menu
}

# 函数：一键查看服务器配置信息
check_server_info() {
    echo "=== 服务器配置信息 ==="
    echo "CPU核心数:"
    lscpu | grep -w "CPU(s):" | grep -v "\-"
    lscpu | grep -w "Model name:"
    echo "CPU频率:"
    lscpu | grep -w "CPU MHz"
    echo "虚拟化类型:"
    lscpu | grep -w "Hypervisor vendor:"
   echo "系统版本:"
    if [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        echo "Ubuntu $DISTRIB_RELEASE"
    elif [ -f /etc/debian_version ]; then
        DEBIAN_VERSION=$(cat /etc/debian_version)
        echo "Debian $DEBIAN_VERSION"
    elif [ -f /etc/centos-release ]; then
        CENTOS_VERSION=$(cat /etc/centos-release)
        echo "CentOS $CENTOS_VERSION"
    else
        echo "无法识别的系统类型"
    fi
    echo "内存信息:"
    free -h
    echo "硬盘信息:"
    df -h
    echo
    read -p "按回车键继续..."
    network_menu
}

# 函数：一键检测服务器是否屏蔽UDP
check_udp_block() {
    echo "正在检测UDP是否被屏蔽..."
    result=$(sudo iptables -L | grep -E "Chain (INPUT|OUTPUT|FORWARD).*udp" | wc -l)
    if [ $result -gt 0 ]; then
        echo "UDP未屏蔽"
    else
        echo "UDP被屏蔽"
    fi
    echo
    read -p "按回车键继续..."
    network_menu
}

# 函数：其他操作菜单
other_menu() {
    clear
    echo "=== 其他操作菜单 ==="
    echo "1. 一键安装宝塔面板"
    echo "2. 一键安装X-UI面板"
    echo "3. 一键安装MTproto代理"
    echo "4. 一键测试带宽网速"
    echo "5. 一键测试回程路由"
    echo "q. 返回上级菜单"
    echo "===================="
    read -p "请输入选项: " option
    case $option in
        1) install_bt_panel ;;
        2) install_xui_panel ;;
        3) install_mtproto_proxy ;;
        4) test_bandwidth_speed ;;
        5) test_traceroute ;;
        q) main_menu ;;
        *) echo "无效的选项，请重新输入" ;;
    esac
    other_menu
}

# 函数：一键安装宝塔面板
install_bt_panel() {
    echo "正在安装宝塔面板..."
    if [ -x "$(command -v yum)" ]; then
        yum install -y wget && wget -O install.sh https://download.bt.cn/install/install_6.0.sh && sh install.sh ed8484bec
    elif [ -x "$(command -v apt)" ]; then
        if [ -f /etc/os-release ]; then
            if grep -q "Ubuntu" /etc/os-release; then
                wget -O install.sh https://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh ed8484bec
            elif grep -q "Debian" /etc/os-release; then
                wget -O install.sh https://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh ed8484bec
            else
                echo "未知的Ubuntu或Debian系统版本，无法安装宝塔面板。"
            fi
        else
            echo "未知的Linux发行版，无法安装宝塔面板。"
        fi
    else
        echo "不支持的系统，无法安装宝塔面板。"
    fi
    echo "宝塔面板安装完成。"
    read -p "按回车键继续..."
    other_menu
}

# 函数：一键安装X-UI面板
install_xui_panel() {
    echo "正在安装X-UI面板..."
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
    echo "X-UI面板安装完成。"
    read -p "按回车键继续..."
    other_menu
}

# 函数：一键安装MTproto代理
install_mtproto_proxy() {
    echo "正在安装MTproto代理..."
    if [ -x "$(command -v yum)" ]; then
        sudo yum install -y wget
    elif [ -x "$(command -v apt)" ]; then
        sudo apt update
        sudo apt install -y wget
    else
        echo "不支持的系统，无法安装MTproto代理。"
        return
    fi
    
    mkdir /home/mtproxy && cd /home/mtproxy
    curl -s -o mtproxy.sh https://raw.githubusercontent.com/ellermister/mtproxy/master/mtproxy.sh && chmod +x mtproxy.sh && bash mtproxy.sh
    
    echo "MTproto代理安装完成。"
    read -p "按回车键继续..."
    other_menu
}

# 函数：一键测试带宽网速
test_bandwidth_speed() {
    echo "正在测试带宽网速..."
    bash <(wget -qO- https://down.vpsaff.net/linux/speedtest/superbench.sh) --speed
    echo "带宽网速测试完成。"
    read -p "按回车键继续..."
    other_menu
}

# 函数：一键测试回程路由
test_traceroute() {
    wget -qO- git.io/besttrace | bash
    read -p "按回车键继续..."
    other_menu
}

# 主程序入口
main_menu