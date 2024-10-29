#!/bin/bash

# 确认脚本以root权限运行
if [ "$(id -u)" -ne 0 ]; then
    echo "脚本需要以root权限运行，请使用sudo或者以root身份运行。"
    exit 1
fi

# 检查是否有足够的磁盘空间用于创建新的swap文件
required_space=4G  # 您可以根据需要调整大小
available_space=$(df / | tail -1 | awk '{print $4}')
available_space_human=$(df -h / | tail -1 | awk '{print $4}')

if [ "$available_space" -lt "$(numfmt --from=iec $required_space)" ]; then
    echo "磁盘空间不足，需要至少 $required_space 可用空间。"
    exit 1
fi

# 创建swap文件
swapfile=/swapfile

# 检查swapfile是否已经存在
if [ -f $swapfile ]; then
    echo "swap文件已经存在，请先删除或者使用不同的文件名。"
    exit 1
fi

# 创建指定大小的swap文件
echo "创建 $required_space 大小的swap文件..."
fallocate -l $required_space $swapfile

# 设置合适的权限
chmod 600 $swapfile

# 设置swap文件系统
mkswap $swapfile

# 启用swap文件
swapon $swapfile

# 确认新swap文件是否已激活
if swapon --show | grep -q $swapfile; then
    echo "swap文件成功创建并激活。"
else
    echo "无法激活swap文件，请检查。"
    exit 1
fi

# 备份/etc/fstab文件
echo "备份/etc/fstab文件..."
cp /etc/fstab /etc/fstab.bak

# 将新swap文件添加到/etc/fstab中
echo "$swapfile none swap sw 0 0" >> /etc/fstab

# 确认/etc/fstab是否更新成功
if grep -q $swapfile /etc/fstab; then
    echo "swap文件成功添加到/etc/fstab。"
else
    echo "无法将swap文件添加到/etc/fstab，请检查。"
    exit 1
fi

echo "swap已配置并激活。"
exit 0